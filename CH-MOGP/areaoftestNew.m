%-------------------------------------
%ֻ����tpr��fprͼ��ǰ10%�������Ϊ���յĽ��
%-------------------------------------
function [sum,sum1]=areaoftestNew(results)

 
%     %ѡȡ�����ǰ10%��Ϊ����������׼��Ҳ����fprС��0.1������
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
% %ֻ����tpr��fprͼ��ǰ10%�������Ϊ���յĽ��
% %-------------------------------------
% function [sum10,sum20]=areaoftestNew(pop)
% 
%    
%     %ѡȡ�����ǰ10%��Ϊ����������׼��Ҳ����fprС��0.1������
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