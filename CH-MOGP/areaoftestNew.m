%-------------------------------------
%只计算tpr和fpr图的前10%的面积作为最终的结果
%-------------------------------------
function [sum,sum1]=areaoftestNew(results)

 
%     %选取面积的前10%作为最后的评估标准（也就是fpr小于0.1的区域）
%     first10=results((results(:,1)<0.1),:);%%xiaohuide
%     referencepoints=[0,0];
%     pareto=chraarea(first10);
%     pareto=[pareto;referencepoints];
%     sum=calculatearea(pareto);
%      first10=results((results(:,1)<0.1),:);
%     
%  
     first10=results((results(:,1)<0.1),:);
     first20=results((results(:,1)<0.2),:);
     referencepoints=[0,0];
     pareto10=chraarea(first10);
     pareto10=[pareto10;referencepoints]; 
     sum=calculatearea(pareto10);
     pareto20=chraarea(first20);
    pareto20=[pareto20;referencepoints]; 
     sum1=calculatearea(pareto20);

end


% %-------------------------------------
% %只计算tpr和fpr图的前10%的面积作为最终的结果
% %-------------------------------------
% function [sum10,sum20]=areaoftestNew(pop)
% 
%    
%     %选取面积的前10%作为最后的评估标准（也就是fpr小于0.1的区域）
%     first10=pop((pop(:,1)<0.1),:);
%     first20=pop((pop(:,1)<0.2),:);
%     referencepoints=[0,0];
%     pareto10=chraarea(first10);
%     pareto10=[pareto10;referencepoints]; 
%     sum10=calculatearea(pareto10);
%     pareto20=chraarea(first20);
%    pareto20=[pareto20;referencepoints]; 
%     sum20=calculatearea(pareto20);
% end