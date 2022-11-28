function same=findsequence(resultstemp,results)
%函数返回resultstemp中的数值在results中的序号
% count=1;
same=[];
for i=1:size(resultstemp,1)
    for j=1:size(results,1)
        if resultstemp(i,:)==results(j,:)
            same=[same;j];
            break;
        end
    end
end