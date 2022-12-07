function [dataset,whether,datasetName]=inputdataset(i)
%说明：函数根据输入的序号来读取相应的数据集，序号与数据集对应如上
%输入：i:所需要读取的数据集的序号
%输出：dataset:      读取的数据（属性*样本数）
%      whether:      读取出的数据标签（标签*样本数）
%      datasetName:  数据集的名称



switch i  

 case 1
        % %导入Ionosphere的数据集,g代表good,b代表bad,因此，g赋值为1，b赋值为0
        % function [dataset,whether]=inputdataset()
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,whethertemp] =textread('E:\张强强\dataset\ionosphere.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
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
        dataset=dataset';%正样本数为225，总的样本数为351
 
case 21
       load('C:\Users\admin\Desktop\dataset\appendicitis.mat');%%%导入数据集
       dataset = A(:,1:7)' ;%instance          %%行为特征数7，列为数据量106，正样本数为21
       whether =  A(:,end)';%label 
       datasetName='appendicitis';
  

case 3
       load('E:\张强强\dataset\二分类数据集\newdateset\coil2000.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数85，列为数据量9822  正样本数为586
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='coil2000';
      
case 4
        fid = fopen('E:\张强强\dataset\xxs\V5 Parkinsons.txt','r'); %%行为特征数22，列为数据量195  正样本数为147
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');       
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Parkinsons';
     
     
case 22
       load('C:\Users\admin\Desktop\dataset\haberman.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数3，列为数据量306,正样本数为81
       whether =  A(:,end)';%label    
       datasetName='haberman'; 
     
case 23
       load('C:\Users\admin\Desktop\dataset\liver-disorders.mat');%%%导入数据集
       dataset = A(:,2:end)' ;%instance          %%行为特征数5，列为数据量144 正样本数为55
       whether =  A(:,1)';%label    
       datasetName='liver-disorders';
       
case 24
        load('C:\Users\admin\Desktop\dataset\fourclass.mat');%%%导入数据集
       dataset =  instance' ;%instance instancetr       %%行为特征数2，列为数据量862，正样本数307
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%负样本标签为0
      
 case 25
       load('C:\Users\admin\Desktop\dataset\mammogra.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数5，列为数据量830 正样本数为403
       whether =  A(:,end)';%label    
       datasetName='mammogra';
 

  case 26
       load('C:\Users\admin\Desktop\dataset\breast.mat');%%%导入数据集
       dataset =  Xtr' ;%instance Xtr          %%行为特征数10，列为数据量683 ，正样本数为239
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%负样本标签为
       datasetName='breast';
                    
case 27
     load('C:\Users\admin\Desktop\dataset\heart.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数13，列为数据量270，正样本数为150
       whether =  A(:,end)';%label
       whether(find(whether==1))=1;%%正样本标签
       whether(find(whether==2))=0;%%负样本标签为%%备注正负标签难以分辨，根据实验结果判断应该是正样本比较多。
       datasetName='heart';
 case 11
       load('E:\张强强\dataset\ecoli1.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数7，列为数据量336，正样本数为77
       whether =  A(:,end)';%label    
       datasetName='ecoli1';

 case 28
      load('C:\Users\admin\Desktop\dataset\wisconsin.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数9，列为数据量683，正样本数为239
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%负样本标签为
       whether(find(whether==4))=1;%%负样本标签为
       datasetName='wisconsin'; 
       
 case 13
      load('E:\张强强\dataset\二分类数据集\newdateset\wdbc.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数30，列为数据量569，正样本数为357
       whether =  A(:,end)';%label    
       datasetName='wdbc';    
       

  case 14
        %导入sonarall的数据集,R设为0，M设为1 sonarall（60，111，97）
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,A58,A59,A60,whethertemp] =textread('E:\张强强\dataset\sonarall.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
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
  case 15
        %导入pima数据集 :pima-indians-diabetes(8,268:500)
        [A1,A2,A3,A4,A5,A6,A7,A8,whether] =textread('E:\张强强\dataset\pimaindiansdiabetesdata.txt','%f%f%f%f%f%f%f%f%f','delimiter', ',');
        whether=whether';
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8];
        dataset=dataset';
        datasetName = 'pima';
        
    
   case 16
         load('E:\张强强\dataset\titanic.mat');%%%导入数据集
         dataset=X' ;%instance Xtr          %%行为特征数3，列为数据量7500
         whether =  Y';%label Ytr
         whether(find(whether==-1))=0;%%负样本标签为0
          datasetName = 'titanic';        
   case 17
        %导入madelon数据集  madelon（500，1000，1000）
        fid = fopen('E:\张强强\dataset\madelon\madelon_train.data','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');  
        dataset=cell2mat(juzhen);
        dataset=dataset';
        fclose(fid);   
        fid = fopen('E:\张强强\dataset\madelon\madelon_train.labels','r');
        whethertemp=textscan(fid,'%f','delimiter', ',');
        whether=cell2mat(whethertemp);
        whether=whether';
        %对whether进行处理，把-1变为0
        whether(find(whether==-1))=0;
        fclose(fid);
    case 18
        load('E:\张强强\dataset\vehicle3.mat');%%%导入数据集
       dataset = A(:,1:end-1)' ;%instance          %%行为特征数18，列为数据量846
       whether =  A(:,end)';%label    
       datasetName='vehicle3'; 
   case 19
        %导入skin数据集 （3，50859，194198）
        fid = fopen('E:\张强强\dataset\skin\skin.data','r');
        juzhen=textscan(fid,'%f%f%f%f','delimiter', ',');  
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2):size(dataset,2));
        %对数据进行初步处理，将2改为0作为标签
        whether(find(whether==2))=0;
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        whether=whether';
        fclose(fid); 

end




