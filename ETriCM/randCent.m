%% ȡ���������
function [ centroids ] = randCent( dataSet, k )
    [m,n] = size(dataSet);%ȡ������
    centroids = zeros(k, n);
    for j = 1:n
        minJ = min(dataSet(:,j));
        rangeJ = max(dataSet(:,j))-min(dataSet(:,j));
        centroids(:,j) = minJ+rand(k,1)*rangeJ;%���������ϵ������
    end
end
