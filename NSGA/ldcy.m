function f = LHS(m,n,box)
% 拉丁超立方抽样（LHS）
% m维度n个样本点,每一维度上的区间,每个样本点所在区间为：box
% 输出结果为：m*(n/m)格式，

% step1.每一个维度上划分n个区间，每个区间有相同的概率
% step2.在每一维里的每一个区间中随机的抽取一个点
a = box(1);
b = box(2);
A = a+b.*rand(m,n);

% step3.再从每一维里随机抽出（2）中选取的点，将它们组成向量
ind =ceil(n*rand(m,n/m));

% 输出结果为：m*(n/m)格式
f =zeros(size(ind));
for k=1:m
    row_k =A(k,:);
    f(k,:)= row_k(ind(k,:));
end


