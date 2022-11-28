function [pareto,area]=area_test(population,testdataset,confidencelevel,whether)

    evaluation=population*testdataset*10^(-3);
    
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
  
    
    [tpr,fpr]=calculatetprandfpr(evaluation,whether);
 % [tpr,fpr]  =  Evaluation(evaluation,whether);%%计算目标函数
    results=[fpr,tpr];%
    tempa=zeros(1,2);
    tempa(1,1)=1;
    tempa(1,2)=1;
    tempb=zeros(1,2);
    tempb(1,1)=0;
    tempb(1,2)=0;
   pareto=chrareatest(results);
    pareto=[pareto;tempa;tempb];%将这两点加入到种群中，使得计算出来的面积更精确
    area=calculatearea(pareto);

end