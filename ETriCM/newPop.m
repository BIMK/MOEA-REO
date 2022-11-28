function [ newPop ] = newPop( datasettrain,minvalue,maxvalue,popnum,poplength,confidencelevel,whethertrain )
%NEWPOP 2017.10.15�����µ���Ⱥ�ķ���
%��ʼ��һ�ٸ��ڶԽ������ϵĸ���
%   Detailed explanation goes here

newPop = [];
while size(newPop,1) < popnum
    %��ʼ������
    individual = rand(1,poplength).*(maxvalue(1,:)-minvalue(1,:))+minvalue(1,:);    %�����µĳ�ʼ��Ⱥ
    
    %�жϵ����Ƿ���������
    evaluation=individual*datasettrain*10^(-3);
    evaluation(evaluation>=confidencelevel)=1;
    evaluation(evaluation<confidencelevel)=0;
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
%     if tpr > fpr
        newPop = [newPop;individual];
%     end
end
end

