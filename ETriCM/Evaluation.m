function [tpr,fpr]=Evaluation(evaluation,whether)%%��������������
positivenumber = sum(whether);
negativenumber = length(whether) - positivenumber;

whetherMat = repmat(whether, size(evaluation,1),1);
tp = sum(whetherMat & evaluation,2);
fp = sum(~whetherMat & evaluation,2);

tpr=tp/positivenumber;
fpr=fp/negativenumber;


