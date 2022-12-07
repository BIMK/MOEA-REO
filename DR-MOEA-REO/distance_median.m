function [ dist ] = distance_median( vecA, vecB )
    dist = sum(abs(vecA-vecB));%这里取欧式距离的平方
end

