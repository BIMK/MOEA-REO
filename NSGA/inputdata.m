function [ datasetsource,whether]=inputshuju(i)
switch i
    case 1
       load('E:\shujuji/data/a9a.mat');%%%导入数据集 
       datasetsource =  instance' ;%instance instancetr          %%行为特征数，列为数据量44842
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为
  case 2
       load('E:\shujuji/data/abalone.mat');%%%导入数据集
       datasetsource =  instance' ;%instance instancetr          %%行为特征数，列为数据量4177
       whether =  label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为
%  case 3
%        load('E:\shujuji/data/acoustic.mat');%%%导入数据集
%        datasetsource =  instance' ;%instance instancetr          %%行为特征数，列为数据量98528
%        whether =  label';%label labeltr
%        whether(find(whether==-1))=0;%%负样本标签为 
       
  case 3
      load('E:\shujuji/data/connect-4.mat');%%%导入数据集
       datasetsource =  instance' ;%instance instancetr       %%行为特征数，列为数据量67557
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
  case 4
      load('E:\shujuji/data/fourclass.mat');%%%导入数据集
       datasetsource =  instance' ;%instance instancetr       %%行为特征数，列为数据量862
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
  
  case 5    
     load('E:\shujuji/data/magic04.mat');%%%导入数据集
       datasetsource = instance' ;%instance instancetr          %%行为特征数，列为数据量19020
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
   case 6
     load('E:\shujuji/data/mnist.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr          %%行为特征数，列为数据量11055
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
%   case 7
%     load('E:\shujuji/data/poker.mat');%%%导入数据集
%         datasetsource = instance' ;%instance instancetr        %%行为特征数，列为数据量1025010
%        whether =   label';%label labeltr
%        whether(find(whether==-1))=0;%%负样本标签为0
  case 7
    load('E:\shujuji/data/phishing.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr         %%行为特征数，列为数据量17766
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
   case 8
    load('E:\shujuji/data/protein.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr        %%行为特征数，列为数据量846
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
  case 9
  load('E:\shujuji/data/shuttle.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr         %%行为特征数，列为数据量49749
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为
case 10
  load('E:\shujuji/data/vehicle.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr          %%行为特征数，列为数据量5000
       whether =  label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
 case 11
   load('E:\shujuji/data/w2a.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr          %%行为特征数，列为数据量70000
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
  case 12
  load('E:\shujuji/data/waveform.mat');%%%导入数据集
        datasetsource = instance' ;%instance instancetr          %%行为特征数，列为数据量58000
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
end
