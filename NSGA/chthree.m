 function [convexhullareaETriCMtrain,convexhullareaETriCMtest,firstfronttrain,firstfronttest]=chthree(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest)
%��������chthreeʹ��ch-3�㷨���������Լ���ѵ������͹�������
tic;
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
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
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
        resultstemp=Reduce(U,size(results,1)-popnum);
    end
    %�ҳ�resultstemp�е�ֵ��results�е����,�������֮ǰд��ɾ��pareto���еĵ�ĺ���
    number=findsequence(resultstemp,results);
    %number=unique(number,'rows');
    population=newpopulation(number,:);
    
    if m == 1
        [firstFrontStart,~]=areaoftest(population,datasettest,confidencelevel,whethertest);
    end
    
    m=m+popnum/2;
    t=t+1;
    tempa=zeros(1,2);
    tempa(1,1)=1;
    tempa(1,2)=1;
    tempb=zeros(1,2);
    tempb(1,1)=0;
    tempb(1,2)=0;
    pareto=chraarea(resultstemp);
    pareto=[pareto;tempa;tempb];%����������뵽��Ⱥ�У�ʹ�ü���������������ȷ
    sum=calculatearea(pareto);
    convexhullareaETriCMtrain(countnumber,1)=sum;
    
    [temp,sum]=areaoftest(population,datasettest,confidencelevel,whethertest);
    convexhullareaETriCMtest(countnumber,1)=sum;
    
   countnumber=countnumber+1;
   disp(['it is chthree: ' num2str(m)]);
end

firstFrontEnd = temp;
firstfronttrain=pareto;
firstfronttest=temp;

firstfronttrain(size(firstfronttrain,1)-1:size(firstfronttrain,1),:)=[];
firstfronttest(size(firstfronttest,1)-1:size(firstfronttest,1),:)=[];

end


