function sum=calculatearea(results)
% results=rand(100,2);
%按x轴fpr从小到大排序。


%将（0,0)和（1,1）点加入到点的集合中
% tempa=zeros(1,2);
% tempa(1,1)=1;
% tempa(1,2)=1;
% 
% tempb=zeros(1,2);
% tempb(1,1)=0;
% tempb(1,2)=0;
% results=[results;tempa;tempb];

results=sortrows(results);
sum=0;
for i=1:size(results,1)-1
    j=i+1;
    temp=abs(results(i,1)-results(j,1))*(results(i,2)+results(j,2))*0.5;
    sum=sum+temp;
    
end
end