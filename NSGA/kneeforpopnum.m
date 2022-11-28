%���������ű���Ϊ�˲���popnum��knee��Ӱ�������д��
clc
clear all

% popnum=100; %��Ⱥ��С(��Ϊż��)
confidencelevel=0;%Ԥֵ
Maxfit=30000;%����������

Allarea={};
[dataset,whether]=inputdataset(1);%datasetnumber����ǰ���Ե����ݼ�
convexhullkneetrain=[];
convexhullkneetest=[];
rate=0.4;
poplength=size(dataset,1);%��������newpopulationʱ�Ĳ���

cellnumber=1;
for popnum=10:10:100%����ͨ���仯popnum��������Ⱥ��С���㷨���ܵ�Ӱ��

r=zeros(1,2*popnum)-1;          %����Ӧ����1
t=zeros(1,2*popnum)-1;          %����Ӧ����2
    
poplength=size(dataset,1);%��������newpopulationʱ�Ĳ���
minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %������Сֵ
maxvalue=repmat(ones(1,poplength),popnum,1);    %�������ֵ
source=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %�����µĳ�ʼ��Ⱥ

convexhullkneetest=[];
population=source;
evaluation=population*dataset*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whether);
functionvalue=[fpr,tpr];

frontvalue=P_sort(functionvalue);                                   %��Ⱥǰ������
kneepoint=zeros(1,popnum);                                          %��ʼkneepoint����

rrr = zeros(1,Maxfit);
ttt = rrr;
RRR = rrr;
evalnumber=0;
m=1;
sumall=[];
while evalnumber<Maxfit
        newpopulation=F_generator(population,maxvalue(1,:),minvalue(1,:),functionvalue,frontvalue,kneepoint);
        population=[population;newpopulation];  
        %����÷�������ѵ�������������
        evaluation=population*dataset*10^(-3); 
        evaluation(find(evaluation>=confidencelevel))=1;
        evaluation(find(evaluation<confidencelevel))=0;
        [tpr,fpr]=calculatetprandfpr(evaluation,whether);
        functionvalue=[fpr,1-tpr];%
        functionvaluetemp=[fpr,tpr];%
        a=[0 0];
        b=[1 1];
        functionvaluetemp=[functionvaluetemp;a;b];
        functionvaluetemp=chraarea(functionvaluetemp);%�����ȡ�㼯��pareto��
        sum=calculatearea(functionvaluetemp);
        convexhullkneetrain=[convexhullkneetrain;sum];
        %����÷������ڲ��Լ����������
        evaluation=population*dataset*10^(-3); 
        evaluation(find(evaluation>=confidencelevel))=1;
        evaluation(find(evaluation<confidencelevel))=0;
        [tpr,fpr]=calculatetprandfpr(evaluation,whether);
        functionvaluetemp=[fpr,tpr];%
        a=[0 0];
        b=[1 1];
        functionvaluetemp=[functionvaluetemp;a;b];
        functionvaluetemp=chraarea(functionvaluetemp);%�����ȡ�㼯��pareto��
        sum=calculatearea(functionvaluetemp);
        convexhullkneetest=[convexhullkneetest;sum];
        
        [frontvalue,maxfront]=P_sort(functionvalue,'half');             %����ϲ���Ⱥ��ǰ������
        [kneepoint,distance,r,t,R]=F_kneepoint(functionvalue,frontvalue,maxfront,r,t,rate);	%�ҳ�ǰmaxfront�����kneepoint
        newpopulation=F_choose(functionvalue,frontvalue,maxfront,kneepoint,distance,popnum);%����ѡ��        
        
        rrr(m) = r(1);
        ttt(m) = t(1);
        if ~isempty(R)
        RRR(m) = R(1);
        end
        %��һ����Ⱥ
        population=population(newpopulation,:);                         %��һ����Ⱥ
        functionvalue=functionvalue(newpopulation,:);                   %��һ����Ⱥ�ĺ���ֵ
        frontvalue=frontvalue(newpopulation);                           %��һ����Ⱥ��ǰ������
        kneepoint=kneepoint(newpopulation);
        evalnumber=evalnumber+10/2;
        m=m+1;
end

evaluation=population*dataset*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whether);
functionvaluetemp=[fpr,tpr];
a=[0 0];
b=[1 1];
functionvaluetemp=[functionvaluetemp;a;b];
functionvaluetemp=chraarea(functionvaluetemp);%�����ȡ�㼯��pareto��
firstfronttest=functionvaluetemp;
sum=calculatearea(functionvaluetemp);
convexhullkneetest=[convexhullkneetest;sum];

firstfronttest(size(firstfronttest,1)-1:size(firstfronttest,1),:)=[];

Allarea(cellnumber)={convexhullkneetest};
cellnumber=cellnumber+1;
end


figure (1)
plot(cell2mat(Allarea(1)),'r.');
hold on
plot(cell2mat(Allarea(2)),'b.');
hold on
plot(cell2mat(Allarea(3)),'g.');
hold on
plot(cell2mat(Allarea(4)),'y.');
hold on
plot(cell2mat(Allarea(5)),'m.');


figure (2)
plot(cell2mat(Allarea(6)),'r.');
hold on
plot(cell2mat(Allarea(7)),'b.');
hold on
plot(cell2mat(Allarea(8)),'g.');
hold on
plot(cell2mat(Allarea(9)),'y.');
hold on
plot(cell2mat(Allarea(10)),'m.');


