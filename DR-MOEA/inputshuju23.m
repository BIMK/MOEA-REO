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
     load('E:\shujuji/german.mat');%%%�������ݼ�
       datasetsource =  instance' ;%instance Xtr          %%��Ϊ����������Ϊ������1000
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
    case 4   
    load('E:\shujuji/heart.mat');%%%�������ݼ�
       datasetsource = X' ;%instance Xtr          %%��Ϊ����������Ϊ������4250
       whether =   Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
   case 5
    load('E:\shujuji/image.mat');%%%�������ݼ�
        datasetsource = X' ;%instance Xtr          %%��Ϊ����������Ϊ������6500
       whether =   Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
  case 6
   load('E:\shujuji/letter.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������8000
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0

  case 7
   load('E:\shujuji/pendigits.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������10992
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
   case 8
   load('E:\shujuji/satimage.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������6435
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
  case 9
  load('E:\shujuji/segment.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������2310
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0


case 10
  load('E:\shujuji/svmguide3.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������1243
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
case 11
 load('E:\shujuji/thyroid.mat');%%%�������ݼ�
        datasetsource = X' ;%instance Xtr          %%��Ϊ����������Ϊ������2800
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
case 12
  load('E:\shujuji/titanic.mat');%%%�������ݼ�
        datasetsource =X' ;%instance Xtr          %%��Ϊ����������Ϊ������7500
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
case 13
  load('E:\shujuji/usps.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������9298
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0

  case 14
       load('E:\shujuji/data/abalone.mat');%%%�������ݼ�
       datasetsource =  instance' ;%instance instancetr          %%��Ϊ����������Ϊ������4177
       whether =  label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ
        
  case 15  
     load('E:\shujuji/data/magic04.mat');%%%�������ݼ�
       datasetsource = instance' ;%instance instancetr          %%��Ϊ����������Ϊ������19020
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
   case 16
     load('E:\shujuji/data/mnist.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr          %%��Ϊ����������Ϊ������11055
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0

  case 17
    load('E:\shujuji/data/phishing.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr         %%��Ϊ����������Ϊ������17766
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
   case 18
    load('E:\shujuji/data/protein.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr        %%��Ϊ����������Ϊ������846
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0

case 19
  load('E:\shujuji/data/vehicle.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr          %%��Ϊ����������Ϊ������5000
       whether =  label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0


  case 20
        % %����Ionosphere�����ݼ�,g����good,b����bad,��ˣ�g��ֵΪ1��b��ֵΪ0
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
        %����magic�����ݼ�
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
        %����madelon���ݼ�
        fid = fopen('E:\dataset\madelon\madelon_train.data','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        dataset=cell2mat(juzhen);
        dataset=dataset';
        fclose(fid);
        
        fid = fopen('E:\dataset\madelon\madelon_train.labels','r');
        whethertemp=textscan(fid,'%f','delimiter', ',');
        whether=cell2mat(whethertemp);
        whether=whether';
        %��whether���д�����-1��Ϊ0
        whether(find(whether==-1))=0;
        fclose(fid);
        datasetName = 'madelon';  
        
         case 23
        %����mushrooms���ݼ�
        dataset=load('E:\dataset\mushrooms\mushroomsdata.mat');
        whether=load('E:\dataset\mushrooms\mushroomswhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
        datasetName = 'mushrooms';
        

end
