function pareto=distance(R,pare)%ËøÒäµÄ
pareto=[];
M=size(R,1);
dis=[];
N=size(pare,1);

for i=1:M
    distance=zeros(1,N);
    paixu=[];
    index=[];
    for j=1:N
        distance(j)=sqrt((R(i,1)-pare(j,1))^2+(R(i,2)-pare(j,2)^2));
    end
    [paixu,index]=sort(distance);
    dis=[dis index(1)];
end
dis=unique(dis);
dis=sort(dis);
pareto=pare(dis,:);
