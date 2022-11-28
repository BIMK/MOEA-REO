function [index,pareto,area]=areaoftest(population,testdataset,confidencelevel,whether)

    evaluation=population*testdataset*10^(-3);
    
    evaluation((evaluation>=confidencelevel))=1;
    evaluation((evaluation<confidencelevel))=0;
%      whethersum=sum(evaluation,1);
%     whethrT=floor(whethersum/150);
%     index=find(whethrT~=whether);    
    [tpr,fpr]=calculatetprandfpr(evaluation,whether);
 % [tpr,fpr]  =  Evaluation(evaluation,whether);%%����Ŀ�꺯��
    results=[fpr,tpr];%
    tempa=zeros(1,2);
    tempa(1,1)=1;
    tempa(1,2)=1;
    tempb=zeros(1,2);
    tempb(1,1)=0;
    tempb(1,2)=0;
    [index,pareto]=chraarea(results);
    pareto=[pareto;tempa;tempb];%����������뵽��Ⱥ�У�ʹ�ü���������������ȷ
    area=calculatearea(pareto);

end