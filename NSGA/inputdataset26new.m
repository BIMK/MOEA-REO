function [dataset,whether,datasetName]=inputdataset26new(i)
switch i

case 1
       load('E:\dataset\splice.mat');%%%�������ݼ�
       dataset = X' ;%instance Xtr          %%��Ϊ����������Ϊ������5000
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
      
 case 2
        % %����Ionosphere�����ݼ�,g����good,b����bad,��ˣ�g��ֵΪ1��b��ֵΪ0
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
        load('E:\dataset\vehicle3.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������18����Ϊ������846
       whether =  A(:,end)';%label    
       datasetName='vehicle3';
case 4
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\appendicitis.mat');%%%�������ݼ�
       dataset = A(:,1:7)' ;%instance          %%��Ϊ������7����Ϊ������106
       whether =  A(:,end)';%label 
       datasetName='appendicitis';

case 5
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\bands.mat');%%%�������ݼ�
       dataset = A(:,1:19)' ;%instance          %%��Ϊ������19����Ϊ������365
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='bands'; 
case 6
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\coil2000.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������85����Ϊ������9822
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='coil2000';

case 7
      load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\pima.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������8����Ϊ������768
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
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\haberman.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������3����Ϊ������306
       whether =  A(:,end)';%label    
       datasetName='haberman';
case 10
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\liver-disorders.mat');%%%�������ݼ�
       dataset = A(:,2:end)' ;%instance          %%��Ϊ������5����Ϊ������144
       whether =  A(:,1)';%label    
       datasetName='liver-disorders';
case 11
        load('E:\dataset\fourclass.mat');%%%�������ݼ�
       dataset =  instance' ;%instance instancetr       %%��Ϊ����������Ϊ������862
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
 case 12
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\mammogra.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������5����Ϊ������830
       whether =  A(:,end)';%label    
       datasetName='mammogra';
case 13
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\monk-2.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������6����Ϊ������432
       whether =  A(:,end)';%label    
       datasetName='monk-2';
case 14
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\phoneme.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������5����Ϊ������5404
       whether =  A(:,end)';%label    
       datasetName='phoneme';
 case 15
        load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\twonorm.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������20����Ϊ������7400
       whether =  A(:,end)';%label    
       datasetName='twonorm';

  case 16
       load('E:\dataset\breast.mat');%%%�������ݼ�
       dataset =  Xtr' ;%instance Xtr          %%��Ϊ����������Ϊ������683
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='breast';
   case 17
        %����sonarall�����ݼ�,R��Ϊ0��M��Ϊ1
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
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\australian.mat');%%%�������ݼ�
       dataset = A(:,1:14)' ;%instance          %%��Ϊ������14����Ϊ������690
       whether =  A(:,end)';%label 
       datasetName='australian';   
    case 19
        %����Spectf���ݼ�
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
     load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\heart.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������13����Ϊ������270
       whether =  A(:,end)';%label
       whether(find(whether==1))=1;%%��������ǩΪ
       whether(find(whether==2))=0;%%��������ǩΪ%%��ע������ǩ���Էֱ�
       datasetName='heart';
       
case 21
 load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\ring.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������20����Ϊ������7400
       whether =  A(:,end)';%label    
       datasetName='ring';
        
 case 22
       load('E:\dataset\banana.mat');%%%�������ݼ�
       dataset = A(:,1:2)' ;%instance          %%��Ϊ������2����Ϊ������5300
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='banana';
    case 23
       load('E:\dataset\ecoli1.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������7����Ϊ������336
       whether =  A(:,end)';%label    
       datasetName='ecoli1';
    case 24
       load('E:\dataset\ecoli2.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������7����Ϊ������336
       whether =  A(:,end)';%label    
       datasetName='ecoli2';

    case 25
      load('E:\dataset\wisconsin.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������9����Ϊ������683
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%��������ǩΪ
       whether(find(whether==4))=1;%%��������ǩΪ
       datasetName='wisconsin'; 
    case 26
      load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\wdbc.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������30����Ϊ������569
       whether =  A(:,end)';%label    
       datasetName='wdbc';        
end