function [dataset,whether,datasetName]=inputdataset(i)
%˵������������������������ȡ��Ӧ�����ݼ�����������ݼ���Ӧ����
%���룺i:����Ҫ��ȡ�����ݼ������
%�����dataset:      ��ȡ�����ݣ�����*��������
%      whether:      ��ȡ�������ݱ�ǩ����ǩ*��������
%      datasetName:  ���ݼ�������



switch i
    case 1
       load('E:\dataset\breast.mat');%%%�������ݼ�
       dataset =  Xtr' ;%instance Xtr          %%��Ϊ����������Ϊ������683
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ
 
    case 2
       load('E:\dataset\australian.mat');%%%�������ݼ�
       dataset = A(:,1:14)' ;%instance          %%��Ϊ������14����Ϊ������690
       whether =  A(:,end)';%label 
       datasetName='australian';
 
   case 3
         load('E:\dataset\titanic.mat');%%%�������ݼ�
         dataset=X' ;%instance Xtr          %%��Ϊ����������Ϊ������7500
         whether =  Y';%label Ytr
         whether(find(whether==-1))=0;%%��������ǩΪ0
          datasetName = 'titanic';
      
    case 4
      load('E:\dataset\wdbc.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������30����Ϊ������569
       whether =  A(:,end)';%label    
       datasetName='wdbc'; 
     
end




