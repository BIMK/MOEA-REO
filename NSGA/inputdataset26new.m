function [dataset,whether,datasetName]=inputdataset26new(i)
switch i

case 1
       load('E:\dataset\splice.mat');%%%导入数据集
       dataset = X' ;%instance Xtr          %%行为特征数，列为数据量5000
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为0
      
 case 2
        % %导入Ionosphere的数据集,g代表good,b代表bad,因此，g赋值为1，b赋值为0
        % function [dataset,whether]=inputdataset()
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,whethertemp] =textread('E:\dataset\ionosphere.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
        whethertemp=whethertemp';
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
case 3
        load('E:\dataset\vehicle3.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数18，列为数据量846
       whether =  A(:,end)';%label    
       datasetName='vehicle3';
case 4
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\appendicitis.mat');%%%导入数据集
       dataset = A(:,1:7)' ;%instance          %%行为特征数7，列为数据量106
       whether =  A(:,end)';%label 
       datasetName='appendicitis';

case 5
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\bands.mat');%%%导入数据集
       dataset = A(:,1:19)' ;%instance          %%行为特征数19，列为数据量365
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='bands'; 
case 6
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\coil2000.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数85，列为数据量9822
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='coil2000';

case 7
      load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\pima.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数8，列为数据量768
       whether =  A(:,end)';%label    
       datasetName='pima';

case 8
        fid = fopen('E:\dataset\xxs\V5 Parkinsons.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');       
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Parkinsons';
case 9
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\haberman.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数3，列为数据量306
       whether =  A(:,end)';%label    
       datasetName='haberman';
case 10
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\liver-disorders.mat');%%%导入数据集
       dataset = A(:,2:end)' ;%instance          %%行为特征数5，列为数据量144
       whether =  A(:,1)';%label    
       datasetName='liver-disorders';
case 11
        load('E:\dataset\fourclass.mat');%%%导入数据集
       dataset =  instance' ;%instance instancetr       %%行为特征数，列为数据量862
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
 case 12
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\mammogra.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数5，列为数据量830
       whether =  A(:,end)';%label    
       datasetName='mammogra';
case 13
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\monk-2.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数6，列为数据量432
       whether =  A(:,end)';%label    
       datasetName='monk-2';
case 14
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\phoneme.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数5，列为数据量5404
       whether =  A(:,end)';%label    
       datasetName='phoneme';
 case 15
        load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\twonorm.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数20，列为数据量7400
       whether =  A(:,end)';%label    
       datasetName='twonorm';

  case 16
       load('E:\dataset\breast.mat');%%%导入数据集
       dataset =  Xtr' ;%instance Xtr          %%行为特征数，列为数据量683
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='breast';
   case 17
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
        
         
    case 18
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\australian.mat');%%%导入数据集
       dataset = A(:,1:14)' ;%instance          %%行为特征数14，列为数据量690
       whether =  A(:,end)';%label 
       datasetName='australian';   
    case 19
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
               
case 20
     load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\heart.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数13，列为数据量270
       whether =  A(:,end)';%label
       whether(find(whether==1))=1;%%负样本标签为
       whether(find(whether==2))=0;%%负样本标签为%%备注正负标签难以分辨
       datasetName='heart';
       
case 21
 load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\ring.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数20，列为数据量7400
       whether =  A(:,end)';%label    
       datasetName='ring';
        
 case 22
       load('E:\dataset\banana.mat');%%%导入数据集
       dataset = A(:,1:2)' ;%instance          %%行为特征数2，列为数据量5300
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='banana';
    case 23
       load('E:\dataset\ecoli1.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数7，列为数据量336
       whether =  A(:,end)';%label    
       datasetName='ecoli1';
    case 24
       load('E:\dataset\ecoli2.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数7，列为数据量336
       whether =  A(:,end)';%label    
       datasetName='ecoli2';

    case 25
      load('E:\dataset\wisconsin.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数9，列为数据量683
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%负样本标签为
       whether(find(whether==4))=1;%%负样本标签为
       datasetName='wisconsin'; 
    case 26
      load('C:\Users\Mr.Simple\Desktop\二分类数据集\newdateset\wdbc.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数30，列为数据量569
       whether =  A(:,end)';%label    
       datasetName='wdbc';        
end