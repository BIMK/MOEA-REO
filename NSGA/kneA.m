function [convexhullkneetrain,convexhullkneetest,firstfronttrain,firstfronttest]=kneA(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest,rate,datasetName)
%████该自ROCwithknee使用knee算法来产生测试集和训练集的凸包下面积
tic;

firstFrontStart = [];
firstFrontEnd   = [];

convexhullkneetrain=[];
convexhullkneetest=[];
r=zeros(1,2*popnum)-1;          %自适应参数1
t=zeros(1,2*popnum)-1;          %自适应参数2
population=source;%将初始点集保存下来
evaluation=population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
%[tpr,fpr]  =  Evaluation(evaluation,whethertrain);%%计算目标函数
% figure(1)
% plot(fpr,tpr,'*r');
% needLine = [0,0;1,1];
% hold on;
% plot(needLine(:,1),needLine(:,2),'.-k');
% title(datasetName);

functionvalue=[fpr,tpr];

frontvalue=P_sort(functionvalue);                                   %种群前沿面编号
kneepoint=zeros(1,popnum);                                          %初始kneepoint集合

rrr = zeros(1,Maxfit);
ttt = rrr;
RRR = rrr;
evalnumber=0;
m=1;
sumall=[];
while evalnumber<Maxfit
    newpopulation=F_generator(population,maxvalue(1,:),minvalue(1,:),functionvalue,frontvalue,kneepoint);
    population=[population;newpopulation];
    %计算该分类器在训练集上面的性能
    

    evaluation=population*datasettrain*10^(-3);
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
  % [tpr,fpr]  =  Evaluation(evaluation,whethertrain);%%计算目标函数
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
    
    
    
    
    %计算该分类器在测试集上面的性能
    
    evaluation=population*datasettest*10^(-3);
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
  [tpr,fpr]=calculatetprandfpr(evaluation,whethertest);
 % [tpr,fpr]  =  Evaluation(evaluation,whethertest);%%计算目标函数
    functionvaluetemp=[fpr,tpr];%
    a=[0 0];
    b=[1 1];
    functionvaluetemp=[functionvaluetemp;a;b];
    functionvaluetemp=chraarea(functionvaluetemp);%★★★★取点集的pareto面
    sum=calculatearea(functionvaluetemp);
    convexhullkneetest=[convexhullkneetest;sum];
    firstfronttest=functionvaluetemp;
    
    
    [frontvalue,maxfront]=P_sort(functionvalue,'half');             %计算合并种群的前沿面编号
  %  [kneepoint,distance,r,t,R]=three(functionvalue,frontvalue,maxfront,r,t,rate);	%使用的是kmeans方法来获取kneepoint点
    [kneepoint,distance,r,t,R]=F_kneepoint(functionvalue,frontvalue,maxfront,r,t,rate);	%找出前maxfront个面的kneepoint,与kn-moea的区别所在
    newpopulation=F_choose(functionvalue,frontvalue,maxfront,kneepoint,distance,popnum);%环境选择
    
    rrr(m) = r(1);
    ttt(m) = t(1);
    if ~isempty(R)
        RRR(m) = R(1);
    end
    %下一代种群
    population=population(newpopulation,:);                         %下一代种群
    functionvalue=functionvalue(newpopulation,:);                   %下一代种群的函数值
    frontvalue=frontvalue(newpopulation);                           %下一代种群的前沿面编号
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