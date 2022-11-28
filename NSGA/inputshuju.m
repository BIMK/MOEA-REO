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
     load('E:\shujuji/dna.mat');%%%导入数据集
       datasetsource =  instance' ;%instance Xtr          %%行为特征数，列为数据量3186
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0

   case 4
     load('E:\shujuji/german.mat');%%%导入数据集
       datasetsource =  instance' ;%instance Xtr          %%行为特征数，列为数据量1000
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
  case 5    
    load('E:\shujuji/heart.mat');%%%导入数据集
       datasetsource = X' ;%instance Xtr          %%行为特征数，列为数据量4250
       whether =   Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
   case 6
    load('E:\shujuji/image.mat');%%%导入数据集
        datasetsource = X' ;%instance Xtr          %%行为特征数，列为数据量6500
       whether =   Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
  case 7
   load('E:\shujuji/letter.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量8000
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
%   case 8
%    load('E:\shujuji/mnist.mat');%%%导入数据集
%         datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量70000
%        whether =   label';%label Ytr
%        whether(find(whether==-1))=0;%%负样本标签为0
  case 8
   load('E:\shujuji/pendigits.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量10992
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
   case 9
   load('E:\shujuji/satimage.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量6435
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
  case 10
  load('E:\shujuji/segment.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量2310
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
%   case 12
%   load('E:\shujuji/shuttle.mat');%%%导入数据集
%         datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量58000
%        whether =   label';%label Ytr
%        whether(find(whether==-1))=0;%%负样本标签为0
case 11
  load('E:\shujuji/splice.mat');%%%导入数据集
        datasetsource = X' ;%instance Xtr          %%行为特征数，列为数据量5000
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
       
case 12
  load('E:\shujuji/svmguide3.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量1243
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
case 13
 load('E:\shujuji/thyroid.mat');%%%导入数据集
        datasetsource = X' ;%instance Xtr          %%行为特征数，列为数据量2800
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
case 14
  load('E:\shujuji/titanic.mat');%%%导入数据集
        datasetsource =X' ;%instance Xtr          %%行为特征数，列为数据量7500
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
case 15
  load('E:\shujuji/usps.mat');%%%导入数据集
        datasetsource = instance' ;%instance Xtr          %%行为特征数，列为数据量9298
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0

end
