function [convexhullkneetrain,convexhullkneetest,firstfronttrain,firstfronttest]=kneA(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest,rate,datasetName)
%������������ROCwithkneeʹ��knee�㷨���������Լ���ѵ������͹�������
tic;

firstFrontStart = [];
firstFrontEnd   = [];

convexhullkneetrain=[];
convexhullkneetest=[];
r=zeros(1,2*popnum)-1;          %����Ӧ����1
t=zeros(1,2*popnum)-1;          %����Ӧ����2
population=source;%����ʼ�㼯��������
evaluation=population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
%[tpr,fpr]  =  Evaluation(evaluation,whethertrain);%%����Ŀ�꺯��
% figure(1)
% plot(fpr,tpr,'*r');
% needLine = [0,0;1,1];
% hold on;
% plot(needLine(:,1),needLine(:,2),'.-k');
% title(datasetName);

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
    

    evaluation=population*datasettrain*10^(-3);
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
  % [tpr,fpr]  =  Evaluation(evaluation,whethertrain);%%����Ŀ�꺯��
    functionvalue=[fpr,-tpr];

    functionvaluetemp=[fpr,tpr];
    a=[0 0];
    b=[1 1];
    functionvaluetemp=[functionvaluetemp;a;b];
    functionvaluetemp=chraarea(functionvaluetemp);
    
    
    disp(num2str(evalnumber));
    
    sum=calculatearea(functionvaluetemp);
    convexhullkneetrain=[convexhullkneetrain;sum];
    firstfronttrain=functionvaluetemp;
    
    
    
    
    %����÷������ڲ��Լ����������
    
    evaluation=population*datasettest*10^(-3);
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
  [tpr,fpr]=calculatetprandfpr(evaluation,whethertest);
 % [tpr,fpr]  =  Evaluation(evaluation,whethertest);%%����Ŀ�꺯��
    functionvaluetemp=[fpr,tpr];%
    a=[0 0];
    b=[1 1];
    functionvaluetemp=[functionvaluetemp;a;b];
    functionvaluetemp=chraarea(functionvaluetemp);%�����ȡ�㼯��pareto��
    sum=calculatearea(functionvaluetemp);
    convexhullkneetest=[convexhullkneetest;sum];
    firstfronttest=functionvaluetemp;
    
    
    [frontvalue,maxfront]=P_sort(functionvalue,'half');             %����ϲ���Ⱥ��ǰ������
  %  [kneepoint,distance,r,t,R]=three(functionvalue,frontvalue,maxfront,r,t,rate);	%ʹ�õ���kmeans��������ȡkneepoint��
    [kneepoint,distance,r,t,R]=F_kneepoint(functionvalue,frontvalue,maxfront,r,t,rate);	%�ҳ�ǰmaxfront�����kneepoint,��kn-moea����������
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
    evalnumber=evalnumber+popnum/2;
    
    if evalnumber == 50
        [firstFrontStart,~]=areaoftest(population,datasettest,confidencelevel,whethertest);
    end
    
    m=m+1;
    disp(['it is knee' num2str(evalnumber)]);
    
end
firstFrontEnd = firstfronttest;
totalTime=toc;
end