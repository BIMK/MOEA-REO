function same=findsequence(resultstemp,results)
%��������resultstemp�е���ֵ��results�е����
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