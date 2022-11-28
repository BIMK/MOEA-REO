%% 取得随机中心
function [ centroids ] = randCent1( dataSet, k )
    [m,~] = size(dataSet);%取得列数
    centroids = dataSet(randperm(m,k),:);
