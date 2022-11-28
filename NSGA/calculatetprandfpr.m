function [tpr,fpr]=calculatetprandfpr(evaluation,whether)
positivenumber=length(find(whether==1));
 negativenumber=length(find(whether==0));
%negativenumber = length(whether) - positivenumber;

tp=[];%true positive
fp=[];%false positive


for i=1:size(evaluation,1)
    sumtp=0;
    sumfp=0;
    for j=1:size(evaluation,2)
        if whether(j)==1&&evaluation(i,j)==1
            sumtp=sumtp+1;
        end
        if whether(j)==0&&evaluation(i,j)==1
            sumfp=sumfp+1;
        end
    end
    tp=[tp;sumtp];
    fp=[fp;sumfp];
end
tpr=tp/positivenumber;
fpr=fp/negativenumber;


