%% ȡ���������
function [ centroids ] = randCent1( dataSet, k )
    [m,~] = size(dataSet);%ȡ������
    centroids = dataSet(randperm(m,k),:);
