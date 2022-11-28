function [X_NC,Grabbag1]=Condensing(X_NE,K)

% 压缩近邻法
% 输入--
% X_NE : 增广剪辑样本集
% K    : 近邻数
% 输出--
% X_NC : 增广压缩样本集

% step1: 设置存储器Store和Grabbag
N=size(X_NE,1);
% 随机抽取一个正样本、一个负样本存入Store中
index1=find(X_NE(:,end)==0);%find（A）返回矩阵A中非零元素所在位置，find（A>5）返回矩阵A中大于5的元素所在位置
index2=find(X_NE(:,end)==1);
Store=[X_NE(index1(1),:);X_NE(index2(1),:)];
index1(1)=[];
index2(1)=[];
Grabbag=[X_NE(index1,:);X_NE(index2,:)];
Grabbag1=Grabbag;%
% step2: 循环
m_before=1;                 % 用于存储本次循环前Store中的样本
m_after=2;                  % 用于存储本次循环完成后Store中的样本
while m_after>m_before      % 当再无样本放入Store中时停止循环
    m_before=m_after;
    for i=1:N-2
        % 利用Store中样本对Grabbag中的数据进行1-或k-近邻
        y_KNN=KNN(Grabbag(i,1:end-1),Store,K);
        % 若被错分，放入Store中
        if (y_KNN~=Grabbag(i,end))
            Store=[Store;Grabbag(i,:)];
            Grabbag1(i,:)=0;
            m_after=m_after+1;
        end
    end
end
Grabbag1(all(Grabbag1==0,2),:)=[];
    
X_NC=Store;


