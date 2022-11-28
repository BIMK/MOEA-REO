function [dataset,whether,datasetName]=inputdataset(i)
%˵������������������������ȡ��Ӧ�����ݼ�����������ݼ���Ӧ����
%���룺i:����Ҫ��ȡ�����ݼ������
%�����dataset:      ��ȡ�����ݣ�����*��������
%      whether:      ��ȡ�������ݱ�ǩ����ǩ*��������
%      datasetName:  ���ݼ�������



switch i
    case 1
       load('E:\dataset\breast.mat');%%%�������ݼ�
       dataset =  Xtr' ;%instance Xtr          %%��Ϊ����������Ϊ������683
       whether =  Ytr';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='breast';
              
    case 2
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
        
         
    case 3
        %����musk1���ݼ�
        fid = fopen('E:\dataset\musk1\clean1\clean1.data','r');
        juzhen=textscan(fid,'%*s%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'musk1';
        
    case 4
        %����musk2���ݼ�
        fid = fopen('E:\dataset\musk1\clean2\clean2.data','r');
        juzhen=textscan(fid,'%*s%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'musk2';
  
        
    case 5
         load('E:\dataset\image.mat');%%%�������ݼ�
        dataset = X' ;%instance Xtr          %%��Ϊ����������Ϊ������6500
       whether =   Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
        datasetName = 'image';
        
    case 6
        %����Hill_Valley_with_noise_full���ݿ�
        fid = fopen('E:\dataset\hillvalley\Hill_Valley_with_noise_full.data','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2):size(dataset,2));
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        whether=whether';
        fclose(fid);
        datasetName = 'Hill_Valley_with_noise_full';
 
   case 7
         load('E:\dataset\titanic.mat');%%%�������ݼ�
         dataset=X' ;%instance Xtr          %%��Ϊ����������Ϊ������7500
         whether =  Y';%label Ytr
         whether(find(whether==-1))=0;%%��������ǩΪ0
          datasetName = 'titanic';
        
    case 8
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
        
   case 9
       load('E:\dataset\splice.mat');%%%�������ݼ�
       dataset = X' ;%instance Xtr          %%��Ϊ����������Ϊ������5000
       whether =  Y';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
   
   case 10
     load('E:\dataset\dna.mat');%%%�������ݼ�
       dataset =  instance' ;%instance Xtr          %%��Ϊ����������Ϊ������3186
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0      
     

    case 11
        %����magic�����ݼ�
        % function [dataset,whether]=inputdataset()
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,whethertemp] =textread('E:\dataset\magic.txt','%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
        whethertemp=whethertemp';
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
        % end
  case 12
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
        
   case 13
       load('E:\dataset\german.mat');%%%�������ݼ�
       dataset=  instance' ;%instance Xtr          %%��Ϊ����������Ϊ������1000
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0 
       
     case 14
       load('E:\dataset\svmguide3.mat');%%%�������ݼ�
        dataset = instance' ;%instance Xtr          %%��Ϊ����������Ϊ������1243
       whether =   label';%label Ytr
       whether(find(whether==-1))=0;%%��������ǩΪ0
       
    case 15
    load('E:\dataset\protein.mat');%%%�������ݼ�
       dataset = instance' ;%instance instancetr        %%��Ϊ����������Ϊ������846
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
        
   case 16
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
        %��whether���д�������-1��Ϊ0
        whether(find(whether==-1))=0;
        fclose(fid);
    case 17
       load('E:\dataset\banana.mat');%%%�������ݼ�
       dataset = A(:,1:2)' ;%instance          %%��Ϊ������2����Ϊ������5300
       whether =  A(:,end)';%label 
       whether(find(whether==-1))=0;%%��������ǩΪ
       datasetName='banana';
    case 18
       load('E:\dataset\ecoli1.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������7����Ϊ������336
       whether =  A(:,end)';%label    
       datasetName='ecoli1';
    case 19
       load('E:\dataset\ecoli2.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������7����Ϊ������336
       whether =  A(:,end)';%label    
       datasetName='ecoli2';
    case 20
       load('E:\dataset\ecoli3.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������7����Ϊ������336
       whether =  A(:,end)';%label    
       datasetName='ecoli3'; 
    case 21
       load('E:\dataset\magic1.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance    %%��Ϊ������10����Ϊ������19020 ��magic�����𣬵�����û������
       whether =  A(:,end)';%label    
       datasetName='magic';
    case 22
        load('E:\dataset\spambase.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������57����Ϊ������4597
       whether =  A(:,end)';%label    
       datasetName='spambase';
    case 23
       load('E:\dataset\vehicle1.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������18����Ϊ������846
       whether =  A(:,end)';%label    
       datasetName='vehicle1';
    case 24
       load('E:\dataset\vehicle2.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������18����Ϊ������846
       whether =  A(:,end)';%label    
       datasetName='vehicle2';
    case 25
        load('E:\dataset\vehicle3.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������18����Ϊ������846
       whether =  A(:,end)';%label    
       datasetName='vehicle3'; 
    case 26
       load('E:\dataset\wisconsin.mat');%%%�������ݼ�
       dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������9����Ϊ������683
       whether =  A(:,end)';%label  
       whether(find(whether==2))=0;%%��������ǩΪ
       whether(find(whether==4))=1;%%��������ǩΪ
       datasetName='wisconsin'; 
end



