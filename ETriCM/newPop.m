function [ newPop ] = newPop( datasettrain,minvalue,maxvalue,popnum,poplength,confidencelevel,whethertrain )
%NEWPOP 2017.10.15产生新的种群的方法
%初始化一百个在对角线以上的个体
%   Detailed explanation goes here

newPop = [];
while size(newPop,1) < popnum
    %初始化单个
    individual = rand(1,poplength).*(maxvalue(1,:)-minvalue(1,:))+minvalue(1,:);    %产生新的初始种群
    
    %判断单个是否满足条件
    evaluation=individual*datasettrain*10^(-3);
    evaluation(evaluation>=confidencelevel)=1;
    evaluation(evaluation<confidencelevel)=0;
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
%     if tpr > fpr
        newPop = [newPop;individual];
%     end
end
end

