function [ datasetsource,whether]=inputshuju(i)
switch i
    case 1
       load('E:\shujuji/breast.mat');%%%�������ݼ�
       datasetsource =  Xtr' ;%instance Xtr          %%��Ϊ����������Ϊ������683
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ
case 2
     load('E:\shujuji/diabetis.mat');%%%�������ݼ�
       datasetsource =  X' ;%instance Xtr          %%��Ϊ����������Ϊ������4680
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ
case 3
     load('E:\shujuji/dna.mat');%%%�������ݼ�
       datasetsource =  instance' ;%instance Xtr          %%��Ϊ����������Ϊ������3186
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0

   case 4
     load('E:\shujuji/german.mat');%%%�������ݼ�
       datasetsource =  instance' ;%instance Xtr          %%��Ϊ����������Ϊ������1000
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
  case 5    
    load('E:\shujuji/heart.mat');%%%�������ݼ�
       datasetsource = X' ;%instance Xtr          %%��Ϊ����������Ϊ������4250
       whether =   Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
   case 6
    load('E:\shujuji/image.mat');%%%�������ݼ�
        datasetsource = X' ;%instance Xtr          %%��Ϊ����������Ϊ������6500
       whether =   Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
  case 7
   load('E:\shujuji/letter.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������8000
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
%   case 8
%    load('E:\shujuji/mnist.mat');%%%�������ݼ�
%         datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������70000
%        whether =   label';%label Ytr
%        whether(find(whether==-1))=0;%%��������ǩΪ0
  case 8
   load('E:\shujuji/pendigits.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������10992
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
   case 9
   load('E:\shujuji/satimage.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������6435
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
  case 10
  load('E:\shujuji/segment.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������2310
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
%   case 12
%   load('E:\shujuji/shuttle.mat');%%%�������ݼ�
%         datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������58000
%        whether =   label';%label Ytr
%        whether(find(whether==-1))=0;%%��������ǩΪ0
case 11
  load('E:\shujuji/splice.mat');%%%�������ݼ�
        datasetsource = X' ;%instance Xtr          %%��Ϊ����������Ϊ������5000
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
       
case 12
  load('E:\shujuji/svmguide3.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������1243
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
case 13
 load('E:\shujuji/thyroid.mat');%%%�������ݼ�
        datasetsource = X' ;%instance Xtr          %%��Ϊ����������Ϊ������2800
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
case 14
  load('E:\shujuji/titanic.mat');%%%�������ݼ�
        datasetsource =X' ;%instance Xtr          %%��Ϊ����������Ϊ������7500
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
case 15
  load('E:\shujuji/usps.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������9298
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0

end
