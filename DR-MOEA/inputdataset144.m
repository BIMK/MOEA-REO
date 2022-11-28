function [dataset,whether,datasetName]=inputdataset144(i)
switch i
 case 1
        % %����Ionosphere�����ݼ�,g����good,b����bad,��ˣ�g��ֵΪ1��b��ֵΪ0
        % function [dataset,whether]=inputdataset()            %��������Ϊ225���ܵ�������Ϊ351
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
       load('F:\dataset\���������ݼ�\newdateset\appendicitis.mat');%%%�������ݼ�
       dataset = A(:,1:7)' ;%instance          %%��Ϊ������7����Ϊ������106����������Ϊ21
       whether =  A(:,end)';%label 
       datasetName='appendicitis';
  
      
case 3
        fid = fopen('F:\dataset\xxs\V5 Parkinsons.txt','r'); %%��Ϊ������22����Ϊ������195  ��������Ϊ147
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');       
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Parkinsons';
     
     

     
case 4
       load('F:\dataset\���������ݼ�\newdateset\liver-disorders.mat');%%%�������ݼ�
       dataset = A(:,2:end)' ;%instance          %%��Ϊ������5����Ϊ������144 ��������Ϊ55
       whether =  A(:,1)';%label    
       datasetName='liver-disorders';
       
case 5
        load('F:\dataset\fourclass.mat');%%%�������ݼ�
       dataset =  instance' ;%instance instancetr       %%��Ϊ������2����Ϊ������862����������307
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
      
 case 6
       load('F:\dataset\���������ݼ�\newdateset\mammogra.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������5����Ϊ������830 ��������Ϊ403
       whether =  A(:,end)';%label    
       datasetName='mammogra';
     
case 7
       load('F:\dataset\���������ݼ�\newdateset\monk-2.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������6����Ϊ������432����������Ϊ228
       whether =  A(:,end)';%label    
       datasetName='monk-2';
       

 case 8
        load('F:\dataset\���������ݼ�\newdateset\twonorm.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������20����Ϊ������7400 ��������Ϊ3697
       whether =  A(:,end)';%label    
       datasetName='twonorm';
       

  case 9
       load('F:\dataset\breast.mat');%%%�������ݼ�
       dataset =  Xtr' ;%instance Xtr          %%��Ϊ������10����Ϊ������683 ����������Ϊ239
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='breast';
      
 
        % end
        
         
    case 10
       load('F:\dataset\���������ݼ�\newdateset\australian.mat');%%%�������ݼ�
       dataset = A(:,1:14)' ;%instance          %%��Ϊ������14����Ϊ������690 ��������Ϊ307
       whether =  A(:,end)';%label 
       datasetName='australian';
      
    case 11
        %����Spectf���ݼ�
        fid = fopen('F:\dataset\xxs\V6 Spectf.txt','r');%%��Ϊ������44����Ϊ������267 ��������Ϊ212
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Spectf';
       
               
case 12
     load('F:\dataset\���������ݼ�\newdateset\heart.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������13����Ϊ������270����������Ϊ150
       whether =  A(:,end)';%label
       whether(find(whether==1))=1;%%��������ǩ
       whether(find(whether==2))=0;%%��������ǩΪ%%��ע������ǩ���Էֱ棬����ʵ�����ж�Ӧ�����������Ƚ϶ࡣ
       datasetName='heart';
     
 case 13
      load('F:\dataset\wisconsin.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������9����Ϊ������683����������Ϊ239
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%��������ǩΪ
       whether(find(whether==4))=1;%%��������ǩΪ
       datasetName='wisconsin'; 
       
    case 14
      load('F:\dataset\���������ݼ�\newdateset\wdbc.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������30����Ϊ������569����������Ϊ357
       whether =  A(:,end)';%label    
       datasetName='wdbc';    
       
end