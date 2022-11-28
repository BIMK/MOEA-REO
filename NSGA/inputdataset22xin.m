function [dataset,whether,datasetName]=inputdataset(i)
%说明：函数根据输入的序号来读取相应的数据集，序号与数据集对应如上
%输入：i:所需要读取的数据集的序号
%输出：dataset:      读取的数据（属性*样本数）
%      whether:      读取出的数据标签（标签*样本数）
%      datasetName:  数据集的名称



switch i
    case 1
       load('E:\dataset\breast.mat');%%%导入数据集
       dataset =  Xtr' ;%instance Xtr          %%行为特征数，列为数据量683
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='breast';
       
       
       
       
       
       
       
              
    case 2
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
        
         
    case 3
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
        
    case 4
        %导入musk2数据集
        fid = fopen('E:\dataset\musk1\clean2\clean2.data','r');
        juzhen=textscan(fid,'%*s%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'musk2';
  
        
    case 5
         load('E:\dataset\image.mat');%%%导入数据集
        dataset = X' ;%instance Xtr          %%行为特征数，列为数据量6500
       whether =   Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
        datasetName = 'image';
        
    case 6
       load('E:\dataset\australian.mat');%%%导入数据集
       dataset = A(:,1:14)' ;%instance          %%行为特征数14，列为数据量690
       whether =  A(:,end)';%label 
       datasetName='australian';
 
   case 7
         load('E:\dataset\titanic.mat');%%%导入数据集
         dataset=X' ;%instance Xtr          %%行为特征数，列为数据量7500
         whether =  Y';%label Ytr
         whether(find(whether==-1))=0;%%负样本标签为0
          datasetName = 'titanic';
        
    case 8
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
        
   case 9
     load('E:\dataset\heart.mat');%%%导入数据集
       dataset =A(:,1:end-1)' ;%instance          %%行为特征数13，列为数据量270
       whether =A(:,end)';%label
       whether(find(whether==1))=1;%%负样本标签为
       whether(find(whether==2))=0;%%负样本标签为%%备注正负标签难以分辨
       datasetName='heart';
   
   case 10
     load('E:\dataset\dna.mat');%%%导入数据集
       dataset =  instance' ;%instance Xtr          %%行为特征数，列为数据量3186
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0      
     

    case 11
     load('E:\dataset\liver-disorders.mat');%%%导入数据集
       dataset = A(:,2:end)' ;%instance          %%行为特征数5，列为数据量144
       whether =  A(:,1)';%label    
       datasetName='liver-disorders';
  case 12
        % %导入Ionosphere的数据集,g代表good,b代表bad,因此，g赋值为1，b赋值为0
        % function [dataset,whether]=inputdataset()
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,whethertemp] =textread('E:\dataset\ionosphere.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
        whethertemp=whethertemp';
        % whether=str2num(char(whethertemp));
        % a=size(whethertemp);
        
        whether=zeros(1,size(whethertemp,2));
        for i=1:size(whethertemp,2)
            if whethertemp{i}=='g'
                whether(i)=1;
            else
                whether(i)=0;
            end
        end
        
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34];
        dataset=dataset';
        
   case 13
        load('E:\dataset\fourclass.mat');%%%导入数据集
       dataset =  instance' ;%instance instancetr       %%行为特征数，列为数据量862
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
       
     case 14
      load('E:\dataset\monk-2.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数6，列为数据量432
       whether =  A(:,end)';%label    
       datasetName='monk-2';
       
    case 15
 load('E:\dataset\ring.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数20，列为数据量7400
       whether =  A(:,end)';%label    
       datasetName='ring';
        
   case 16
        %导入madelon数据集
        fid = fopen('E:\dataset\madelon\madelon_train.data','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');  
        dataset=cell2mat(juzhen);
        dataset=dataset';
        fclose(fid);   
        fid = fopen('E:\dataset\madelon\madelon_train.labels','r');
        whethertemp=textscan(fid,'%f','delimiter', ',');
        whether=cell2mat(whethertemp);
        whether=whether';
        %对whether进行处理，把-1变为0
        whether(find(whether==-1))=0;
        fclose(fid);
    case 17
       load('E:\dataset\banana.mat');%%%导入数据集
       dataset = A(:,1:2)' ;%instance          %%行为特征数2，列为数据量5300
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='banana';
    case 18
       load('E:\dataset\ecoli1.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数7，列为数据量336
       whether =  A(:,end)';%label    
       datasetName='ecoli1';
    case 19
       load('E:\dataset\ecoli2.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数7，列为数据量336
       whether =  A(:,end)';%label    
       datasetName='ecoli2';
    case 20
       load('E:\dataset\ecoli3.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数7，列为数据量336
       whether =  A(:,end)';%label    
       datasetName='ecoli3'; 
    case 21
      load('E:\dataset\wisconsin.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数9，列为数据量683
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%负样本标签为
       whether(find(whether==4))=1;%%负样本标签为
       datasetName='wisconsin'; 
    case 22
      load('E:\dataset\wdbc.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数30，列为数据量569
       whether =  A(:,end)';%label    
       datasetName='wdbc'; 
   
   
      
end




