%★★★★这个脚本是为了测试rate对knee的影响而单独写的
clc
clear all

popnum=100; %种群大小(须为偶数)
confidencelevel=0;%预值
Maxfit=30000;%最大迭代次数

Allarea=[];
[dataset,whether]=inputdataset(1);%datasetnumber代表当前测试的数据集
convexhullkneetrain=[];
convexhullkneetest=[];
r=zeros(1,2*popnum)-1;          %自适应参数1
t=zeros(1,2*popnum)-1;          %自适应参数2
% rate=0.2;

poplength=size(dataset,1);%用作产生newpopulation时的参数
minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %个体最小值
maxvalue=repmat(ones(1,poplength),popnum,1);    %个体最大值

source=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群

for rate=0:0.1:1%这里通过变化rate来测试rate对算法性能的影响
    
convexhullkneetest=[];
population=source;
evaluation=population*dataset*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whether);
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
        evaluation=population*dataset*10^(-3); 
        evaluation(find(evaluation>=confidencelevel))=1;
        evaluation(find(evaluation<confidencelevel))=0;
        [tpr,fpr]=calculatetprandfpr(evaluation,whether);
        functionvalue=[fpr,1-tpr];%
        functionvaluetemp=[fpr,tpr];%
        a=[0 0];
        b=[1 1];
        functionvaluetemp=[functionvaluetemp;a;b];
        functionvaluetemp=chraarea(functionvaluetemp);%★★★★取点集的pareto面
        sum=calculatearea(functionvaluetemp);
        convexhullkneetrain=[convexhullkneetrain;sum];
        %计算该分类器在测试集上面的性能
        evaluation=population*dataset*10^(-3); 
        evaluation(find(evaluation>=confidencelevel))=1;
        evaluation(find(evaluation<confidencelevel))=0;
        [tpr,fpr]=calculatetprandfpr(evaluation,whether);
        functionvaluetemp=[fpr,tpr];%
        a=[0 0];
        b=[1 1];
        functionvaluetemp=[functionvaluetemp;a;b];
        functionvaluetemp=chraarea(functionvaluetemp);%★★★★取点集的pareto面
        sum=calculatearea(functionvaluetemp);
        convexhullkneetest=[convexhullkneetest;sum];
        
        [frontvalue,maxfront]=P_sort(functionvalue,'half');             %计算合并种群的前沿面编号
        [kneepoint,distance,r,t,R]=F_kneepoint(functionvalue,frontvalue,maxfront,r,t,rate);	%找出前maxfront个面的kneepoint
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
functionvaluetemp=chraarea(functionvaluetemp);%★★★★取点集的pareto面
firstfronttest=functionvaluetemp;
sum=calculatearea(functionvaluetemp);
convexhullkneetest=[convexhullkneetest;sum];

firstfronttest(size(firstfronttest,1)-1:size(firstfronttest,1),:)=[];

Allarea=[Allarea,convexhullkneetest];

end


figure (1)
plot(Allarea(:,1),'r.');
hold on
plot(Allarea(:,2),'b.');
hold on
plot(Allarea(:,3),'g.');
hold on
plot(Allarea(:,4),'y.');
hold on
plot(Allarea(:,5),'m.');


figure (2)
plot(Allarea(:,6),'r.');
hold on
plot(Allarea(:,7),'b.');
hold on
plot(Allarea(:,8),'g.');
hold on
plot(Allarea(:,9),'y.');
hold on
plot(Allarea(:,10),'m.');


