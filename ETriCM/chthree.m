 function [convexhullareaETriCMtrain,convexhullareaETriCMtest,firstfronttrain,firstfronttest]=chthree(A,Distb,source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest)
%��������chthreeʹ��ch-3�㷨���������Լ���ѵ������͹�������

population=source;%����ʼ�㼯��������
evaluation=population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
 % [tpr,fpr]  =  Evaluation(evaluation,whethertrain);%%����Ŀ�꺯��
results=[fpr,tpr];
origin=results;

firstFrontStart = [];
firstFrontEnd   = [];

m=1;
t=1;
countnumber=1;
%ѵ��
while m <= Maxfit
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
    
    newpopulation=[population;newpopulation];
    evaluation=newpopulation*datasettrain*10^(-3);
    evaluation((evaluation>=confidencelevel))=1;
    evaluation((evaluation<confidencelevel))=0;
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
    %  [tpr,fpr]  =  Evaluation(evaluation,whethertrain);%%����Ŀ�꺯��
    results=[fpr,tpr];
    [U,R]=splitpopulation(results);
    if size(U,1)<=popnum
        resultstemp=[];
        number=randperm(size(R,1));
        resultstemp=[U;R(number(1:popnum-size(U,1)),:)];     
    else
        resultstemp=[];
        resultstemp=Reduce(U,size(results,1)-popnum);%15��16������
    end
    %�ҳ�resultstemp�е�ֵ��results�е����,�������֮ǰд��ɾ��pareto���еĵ�ĺ���
    number=findsequence(resultstemp,results);
    %number=unique(number,'rows');
    population=newpopulation(number,:);
    
    if m == 1
        [firstFrontStart,~]=areaoftest(population,datasettest,confidencelevel,whethertest);
    end
    

         %�����Ŷ�����Ͱ뾶
%     
 [index,~,~]=areaoftest(population,datasettrain,confidencelevel,whethertrain);%�����ǰ�����ϵĸ���      
       Archive=population(index,:);      
       nonindex=setdiff((1:100)',index,'rows');  
        nonarchive=population(nonindex,:);           
       nonarchive_central_point=sum(nonarchive,1)/size(nonarchive,1);%���ⲿ�ĵ����ĵ�
           B=nonarchive_central_point;
           direction=A-B;%�Ŷ�����
           NN=size(nonarchive,1);
           M=size(nonarchive,2);
           Similarity=zeros(NN,1);
           step=zeros(NN,1);
           disturb=zeros(NN,M);
            X1=[B;A];
            Sim=1-pdist(real(X1),'cosine');      
            DisC=(Sim+Distb)/2;    %�Ŷ�ϵ��           
      for r=1:NN
          CC=nonarchive(r,:);
          X=[CC;A];
          Similarity(r,:)=1-pdist(X,'cosine');
          step(r,:)=(Similarity(r,:)+Distb)*DisC;
          disturb(r,:)=step(r,:)*direction;
      end   
         newnonarchive=nonarchive+disturb;%�Ŷ�������Ⱥ               
         %%     
     population=[Archive;newnonarchive];           
     m=m+1;


    [firstfronttrain,area]=area_test(population,datasettrain,confidencelevel,whethertrain);
    convexhullareaETriCMtrain(countnumber,1)=area;
    
    [firstfronttest,sum2]=area_test(population,datasettest,confidencelevel,whethertest);
    convexhullareaETriCMtest(countnumber,1)=sum2;
    
   countnumber=countnumber+1;
  % disp(['it is chthree: ' num2str(m)]);
end

end


