function y_t=KNN(test,Sample,K)

% K-近邻法
% 输入--
% test   : 待测数据点
% Sample : 增广样本集
% K      : 近邻个数
% 输出--
% y_t    : 待测数据点的标识

% 统计待测数据点到所有样本的距离
N=size(Sample,1);
distance=zeros(N);
for i=1:N
    distance(i)=norm(test-Sample(i,1:end-1));
end

[Sdist,index]=sort(distance,'ascend');     % 距离升序排列

% 统计K个近邻中属于各类的样本数，即差别函数
k1=0;                                      % K个近邻中负样本数
k2=0;                                      % K个近邻中正样本数
if K>N
    K=N;                                   % 防止越界
end
for i=1:K 
    if Sample(index(i),end)==0
        k1=k1+1;
    else
        k2=k2+1;
    end
end

% 决策
if k1>k2
    y_t=0;
else
    y_t=1;
end

