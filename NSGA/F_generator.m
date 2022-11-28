function newpopulation = F_generator(population,maxvalue,minvalue,functionvalue,frontvalue,kneepoint)
%�����ѡ��,����,���첢�����µ���Ⱥ

    [popnum,poplength]=size(population);
    
    %�Ŵ���������
    rate_c=1;               %�������
    rate_m=1.0/poplength;	%�������
    para_c=20;              %�������
    para_m=20;              %�������

    %����ÿ�������ܶ�
    k=3;
    distance=zeros(popnum);                                 %�洢ÿ��������ľ���
    for i=1:popnum
        distance(i,i)=inf;
        for j=i+1:popnum
            distance(i,j)=sqrt(sum((functionvalue(i,:)-functionvalue(j,:)).^2));
            distance(j,i)=distance(i,j); 
        end
    end
    distance=sort(distance,2);
    a = distance(:,1:k);
    b = repmat(k:-1:1,popnum,1);
	crowd=sum(distance(:,1:k).*repmat(k:-1:1,popnum,1),2);	%�洢�����ܶ�(Խ��Խ��)
    
    %����ÿ��������ۺ���Ӧ��
    fitness=[frontvalue',-kneepoint',-crowd];
    [nul,rank]=sortrows(fitness);
    fitness(rank)=1:popnum;                 %�ۺ���Ӧ��ԽСԽ��   
    
    %ģ������ƽ���
    newpopulation=zeros(popnum,poplength);  %�Ӵ���Ⱥ
    generatednum=0;                         %�Ѳ����Ӵ�������
    rank=randperm(popnum);                  %�����ĸ����
    local=1;                                %��ǰ��ĸλ��
    while generatednum<popnum
        %ѡ��ĸ
        for i=1:2                           %ÿ�β��ö�Ԫ����ѡ��һ������
            if local>=popnum                %����ĸ�����þ�ʱ,���������һ������
                rank=randperm(popnum);
                local=1;
            end
            if fitness(rank(local))<fitness(rank(local+1))
                k(i)=rank(local);
            else
                k(i)=rank(local+1);
            end
            local=local+2;
        end
        %ִ�н���
        if rand<=rate_c
            beta=zeros(1,poplength);
            miu=rand(1,poplength);
            beta(miu<=0.5)=(2*miu(miu<=0.5)).^(1/(para_c+1));
            beta(miu>0.5)=(2-2*miu(miu>0.5)).^(-1/(para_c+1));
            beta=beta.*(-1).^randi([0,1],1,poplength);
            newpopulation(generatednum+1,:)=(population(k(1),:)+population(k(2),:))./2+beta.*(population(k(1),:)-population(k(2),:))./2;         
            newpopulation(generatednum+2,:)=(population(k(1),:)+population(k(2),:))./2-beta.*(population(k(1),:)-population(k(2),:))./2;
            generatednum=generatednum+2;

%             y1=min(population(k(1),:),population(k(2),:));
%             y2=max(population(k(1),:),population(k(2),:));
%             beta=2-(1+2*(y1-minvalue)./(y2-y1)).^(-para_c-1);
%             miu=rand(1,length(beta));
%             temp1=find(miu<=1./beta);
%             temp2=find(miu>1./beta);
%             beta(temp1)=(beta(temp1).*miu(temp1)).^(1/(para_c+1));
%             beta(temp2)=(2-beta(temp2).*miu(temp2)).^(-1/(para_c+1));
%             c1=1/2*(y1+y2+beta.*(y1-y2));
%             beta=2-(1+2*(maxvalue-y2)./(y2-y1)).^(-para_c-1);
%             temp1=find(miu<=1./beta);
%             temp2=find(miu>1./beta);
%             beta(temp1)=(beta(temp1).*miu(temp1)).^(1/(para_c+1));
%             beta(temp2)=(2-beta(temp2).*miu(temp2)).^(-1/(para_c+1));
%             c2=1/2*(y1+y2+beta.*(y2-y1));
%             miu=rand(1,length(beta));
%             temp1=find(miu<=0.5);
%             temp2=find(miu>0.5);
%             newpopulation(generatednum+1,temp1)=c1(temp1);
%             newpopulation(generatednum+1,temp2)=c2(temp2);
%             newpopulation(generatednum+2,temp1)=c2(temp1);
%             newpopulation(generatednum+2,temp2)=c1(temp2);           
%             temp=find(roundn(y1,-6)==roundn(y2,-6));
%             newpopulation(generatednum+1,temp)=y1(temp);
%             newpopulation(generatednum+2,temp)=y1(temp);
%             generatednum=generatednum+2;
        end
    end
    
    %Խ�紦��
    maxvalue=repmat(maxvalue,popnum,1);
    minvalue=repmat(minvalue,popnum,1);
    newpopulation(newpopulation>maxvalue)=maxvalue(newpopulation>maxvalue);
    newpopulation(newpopulation<minvalue)=minvalue(newpopulation<minvalue);
    
    %����ʽ����
    k=rand(size(newpopulation));
    miu=rand(size(newpopulation));
    temp=k<=rate_m & miu<0.5;
    newpopulation(temp)=newpopulation(temp)+(maxvalue(temp)-minvalue(temp)).*((2.*miu(temp)+(1-2.*miu(temp)).*(1-(newpopulation(temp)-minvalue(temp))./(maxvalue(temp)-minvalue(temp))).^(para_m+1)).^(1/(para_m+1))-1);
    temp=k<=rate_m & miu>=0.5;    
    newpopulation(temp)=newpopulation(temp)+(maxvalue(temp)-minvalue(temp)).*(1-(2.*(1-miu(temp))+2.*(miu(temp)-0.5).*(1-(maxvalue(temp)-newpopulation(temp))./(maxvalue(temp)-minvalue(temp))).^(para_m+1)).^(1/(para_m+1)));

    %Խ�紦��
    newpopulation(newpopulation>maxvalue)=maxvalue(newpopulation>maxvalue);
    newpopulation(newpopulation<minvalue)=minvalue(newpopulation<minvalue);
end

