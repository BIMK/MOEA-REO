
function [dataset,whether,datasetName]=inputdataset(i)
%˵������������������������ȡ��Ӧ�����ݼ�����������ݼ���Ӧ����
%���룺i:����Ҫ��ȡ�����ݼ������
%�����dataset:      ��ȡ�����ݣ�����*��������
%      whether:      ��ȡ�������ݱ�ǩ����ǩ*��������
%      datasetName:  ���ݼ�������
switch i
    case 1
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\appendicitis.mat');%%%�������ݼ�
       dataset = A(:,1:7)' ;%instance          %%��Ϊ������7����Ϊ������106
       whether =  A(:,end)';%label 
       datasetName='appendicitis';
     case 2
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\australian.mat');%%%�������ݼ�
       dataset = A(:,1:14)' ;%instance          %%��Ϊ������14����Ϊ������690
       whether =  A(:,end)';%label 
       datasetName='australian';
     case 3
        %����mushrooms���ݼ�
        dataset=load('E:\dataset\mushrooms\mushroomsdata.mat');
        whether=load('E:\dataset\mushrooms\mushroomswhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
 
     case 4
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\bands.mat');%%%�������ݼ�
       dataset = A(:,1:19)' ;%instance          %%��Ϊ������19����Ϊ������365
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='bands'; 
     case 5
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\banknote authentication.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������4����Ϊ������1372
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='banknote authentication';
     case 6
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\Blood Transfusion Service Center.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������4����Ϊ������748
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='Blood Transfusion Service Center';
     case 7
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\bupa.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������6����Ϊ������345
       whether =  A(:,end)';%label 
       whether(find(whether==1))=0;%%��������ǩΪ
       whether(find(whether==2))=1;%%��������ǩΪ
       datasetName='bupa';
     case 8
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\coil2000.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������85����Ϊ������9822
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='coil2000';
     case 9
        [Recency,Frequency,Monetary,Time,whether]=textread('E:\dataset\transfusion.txt','%f%f%f%f%f','delimiter', ',');
        dataset=[Recency,Frequency,Monetary,Time];
        dataset=dataset';
        whether=whether';
        datasetName = 'transfusion';
    case 10
      load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\pima.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������8����Ϊ������768
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
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\haberman.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������3����Ϊ������306
       whether =  A(:,end)';%label    
       datasetName='haberman';
     case 14
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\heart.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������13����Ϊ������270
       whether =  A(:,end)';%label
       whether(find(whether==1))=1;%%��������ǩΪ
       whether(find(whether==2))=0;%%��������ǩΪ%%��ע������ǩ���Էֱ�
       datasetName='heart';
    case 15
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\liver-disorders.mat');%%%�������ݼ�
       dataset = A(:,2:end)' ;%instance          %%��Ϊ������5����Ϊ������144
       whether =  A(:,1)';%label    
       datasetName='liver-disorders';
    case 16
        load('E:\dataset\fourclass.mat');%%%�������ݼ�
       dataset =  instance' ;%instance instancetr       %%��Ϊ����������Ϊ������862
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
    case 17
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\mammogra.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������5����Ϊ������830
       whether =  A(:,end)';%label    
       datasetName='mammogra';
    case 18
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\monk-2.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������6����Ϊ������432
       whether =  A(:,end)';%label    
       datasetName='monk-2';
    case 19
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\phoneme.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������5����Ϊ������5404
       whether =  A(:,end)';%label    
       datasetName='phoneme';
    case 20
        load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\twonorm.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������20����Ϊ������7400
       whether =  A(:,end)';%label    
       datasetName='twonorm';
    case 21
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\ring.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������20����Ϊ������7400
       whether =  A(:,end)';%label    
       datasetName='ring';
    case 22
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\newdateset\wdbc.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������30����Ϊ������569
       whether =  A(:,end)';%label    
       datasetName='wdbc'; 

   

     
end
       