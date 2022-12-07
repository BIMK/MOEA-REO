function [ dist ] = distence( vecA, vecB )
    dist = (vecA-vecB)*(vecA-vecB)';%这里取欧式距离的平方
end
