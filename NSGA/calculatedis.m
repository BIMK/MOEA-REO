function distance=calculatedis(dottemp,M)
[~,rank]=sort(dottemp,'descend');
extreme=zeros(1,M);                             %用来保存边界点编号,边界点的数目和目标维数相同
extreme(1)=rank(1,1);                           %第一维值最大的个体
for j=2:length(extreme)                         %分别寻找后面每一维值最大的个体
    k=1;
    extreme(j)=rank(k,j);
    while ismember(extreme(j),extreme(1:j-1))   %若当前维值最大的个体与之前已选出的边界点相同,则取次大值,直至不同
        k=k+1;
        extreme(j)=rank(k,j);
    end
end
%计算由边界点构成的线,面或超平面的一般式方程的系数
hyperplane=dottemp(extreme,:)\ones(length(extreme),1);
%确定每个点(个体)到线,面或超平面的距离值(距离越大越好)
distance=-(dottemp*hyperplane-1)./sqrt(sum(hyperplane.^2));
end