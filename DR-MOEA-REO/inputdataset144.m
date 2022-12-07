function [dataset,whether,datasetName]=inputdataset144(i)
switch i
 case 1
        % %导入Ionosphere的数据集,g代表good,b代表bad,因此，g赋值为1，b赋值为0
        % function [dataset,whether]=inputdataset()            %正样本数为225，总的样本数为351
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,whethertemp] =textread('F:\dataset\ionosphere.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
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
 
case 2
       load('F:\dataset\二分类数据集\newdateset\appendicitis.mat');%%%导入数据集
       dataset = A(:,1:7)' ;%instance          %%行为特征数7，列为数据量106，正样本数为21
       whether =  A(:,end)';%label 
       datasetName='appendicitis';
  
      
case 3
        fid = fopen('F:\dataset\xxs\V5 Parkinsons.txt','r'); %%行为特征数22，列为数据量195  正样本数为147
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');       
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Parkinsons';
     
     

     
case 4
       load('F:\dataset\二分类数据集\newdateset\liver-disorders.mat');%%%导入数据集
       dataset = A(:,2:end)' ;%instance          %%行为特征数5，列为数据量144 正样本数为55
       whether =  A(:,1)';%label    
       datasetName='liver-disorders';
       
case 5
        load('F:\dataset\fourclass.mat');%%%导入数据集
       dataset =  instance' ;%instance instancetr       %%行为特征数2，列为数据量862，正样本数307
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
      
 case 6
       load('F:\dataset\二分类数据集\newdateset\mammogra.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数5，列为数据量830 正样本数为403
       whether =  A(:,end)';%label    
       datasetName='mammogra';
     
case 7
       load('F:\dataset\二分类数据集\newdateset\monk-2.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数6，列为数据量432，正样本数为228
       whether =  A(:,end)';%label    
       datasetName='monk-2';
       

 case 8
        load('F:\dataset\二分类数据集\newdateset\twonorm.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数20，列为数据量7400 正样本数为3697
       whether =  A(:,end)';%label    
       datasetName='twonorm';
       

  case 9
       load('F:\dataset\breast.mat');%%%导入数据集
       dataset =  Xtr' ;%instance Xtr          %%行为特征数10，列为数据量683 ，正样本数为239
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='breast';
      
 
        % end
        
         
    case 10
       load('F:\dataset\二分类数据集\newdateset\australian.mat');%%%导入数据集
       dataset = A(:,1:14)' ;%instance          %%行为特征数14，列为数据量690 正样本数为307
       whether =  A(:,end)';%label 
       datasetName='australian';
      
    case 11
        %导入Spectf数据集
        fid = fopen('F:\dataset\xxs\V6 Spectf.txt','r');%%行为特征数44，列为数据量267 正样本数为212
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Spectf';
       
               
case 12
     load('F:\dataset\二分类数据集\newdateset\heart.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数13，列为数据量270，正样本数为150
       whether =  A(:,end)';%label
       whether(find(whether==1))=1;%%正样本标签
       whether(find(whether==2))=0;%%负样本标签为%%备注正负标签难以分辨，根据实验结果判断应该是正样本比较多。
       datasetName='heart';
     
 case 13
      load('F:\dataset\wisconsin.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数9，列为数据量683，正样本数为239
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%负样本标签为
       whether(find(whether==4))=1;%%负样本标签为
       datasetName='wisconsin'; 
       
    case 14
      load('F:\dataset\二分类数据集\newdateset\wdbc.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数30，列为数据量569，正样本数为357
       whether =  A(:,end)';%label    
       datasetName='wdbc';    
       
end