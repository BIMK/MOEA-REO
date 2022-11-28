function [dataset,whether,datasetName]=inputdataset(i)
%˵������������������������ȡ��Ӧ�����ݼ�����������ݼ���Ӧ����
%���룺i:����Ҫ��ȡ�����ݼ������
%�����dataset:      ��ȡ�����ݣ�����*��������
%      whether:      ��ȡ�������ݱ�ǩ����ǩ*��������
%      datasetName:  ���ݼ�������



switch i  

 case 1
        % %����Ionosphere�����ݼ�,g����good,b����bad,��ˣ�g��ֵΪ1��b��ֵΪ0
        % function [dataset,whether]=inputdataset()
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,whethertemp] =textread('E:\��ǿǿ\dataset\ionosphere.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
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
 
case 21
       load('C:\Users\admin\Desktop\dataset\appendicitis.mat');%%%�������ݼ�
       dataset = A(:,1:7)' ;%instance          %%��Ϊ������7����Ϊ������106����������Ϊ21
       whether =  A(:,end)';%label 
       datasetName='appendicitis';
  

case 3
       load('E:\��ǿǿ\dataset\���������ݼ�\newdateset\coil2000.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������85����Ϊ������9822  ��������Ϊ586
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='coil2000';
      
case 4
        fid = fopen('E:\��ǿǿ\dataset\xxs\V5 Parkinsons.txt','r'); %%��Ϊ������22����Ϊ������195  ��������Ϊ147
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');       
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Parkinsons';
     
     
case 22
       load('C:\Users\admin\Desktop\dataset\haberman.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������3����Ϊ������306,��������Ϊ81
       whether =  A(:,end)';%label    
       datasetName='haberman'; 
     
case 23
       load('C:\Users\admin\Desktop\dataset\liver-disorders.mat');%%%�������ݼ�
       dataset = A(:,2:end)' ;%instance          %%��Ϊ������5����Ϊ������144 ��������Ϊ55
       whether =  A(:,1)';%label    
       datasetName='liver-disorders';
       
case 24
        load('C:\Users\admin\Desktop\dataset\fourclass.mat');%%%�������ݼ�
       dataset =  instance' ;%instance instancetr       %%��Ϊ������2����Ϊ������862����������307
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
      
 case 25
       load('C:\Users\admin\Desktop\dataset\mammogra.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������5����Ϊ������830 ��������Ϊ403
       whether =  A(:,end)';%label    
       datasetName='mammogra';
 

  case 26
       load('C:\Users\admin\Desktop\dataset\breast.mat');%%%�������ݼ�
       dataset =  Xtr' ;%instance Xtr          %%��Ϊ������10����Ϊ������683 ����������Ϊ239
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='breast';
                    
case 27
     load('C:\Users\admin\Desktop\dataset\heart.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������13����Ϊ������270����������Ϊ150
       whether =  A(:,end)';%label
       whether(find(whether==1))=1;%%��������ǩ
       whether(find(whether==2))=0;%%��������ǩΪ%%��ע������ǩ���Էֱ棬����ʵ�����ж�Ӧ�����������Ƚ϶ࡣ
       datasetName='heart';
 case 11
       load('E:\��ǿǿ\dataset\ecoli1.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������7����Ϊ������336����������Ϊ77
       whether =  A(:,end)';%label    
       datasetName='ecoli1';

 case 28
      load('C:\Users\admin\Desktop\dataset\wisconsin.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������9����Ϊ������683����������Ϊ239
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%��������ǩΪ
       whether(find(whether==4))=1;%%��������ǩΪ
       datasetName='wisconsin'; 
       
 case 13
      load('E:\��ǿǿ\dataset\���������ݼ�\newdateset\wdbc.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������30����Ϊ������569����������Ϊ357
       whether =  A(:,end)';%label    
       datasetName='wdbc';    
       

  case 14
        %����sonarall�����ݼ�,R��Ϊ0��M��Ϊ1 sonarall��60��111��97��
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,A58,A59,A60,whethertemp] =textread('E:\��ǿǿ\dataset\sonarall.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
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
        %����pima���ݼ� :pima-indians-diabetes(8,268:500)
        [A1,A2,A3,A4,A5,A6,A7,A8,whether] =textread('E:\��ǿǿ\dataset\pimaindiansdiabetesdata.txt','%f%f%f%f%f%f%f%f%f','delimiter', ',');
        whether=whether';
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8];
        dataset=dataset';
        datasetName = 'pima';
        
    
   case 16
         load('E:\��ǿǿ\dataset\titanic.mat');%%%�������ݼ�
         dataset=X' ;%instance Xtr          %%��Ϊ������3����Ϊ������7500
         whether =  Y';%label Ytr
         whether(find(whether==-1))=0;%%��������ǩΪ0
          datasetName = 'titanic';        
   case 17
        %����madelon���ݼ�  madelon��500��1000��1000��
        fid = fopen('E:\��ǿǿ\dataset\madelon\madelon_train.data','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');  
        dataset=cell2mat(juzhen);
        dataset=dataset';
        fclose(fid);   
        fid = fopen('E:\��ǿǿ\dataset\madelon\madelon_train.labels','r');
        whethertemp=textscan(fid,'%f','delimiter', ',');
        whether=cell2mat(whethertemp);
        whether=whether';
        %��whether���д�����-1��Ϊ0
        whether(find(whether==-1))=0;
        fclose(fid);
    case 18
        load('E:\��ǿǿ\dataset\vehicle3.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������18����Ϊ������846
       whether =  A(:,end)';%label    
       datasetName='vehicle3'; 
   case 19
        %����skin���ݼ� ��3��50859��194198��
        fid = fopen('E:\��ǿǿ\dataset\skin\skin.data','r');
        juzhen=textscan(fid,'%f%f%f%f','delimiter', ',');  
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2):size(dataset,2));
        %�����ݽ��г���������2��Ϊ0��Ϊ��ǩ
        whether(find(whether==2))=0;
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        whether=whether';
        fclose(fid); 

end




