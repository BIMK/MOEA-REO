function [dataset,whether,datasetName]=inputdataset(i)
%说明：函数根据输入的序号来读取相应的数据集，序号与数据集对应如上
%输入：i:所需要读取的数据集的序号
%输出：dataset:      读取的数据（属性*样本数）
%      whether:      读取出的数据标签（标签*样本数）
%      datasetName:  数据集的名称



switch i
   
              
    case 1
        %导入sonarall的数据集,R设为0，M设为1
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,A58,A59,A60,whethertemp] =textread('E:\dataset\sonarall.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
        whethertemp=whethertemp';
        whether=zeros(1,size(whethertemp,2));
        for i=1:size(whethertemp,2)
            if whethertemp{i}=='M'
                whether(i)=1;
            else
                whether(i)=0;
            end
        end
        
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,A58,A59,A60];
        dataset=dataset';
        datasetName = 'sonarall';
        % end
      
    case 2
        %导入musk1数据集
        fid = fopen('E:\dataset\musk1\clean1\clean1.data','r');
        juzhen=textscan(fid,'%*s%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'musk1';

    case 3
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\australian.mat');%%%导入数据集
       dataset = A(:,1:14)' ;%instance          %%行为特征数14，列为数据量690
       whether =  A(:,end)';%label 
       datasetName='australian';
 
 
        
    case 4
        %导入Spectf数据集
        fid = fopen('E:\dataset\xxs\V6 Spectf.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Spectf';
        
   case 5
     load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\heart.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数13，列为数据量270
       whether =  A(:,end)';%label
       whether(find(whether==1))=1;%%负样本标签为
       whether(find(whether==2))=0;%%负样本标签为%%备注正负标签难以分辨
       datasetName='heart';   

    case 6
       load('E:\dataset\ecoli1.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数7，列为数据量336
       whether =  A(:,end)';%label    
       datasetName='ecoli1';
  
    case 7
      load('E:\dataset\wisconsin.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数9，列为数据量683
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%负样本标签为
       whether(find(whether==4))=1;%%负样本标签为
       datasetName='wisconsin'; 
    case 8
      load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\wdbc.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数30，列为数据量569
       whether =  A(:,end)';%label    
       datasetName='wdbc'; 

end




