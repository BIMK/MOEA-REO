%% 取得随机中心
function [ centroids ] = randCent( dataSet, k )
    [m,n] = size(dataSet);%取得列数
    centroids = zeros(k, n);
    for j = 1:n
        minJ = min(dataSet(:,j));
        rangeJ = max(dataSet(:,j))-min(dataSet(:,j));
        centroids(:,j) = minJ+rand(k,1)*rangeJ;%产生区间上的随机数
    end
end
