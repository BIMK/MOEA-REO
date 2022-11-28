function [Population,FrontNo,CrowdDis,FunctionValue] = EnvironmentalSelection(Population,N,Points,W,delta,FunctionValue)
%function [Population,FunctionValue] = EnvironmentalSelection(Population,N,Points,W,delta)
% The environmental selection of r-NSGA-II

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Non-r-dominated sorting
%        Points=[0 0;0 0.1;0 0.2;0 0.3;0 0.4;0 0.5;0 0.6;0 0.7;0 0.8;0 0.9;0 1;0.1 1;0.2 1;0.3 1;0.4 1;0.5 1;0.6 1;0.7 1;0.8 1;0.9 1;1 1];
%      W =[0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;0.25 0.75;];
%     delta = 0.1 ;
%      K = 5; 
%      N     =   100;
%     confidencelevel = 0;
%      Generations    =    1000;
%     %% Generate random population
%      %Population = Global.Initialization();
%      [datasetsource,whether]  =  inputdataset(2);
%      Indices        =  crossvalind('Kfold', size(datasetsource,2), K); %将数据集随机分成五个部分，分别给以标号1~5
%      datasetsource  =  datasetsource';
%     for crossnumber  =  1:K
%        datasettrain  =  datasetsource(find(Indices~=crossnumber),:);%%五折交叉
%        datasettrain  =  datasettrain';
%        whethertrain  =  whether(find(Indices~=crossnumber));
%        datasettest  =  datasetsource(find(Indices==crossnumber),:);
%        datasettest  =  datasettest';
%        whethertest  =  whether(find(Indices==crossnumber));
%        poplength  =  size(datasettrain,1);%对应于种群的维度，即列数
%        minvalue1  =  ones(1,poplength)*(-1);%%边界
%        maxvalue1  =  ones(1,poplength);
%        Boundary  =  [maxvalue1;minvalue1];                          %%上下边界
%        minvalue  =  repmat(ones(1,poplength),N,1)*(-1);        %个体最小值
%        maxvalue  =  repmat(ones(1,poplength),N,1);             %个体最大值
%        population1  =  rand(N,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群
%        evaluation  =  population1*datasettrain*10^(-3);
%        evaluation(find(evaluation>=confidencelevel))  =  1;
%        evaluation(find(evaluation<confidencelevel))  =  0;
%        %    [tpr,fpr]  =  newEvaluation(evaluation,whethertrain,population1,datasettrain,confidencelevel);%%计算目标函数
%             [tpr,fpr]  =  Evaluation(evaluation,whethertrain,population1,datasettrain,confidencelevel);%%计算目标函数
%       FunctionValue=  [fpr,tpr];


   [FrontNo,MaxFNo] = NrDSort(FunctionValue,N,Points,W,delta);
    Next = FrontNo < MaxFNo;
    
    %% Calculate the crowding distance of each solution
    CrowdDis = CrowdingDistance(FunctionValue,FrontNo);
    
    %% Select the solutions in the last front by their crowding distances
    Last     = find(FrontNo==MaxFNo);
    [~,Rank] = sort(CrowdDis(Last),'descend');
    Next(Last(Rank(1:N-sum(Next)))) = true;
    
    %% Population for next generation
    Population = Population(Next,:);
     FunctionValue  = FunctionValue(Next,:);
    FrontNo    = FrontNo(Next);
    CrowdDis   = CrowdDis(Next);
end