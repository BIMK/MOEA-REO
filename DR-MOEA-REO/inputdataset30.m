
function [dataset,whether,datasetName]=inputdataset(i)
%说明：函数根据输入的序号来读取相应的数据集，序号与数据集对应如上
%输入：i:所需要读取的数据集的序号
%输出：dataset:      读取的数据（属性*样本数）
%      whether:      读取出的数据标签（标签*样本数）
%      datasetName:  数据集的名称
switch i
    case 1
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\appendicitis.mat');%%%导入数据集
       dataset = A(:,1:7)' ;%instance          %%行为特征数7，列为数据量106
       whether =  A(:,end)';%label 
       datasetName='appendicitis';
     case 2
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\australian.mat');%%%导入数据集
       dataset = A(:,1:14)' ;%instance          %%行为特征数14，列为数据量690
       whether =  A(:,end)';%label 
       datasetName='australian';
     case 3
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\banana.mat');%%%导入数据集
       dataset = A(:,1:2)' ;%instance          %%行为特征数2，列为数据量5300
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='banana';
     case 4
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\bands.mat');%%%导入数据集
       dataset = A(:,1:19)' ;%instance          %%行为特征数19，列为数据量365
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='bands'; 
          case 5
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\banknote authentication.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数4，列为数据量1372
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='banknote authentication';
        case 6
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\Blood Transfusion Service Center.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数4，列为数据量748
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='Blood Transfusion Service Center';
          case 7
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\bupa.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数6，列为数据量345
       whether =  A(:,end)';%label 
       whether(find(whether==1))=0;%%负样本标签为
       whether(find(whether==2))=1;%%负样本标签为
       datasetName='bupa';
         case 8
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\coil2000.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数85，列为数据量9822
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='coil2000';
          case 9
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\ecoli1.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数7，列为数据量336
       whether =  A(:,end)';%label    
       datasetName='ecoli1';
            case 10
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\ecoli2.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数7，列为数据量336
       whether =  A(:,end)';%label    
       datasetName='ecoli2';
           case 11
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\ecoli3.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数7，列为数据量336
       whether =  A(:,end)';%label    
       datasetName='ecoli3';
      
         case 12
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\glass1.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数9，列为数据量214
       whether =  A(:,end)';%label    
       datasetName='glass1';
         case 13
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\haberman.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数3，列为数据量306
       whether =  A(:,end)';%label    
       datasetName='haberman';
         case 14
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\heart.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数13，列为数据量270
       whether =  A(:,end)';%label
       whether(find(whether==1))=1;%%负样本标签为
       whether(find(whether==2))=0;%%负样本标签为%%备注正负标签难以分辨
       datasetName='heart';
         case 15
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\liver-disorders.mat');%%%导入数据集
       dataset = A(:,2:end)' ;%instance          %%行为特征数5，列为数据量144
       whether =  A(:,1)';%label    
       datasetName='liver-disorders';
        case 16
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\magic.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数10，列为数据量19020
       whether =  A(:,end)';%label    
       datasetName='magic';
       case 17
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\mammogra.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数5，列为数据量830
       whether =  A(:,end)';%label    
       datasetName='mammogra';
         case 18
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\monk-2.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数6，列为数据量432
       whether =  A(:,end)';%label    
       datasetName='monk-2';
         case 19
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\phoneme.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数5，列为数据量5404
       whether =  A(:,end)';%label    
       datasetName='phoneme';
        case 20
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\pima.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数8，列为数据量768
       whether =  A(:,end)';%label    
       datasetName='pima';
       case 21
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\ring.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数20，列为数据量7400
       whether =  A(:,end)';%label    
       datasetName='ring';
        case 22
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\sonar.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数60，列为数据量208
       whether =  A(:,end)';%label
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='sonar';
        case 23
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\spambase.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数57，列为数据量4597
       whether =  A(:,end)';%label    
       datasetName='spambase';
       case 24
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\svmguide1.mat');%%%导入数据集
       dataset = A(:,2:end)' ;%instance          %%行为特征数4，列为数据量3089
       whether =  A(:,1)';%label    
       datasetName='svmguide1';
         case 25
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\twonorm.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数20，列为数据量7400
       whether =  A(:,end)';%label    
       datasetName='twonorm';
         case 26
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\vehicle1.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数18，列为数据量846
       whether =  A(:,end)';%label    
       datasetName='vehicle1';
        case 27
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\vehicle2.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数18，列为数据量846
       whether =  A(:,end)';%label    
       datasetName='vehicle2';
        case 28
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\vehicle3.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数18，列为数据量846
       whether =  A(:,end)';%label    
       datasetName='vehicle3'; 
         case 29
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\wdbc.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数30，列为数据量569
       whether =  A(:,end)';%label    
       datasetName='wdbc'; 
         case 30
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\wisconsin.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数9，列为数据量683
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%负样本标签为
       whether(find(whether==4))=1;%%负样本标签为
       datasetName='wisconsin'; 
end
       