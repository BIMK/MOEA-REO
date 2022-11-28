function y_t=KNN(test,Sample,K)

% K-���ڷ�
% ����--
% test   : �������ݵ�
% Sample : ����������
% K      : ���ڸ���
% ���--
% y_t    : �������ݵ�ı�ʶ

% ͳ�ƴ������ݵ㵽���������ľ���
N=size(Sample,1);
distance=zeros(N);
for i=1:N
    distance(i)=norm(test-Sample(i,1:end-1));
end

[Sdist,index]=sort(distance,'ascend');     % ������������

% ͳ��K�����������ڸ�������������������
k1=0;                                      % K�������и�������
k2=0;                                      % K����������������
if K>N
    K=N;                                   % ��ֹԽ��
end
for i=1:K 
    if Sample(index(i),end)==0
        k1=k1+1;
    else
        k2=k2+1;
    end
end

% ����
if k1>k2
    y_t=0;
else
    y_t=1;
end

