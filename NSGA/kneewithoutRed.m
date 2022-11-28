function [convexhullkneetrain,convexhullkneetest,firstfronttrain,firstfronttest]=kneewithoutRed(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest,rate)

% clc
% clear all
% popnum=50;
% 
% populationnumber=100;
% [dataset,whether]=inputdataset(1);%datasetnumber代表当前测试的数据集
% poplength=size(dataset,1);%用作产生newpopulation时的参数
% minvalue=repmat(ones(1,poplength),populationnumber,1)*(-1);   %个体最小值
% maxvalue=repmat(ones(1,poplength),populationnumber,1);    %个体最大值
% population=rand(populationnumber,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群
% source=population;
% confidencelevel=0;%预值
% Maxfit=100;

newnumber=[];%新种群中点的编号
convexhullkneetrain=[];
convexhullkneetest=[];
r=zeros(1,2*popnum)-1;          %自适应参数1
t=zeros(1,2*popnum)-1;          %自适应参数2
% rate=0.6;

population=source;%将初始点集保存下来
evaluation=population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
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
    functionvalue=[fpr,-tpr];%
    functionvaluetemp=[fpr,tpr];%
    a=[0 0];
    b=[1 1];
    functionvaluetemp=[functionvaluetemp;a;b];
    functionvaluetemp=chraarea(functionvaluetemp);%★★★★取点集的pareto面
    sum=calculatearea(functionvaluetemp);
    convexhullkneetrain=[convexhullkneetrain;sum];
    %计算该分类器在测试集上面的性能
    evaluation=population*datasettest*10^(-3);
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertest);
    functionvaluetemp=[fpr,tpr];%    
    a=[0 0];
    b=[1 1];
    functionvaluetemp=[functionvaluetemp;a;b];
    functionvaluetemp=chraarea(functionvaluetemp);%★★★★取点集的pareto面
    sum=calculatearea(functionvaluetemp);
    convexhullkneetest=[convexhullkneetest;sum];
    
    %生成冗余点和非冗余点集合
    R=[];%冗余集合，里面储存的是各个冗余点的坐标
    U=[1:size(functionvalue,1)]';%非冗余点的坐标
    redundancy=[];%储存冗余点的序号
    unredundancy=[];%储存非冗余点的序号
    for i=1:size(functionvalue,1)
        for j=i+1:size(functionvalue,1)
            if(functionvalue(i,:)==functionvalue(j,:))
                redundancy=[redundancy;j];
            end
            
        end
    end
    redundancy=unique(redundancy,'rows');
    
    RE=redundancy;
    U(redundancy,:)=[];
    
    if numel(U)<=popnum
        newnumber=[];
        [frontvalue,maxfront]=P_sort(functionvalue);
        [kneepoint,distance,r,t,R]=F_kneepoint(functionvalue,frontvalue,maxfront,r,t,rate);	%找出前maxfront个面的kneepoint
        newnumber=[newnumber;U];
        tempnumber=randperm(size(RE,1));
        newnumber=[newnumber;RE(tempnumber(1:popnum-size(U,1)))];
        population=population(newnumber,:);
        frontvalue=frontvalue(newnumber);
        functionvalue=functionvalue(newnumber,:);
        kneepoint=kneepoint(newnumber);
    else
        %非冗余点的个数大于popnum，因此要从非冗余点集中选出比较好的popnum个点
        poptemp=functionvalue(U,:);
        [frontvalue,maxfront]=P_sort(poptemp);             %计算合并种群的前沿面编号
        [kneepoint,distance,r,t,R]=F_kneepoint( poptemp,frontvalue,maxfront,r,t,rate);	%找出前maxfront个面的kneepoint
        newpopulation= F_choosewithoutRed(poptemp,frontvalue,maxfront,kneepoint,distance,popnum);%使用改进的F_choosewithoutRed环境选择
        newpopulationforfrontvalue=newpopulation;
        newnumber=U(newpopulation);
        population=population(newpopulation,:);                         %下一代种群
        functionvalue=functionvalue(newpopulation,:);                   %下一代种群的函数值
        frontvalue=frontvalue(newpopulationforfrontvalue);                           %下一代种群的前沿面编号
        kneepoint=kneepoint(newpopulationforfrontvalue);
    end
    rrr(m) = r(1);
    ttt(m) = t(1);
    if ~isempty(R)
        RRR(m) = R(1);
    end
    %下一代种群
    
    evalnumber=evalnumber+popnum/2;
    m=m+1;
    
end
   
evaluation=population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
functionvaluetemp=[fpr,tpr];%
a=[0 0];
b=[1 1];
functionvaluetemp=[functionvaluetemp;a;b];
functionvaluetemp=chraarea(functionvaluetemp);%★★★★取点集的pareto面
sum=calculatearea(functionvaluetemp);
convexhullkneetrain=[convexhullkneetrain;sum];
firstfronttrain=functionvaluetemp;
% figure (5)
% plot(functionvaluetemp(:,1),functionvaluetemp(:,2),'r.');
% hold on
% title('第一层面上的点','fontsize',16);
% legend('CH-3','NSGAII','ROCknee');

evaluation=population*datasettest*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertest);
functionvaluetemp=[fpr,tpr];
a=[0 0];
b=[1 1];
functionvaluetemp=[functionvaluetemp;a;b];
functionvaluetemp=chraarea(functionvaluetemp);%★★★★取点集的pareto面
firstfronttest=functionvaluetemp;
sum=calculatearea(functionvaluetemp);
convexhullkneetest=[convexhullkneetest;sum];

firstfronttrain(size(firstfronttrain,1)-1:size(firstfronttrain,1),:)=[];
firstfronttest(size(firstfronttest,1)-1:size(firstfronttest,1),:)=[];

end
    
