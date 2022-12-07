
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
        %导入mushrooms数据集
        dataset=load('E:\dataset\mushrooms\mushroomsdata.mat');
        whether=load('E:\dataset\mushrooms\mushroomswhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
 
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
        [Recency,Frequency,Monetary,Time,whether]=textread('E:\dataset\transfusion.txt','%f%f%f%f%f','delimiter', ',');
        dataset=[Recency,Frequency,Monetary,Time];
        dataset=dataset';
        whether=whether';
        datasetName = 'transfusion';
    case 10
      load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\pima.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数8，列为数据量768
       whether =  A(:,end)';%label    
       datasetName='pima';
      case 11
       fid = fopen('E:\dataset\hillvalley\Hill_Valley_without_noise_full.data','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2):size(dataset,2));
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        whether=whether';
        fclose(fid);
        datasetName = 'Hill_Valley_without_noise_full';
      
      case 12
        fid = fopen('E:\dataset\xxs\V5 Parkinsons.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');       
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Parkinsons';  
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
        load('E:\dataset\fourclass.mat');%%%导入数据集
       dataset =  instance' ;%instance instancetr       %%行为特征数，列为数据量862
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
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
        load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\twonorm.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数20，列为数据量7400
       whether =  A(:,end)';%label    
       datasetName='twonorm';
    case 21
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\ring.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数20，列为数据量7400
       whether =  A(:,end)';%label    
       datasetName='ring';
    case 22
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\wdbc.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数30，列为数据量569
       whether =  A(:,end)';%label    
       datasetName='wdbc'; 

   

     
end
       