% function [tempfunctionvalue,firstfront]=NSGAII(population,popnum,Maxfit,confidencelevel,dataset,whether,poplength,minvalue,maxvalue,fanwei)
function [convexhullarea]=NSGAII(population,popnum,Maxfit,confidencelevel,whether,poplength,minvalue,maxvalue,fanwei,dataset)
   
    evaluationnum=0;
    %%
%---��ʼ��������

    countnumber2=1;
    convexhullarea=[];
    while evaluationnum<Maxfit                    %��ʼ����
%-------���� 
        newpopulation=zeros(popnum,poplength);  %�Ӵ���Ⱥ
        for i=1:popnum/2                        %��������Ӵ�
            k=randperm(popnum);                 %����Ⱥ�����ѡ��������ĸ,�����ö�������������,randperm�������һ����������
            beta=(-1).^round(rand(1,poplength)).*abs(randn(1,poplength))*1.481; %������̬�ֲ�������������Ӵ�
            newpopulation(i*2-1,:)=(population(k(1),:)+population(k(2),:))/2+beta.*(population(k(1),:)-population(k(2),:))./2;    %������һ���Ӵ�           
            newpopulation(i*2,:)=(population(k(1),:)+population(k(2),:))/2-beta.*(population(k(1),:)-population(k(2),:))./2;      %�����ڶ����Ӵ�
        end
        
%-------����        
        k=rand(size(newpopulation));    %���ѡ��Ҫ����Ļ���λ
        miu=rand(size(newpopulation));  %���ö���ʽ����
        temp=k<1/poplength & miu<0.5;   %Ҫ����Ļ���λ
        newpopulation(temp)=newpopulation(temp)+(maxvalue(temp)-minvalue(temp)).*((2.*miu(temp)+(1-2.*miu(temp)).*(1-(newpopulation(temp)-minvalue(temp))./(maxvalue(temp)-minvalue(temp))).^21).^(1/21)-1);        %�������һ
        newpopulation(temp)=newpopulation(temp)+(maxvalue(temp)-minvalue(temp)).*(1-(2.*(1-miu(temp))+2.*(miu(temp)-0.5).*(1-(maxvalue(temp)-newpopulation(temp))./(maxvalue(temp)-minvalue(temp))).^21).^(1/21));  %���������
        
%-------Խ�紦��/��Ⱥ�ϲ�        
        newpopulation(newpopulation>maxvalue)=maxvalue(newpopulation>maxvalue); %�Ӵ�Խ�Ͻ紦��
        newpopulation(newpopulation<minvalue)=minvalue(newpopulation<minvalue); %�Ӵ�Խ�½紦��
        newpopulation=[population;newpopulation];                               %�ϲ�������Ⱥ
        
% %-------����Ŀ�꺯��ֵ        
%         functionvalue=zeros(size(newpopulation,1),2);           %�ϲ�����Ⱥ�ĸ�Ŀ�꺯��ֵ,�����������ZDT1
%         functionvalue(:,1)=newpopulation(:,1);                  %�����һάĿ�꺯��ֵ
%         g=1+9*sum(newpopulation(:,2:poplength),2)./(poplength-1);           %Ϊʲô����Ҫ����9
%         functionvalue(:,2)=g.*(1-(newpopulation(:,1)./g).^0.5); %����ڶ�άĿ�꺯��ֵ

%1:SCH
%2:FON
%3:POL
%4:KUR
%5:ZDT1
%6:ZDT2
%7:ZDT3
%8:ZDT4
%9:ZDT6

%         functionvalue=benchmarkformob(newpopulation,9);
        evaluation=newpopulation*dataset*10^(-3);
        
        %��ʱ������ֵС��0.9���ж�Ϊ������
        evaluation(find(evaluation>=confidencelevel))=1;
        evaluation(find(evaluation<confidencelevel))=0;
%         newpopulation=[newpopulation;a];%��ֹ��Ϊ���еĵ㹲�߶��޷�����͹��

        [tpr,fpr]=calculatetprandfpr(evaluation,whether);
%         tpr=-tpr;
        functionvalue=[fpr,tpr];%
        
%         functionvalue=benchmarkformob(newpopulation,9);

%-------��֧������        
        fnum=0;                                             %��ǰ�����ǰ������
        cz=false(1,size(functionvalue,1));                  %��¼�����Ƿ��ѱ�������
        frontvalue=zeros(size(cz));                         %ÿ�������ǰ������
        [functionvalue_sorted,newsite]=sortrows(functionvalue);    %����Ⱥ����һάĿ��ֵ��С��������
        while ~all(cz)                                      %��ʼ�����ж�ÿ�������ǰ����,���øĽ���deductive sort   all(),���ȫ��������0���ͷ���1�����򣬷���0�������һ����0�������ѭ����
            fnum=fnum+1;
            d=cz;
            for i=1:size(functionvalue,1)
                if ~d(i)
                    for j=i+1:size(functionvalue,1)
                        if ~d(j)
                            k=1;                            
                            for m=2:size(functionvalue,2)
                                if functionvalue_sorted(i,m)<functionvalue_sorted(j,m)%����Ϊ��classification�Ķ���
                                    k=0;
                                    break
                                end
                            end
                            if k
                                d(j)=true;   %˵��i�ǿ���֧��j�ģ������¼j�Ѿ������䣬����j�϶�������һ��ġ�
                            end
                        end
                    end
                    frontvalue(newsite(i))=fnum;
                    cz(i)=true;  %ֻ���޷��������ĵ�֧��ĵ����������һ��
                end
            end
        end
        
%-------����ӵ������/ѡ����һ������        
        fnum=0;                                                                 %��ǰǰ����
        while numel(frontvalue,frontvalue<=fnum+1)<=popnum                      %�ж�ǰ���ٸ���ĸ�������ȫ������һ����Ⱥ
            fnum=fnum+1;
        end        
        newnum=numel(frontvalue,frontvalue<=fnum);                              %ǰfnum����ĸ�����
        tempfunctionvalue(1:newnum,:)=functionvalue(frontvalue<=fnum,:); 
        population(1:newnum,:)=newpopulation(frontvalue<=fnum,:);               %��ǰfnum����ĸ��帴������һ��                       
        popu=find(frontvalue==fnum+1);                                          %popu��¼��fnum+1�����ϵĸ�����
        distancevalue=zeros(size(popu));                                        %popu�������ӵ������
        fmax=max(functionvalue(popu,:),[],1);                                   %popuÿά�ϵ����ֵ
        fmin=min(functionvalue(popu,:),[],1);                                   %popuÿά�ϵ���Сֵ
        for i=1:size(functionvalue,2)                                           %��Ŀ�����ÿ��Ŀ����popu�������ӵ������
            [~,newsite]=sortrows(functionvalue(popu,i));
            distancevalue(newsite(1))=inf;
            distancevalue(newsite(end))=inf;
            for j=2:length(popu)-1
                distancevalue(newsite(j))=distancevalue(newsite(j))+(functionvalue(popu(newsite(j+1)),i)-functionvalue(popu(newsite(j-1)),i))/(fmax(i)-fmin(i));
            end
        end                                      
        popu=-sortrows(-[distancevalue;popu]')';                                %��ӵ�����뽵�������fnum+1�����ϵĸ���
        population(newnum+1:popnum,:)=newpopulation(popu(2,1:popnum-newnum),:);	%����fnum+1������ӵ������ϴ��ǰpopnum-newnum�����帴������һ�� 
        tempfunctionvalue(newnum+1:popnum,:)=functionvalue(popu(2,1:popnum-newnum),:);%tempfunctionvalue������¼����������Ŀ�꺯��ֵ
        evaluationnum=evaluationnum+popnum/2;
%         firstfront=functionvalue(frontvalue==1,:); 


        tempa=zeros(1,2);
        tempa(1,1)=1;
        tempa(1,2)=1;
    
        tempb=zeros(1,2);
        tempb(1,1)=0;
        tempb(1,2)=0;

        pareto=chraarea(tempfunctionvalue);
        pareto=[pareto;tempa;tempb];%����������뵽��Ⱥ�У�ʹ�ü���������������ȷ
        area=calculatearea(pareto);
        convexhullarea(countnumber2,1)=area;
        countnumber2=countnumber2+1;
        
    end

end

