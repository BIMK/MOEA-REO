function [ datasetsource,whether]=inputshuju(i)
switch i
    case 1
       load('E:\shujuji/data/a9a.mat');%%%�������ݼ� 
       datasetsource =  instance' ;%instance instancetr          %%��Ϊ����������Ϊ������44842
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ
  case 2
       load('E:\shujuji/data/abalone.mat');%%%�������ݼ�
       datasetsource =  instance' ;%instance instancetr          %%��Ϊ����������Ϊ������4177
       whether =  label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ
%  case 3
%        load('E:\shujuji/data/acoustic.mat');%%%�������ݼ�
%        datasetsource =  instance' ;%instance instancetr          %%��Ϊ����������Ϊ������98528
%        whether =  label';%label labeltr
%        whether(find(whether==-1))=0;%%��������ǩΪ 
       
  case 3
      load('E:\shujuji/data/connect-4.mat');%%%�������ݼ�
       datasetsource =  instance' ;%instance instancetr       %%��Ϊ����������Ϊ������67557
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
  case 4
      load('E:\shujuji/data/fourclass.mat');%%%�������ݼ�
       datasetsource =  instance' ;%instance instancetr       %%��Ϊ����������Ϊ������862
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
  
  case 5    
     load('E:\shujuji/data/magic04.mat');%%%�������ݼ�
       datasetsource = instance' ;%instance instancetr          %%��Ϊ����������Ϊ������19020
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
   case 6
     load('E:\shujuji/data/mnist.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr          %%��Ϊ����������Ϊ������11055
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
%   case 7
%     load('E:\shujuji/data/poker.mat');%%%�������ݼ�
%         datasetsource = instance' ;%instance instancetr        %%��Ϊ����������Ϊ������1025010
%        whether =   label';%label labeltr
%        whether(find(whether==-1))=0;%%��������ǩΪ0
  case 7
    load('E:\shujuji/data/phishing.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr         %%��Ϊ����������Ϊ������17766
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
   case 8
    load('E:\shujuji/data/protein.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr        %%��Ϊ����������Ϊ������846
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
  case 9
  load('E:\shujuji/data/shuttle.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr         %%��Ϊ����������Ϊ������49749
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ
case 10
  load('E:\shujuji/data/vehicle.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr          %%��Ϊ����������Ϊ������5000
       whether =  label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
 case 11
   load('E:\shujuji/data/w2a.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr          %%��Ϊ����������Ϊ������70000
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
  case 12
  load('E:\shujuji/data/waveform.mat');%%%�������ݼ�
        datasetsource = instance' ;%instance instancetr          %%��Ϊ����������Ϊ������58000
       whether =   label';%label labeltr
       whether(find(whether==-1))=0;%%��������ǩΪ0
end
