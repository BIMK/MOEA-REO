function [ datasetsource,whether]=inputshuju(i)
switch i
    case 1
       load('E:\shujuji/breast.mat');%%%导入数据集
       datasetsource =  Xtr' ;%instance Xtr          %%行为特征数，列为数据量683
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为
  case 2
     load('E:\shujuji/diabetis.mat');%%%导入数据集
       datasetsource =  X' ;%instance Xtr          %%行为特征数，列为数据量4680
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为

   case 3
     load('E:\shujuji/german.mat');%%%导入数据集
       datasetsource =  instance' ;%instance Xtr          %%行为特征数，列为数据量1000
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
    case 4   
    load('E:\shujuji/heart.mat');%%%导入数据集
       datasetsource = X' ;%instance Xtr          %%行为特征数，列为数据量4250
       whether =   Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
   case 5
    load('E:\shujuji/image.mat');%%%导入数据集
        datasetsource = X' ;%instance Xtr          %%行为特征数，列为数据量6500
       whether =   Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
  case 6
   load('E:\shujuji/letter.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量8000
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0

  case 7
   load('E:\shujuji/pendigits.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量10992
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
   case 8
   load('E:\shujuji/satimage.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量6435
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
  case 9
  load('E:\shujuji/segment.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量2310
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0


case 10
  load('E:\shujuji/svmguide3.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量1243
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
case 11
 load('E:\shujuji/thyroid.mat');%%%导入数据集
        datasetsource = X' ;%instance Xtr          %%行为特征数，列为数据量2800
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
case 12
  load('E:\shujuji/titanic.mat');%%%导入数据集
        datasetsource =X' ;%instance Xtr          %%行为特征数，列为数据量7500
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
case 13
  load('E:\shujuji/usps.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量9298
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0

  case 14
       load('E:\shujuji/data/abalone.mat');%%%导入数据集
       datasetsource =  instance' ;%instance instancetr          %%行为特征数，列为数据量4177
       whether =  label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为
        
  case 15  
     load('E:\shujuji/data/magic04.mat');%%%导入数据集
       datasetsource = instance' ;%instance instancetr          %%行为特征数，列为数据量19020
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
   case 16
     load('E:\shujuji/data/mnist.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr          %%行为特征数，列为数据量11055
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0

  case 17
    load('E:\shujuji/data/phishing.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr         %%行为特征数，列为数据量17766
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
   case 18
    load('E:\shujuji/data/protein.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr        %%行为特征数，列为数据量846
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0

case 19
  load('E:\shujuji/data/vehicle.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr          %%行为特征数，列为数据量5000
       whether =  label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0


  case 20
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
        datasetName = 'Ionosphere';
   
    case 21
        %导入magic的数据集
        % function [dataset,whether]=inputdataset()
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,whethertemp] =textread('E:\dataset\magic.txt','%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
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
        
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10];
        dataset=dataset';
        datasetName = 'magic';
        
       case 22
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
        datasetName = 'madelon';  
        
         case 23
        %导入mushrooms数据集
        dataset=load('E:\dataset\mushrooms\mushroomsdata.mat');
        whether=load('E:\dataset\mushrooms\mushroomswhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
        datasetName = 'mushrooms';
        

end
