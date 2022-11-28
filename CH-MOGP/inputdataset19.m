function [dataset,whether,datasetName]=inputdataset19(i)
switch i

case 1
       load('E:\dataset\splice.mat');%%%�������ݼ�
       dataset = X' ;%instance Xtr          %%��Ϊ����������Ϊ������5000,��������Ϊ2484
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
        dataset=dataset';%��������Ϊ225���ܵ�������Ϊ351
 
case 3
       load('E:\dataset\���������ݼ�\newdateset\appendicitis.mat');%%%�������ݼ�
       dataset = A(:,1:7)' ;%instance          %%��Ϊ������7����Ϊ������106����������Ϊ21
       whether =  A(:,end)';%label 
       datasetName='appendicitis';
  

case 4
       load('E:\dataset\���������ݼ�\newdateset\coil2000.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������85����Ϊ������9822  ��������Ϊ586
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='coil2000';
      
case 5
        fid = fopen('E:\dataset\xxs\V5 Parkinsons.txt','r'); %%��Ϊ������22����Ϊ������195  ��������Ϊ147
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');       
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Parkinsons';
     
     
case 6
       load('E:\dataset\���������ݼ�\newdateset\haberman.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������3����Ϊ������306,��������Ϊ81
       whether =  A(:,end)';%label    
       datasetName='haberman'; 
     
case 7
       load('E:\dataset\���������ݼ�\newdateset\liver-disorders.mat');%%%�������ݼ�
       dataset = A(:,2:end)' ;%instance          %%��Ϊ������5����Ϊ������144 ��������Ϊ55
       whether =  A(:,1)';%label    
       datasetName='liver-disorders';
       
case 8
        load('E:\dataset\fourclass.mat');%%%�������ݼ�
       dataset =  instance' ;%instance instancetr       %%��Ϊ������2����Ϊ������862����������307
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
      
 case 9
       load('E:\dataset\���������ݼ�\newdateset\mammogra.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������5����Ϊ������830 ��������Ϊ403
       whether =  A(:,end)';%label    
       datasetName='mammogra';
     
case 10
       load('E:\dataset\���������ݼ�\newdateset\monk-2.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������6����Ϊ������432����������Ϊ228
       whether =  A(:,end)';%label    
       datasetName='monk-2';
       

 case 11
        load('E:\dataset\���������ݼ�\newdateset\twonorm.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������20����Ϊ������7400 ��������Ϊ3697
       whether =  A(:,end)';%label    
       datasetName='twonorm';
       

  case 12
       load('E:\dataset\breast.mat');%%%�������ݼ�
       dataset =  Xtr' ;%instance Xtr          %%��Ϊ������10����Ϊ������683 ����������Ϊ239
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='breast';
      
 
        % end
        
         
    case 13
       load('E:\dataset\���������ݼ�\newdateset\australian.mat');%%%�������ݼ�
       dataset = A(:,1:14)' ;%instance          %%��Ϊ������14����Ϊ������690 ��������Ϊ307
       whether =  A(:,end)';%label 
       datasetName='australian';
      
    case 14
        %����Spectf���ݼ�
        fid = fopen('E:\dataset\xxs\V6 Spectf.txt','r');%%��Ϊ������44����Ϊ������267 ��������Ϊ212
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Spectf';
       
               
case 15
     load('E:\dataset\���������ݼ�\newdateset\heart.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������13����Ϊ������270����������Ϊ150
       whether =  A(:,end)';%label
       whether(find(whether==1))=1;%%��������ǩ
       whether(find(whether==2))=0;%%��������ǩΪ%%��ע������ǩ���Էֱ棬����ʵ�����ж�Ӧ�����������Ƚ϶ࡣ
       datasetName='heart';
     
       
case 16
 load('E:\dataset\���������ݼ�\newdateset\ring.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������20����Ϊ������7400 ��������Ϊ3736
       whether =  A(:,end)';%label    
       datasetName='ring';
    

    case 17
       load('E:\dataset\ecoli1.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������7����Ϊ������336����������Ϊ77
       whether =  A(:,end)';%label    
       datasetName='ecoli1';
   

    case 18
      load('E:\dataset\wisconsin.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������9����Ϊ������683����������Ϊ239
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%��������ǩΪ
       whether(find(whether==4))=1;%%��������ǩΪ
       datasetName='wisconsin'; 
       
    case 19
      load('E:\dataset\���������ݼ�\newdateset\wdbc.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������30����Ϊ������569����������Ϊ357
       whether =  A(:,end)';%label    
       datasetName='wdbc';    
       
end