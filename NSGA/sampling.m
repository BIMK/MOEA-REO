function s = sampling(R, n)
% 选择抽样，R为记录集合，n为抽取的样本数
% 算法参考：D. E. Knuth, TAOCP, vol.2, pp142，稍有改动

% 编写函数时用的测试数据
if ~nargin
R = 1 : 8;
 n = 4;
end

N = length(R);
t = 0;% 处理过的记录总数
m = 0;% 已选得的记录数

while 1
 U= rand;
 if (N-t)*U < n-m
m = m + 1;
s(m) = R(t+1);
% 若已抽取到足够的记录，则算法终止
if m >= n, break, end
 end
 t = t + 1;
end