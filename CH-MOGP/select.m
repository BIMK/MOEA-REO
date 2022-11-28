function [best,Population]=select(newpopulation,evaluation,whethertrain,cost,C,popnum)
acc=[];

COST=[];
for i=1:200
    acc=[acc;sum(evaluation(i,:)==whethertrain)/size(whethertrain,2)];
    p=[];
    for j=1:size(whethertrain,2)
        p=[p cost(whethertrain(j),evaluation(i,j))];
    end
    p=sum(p);
    COST=[COST;p];
end
error=1-acc;
res=C*error+(1-C)*COST;
[q,index]=sort(res);
Population=newpopulation(index(1:popnum),:);
best=newpopulation(index(1),:);



%[c,index]=sort(COST)
