%%MOEAD，优化PAUC
%%论文对比算法MOEA/D也是用这个跑的
function   [convexhullMOEADtrain,convexhullMOEADtest,firstfronttrainMOEADtemp,firstfronttestMOEADtemp]=MOEAD(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest);

firstFrontStart = [];
firstFrontEnd   = [];
evaluationnum=0;
    %%参数设置
  %  Generations    =    1000;%%种群迭代次数
    DULI           =    1;
   N     =   100;
    H1    =   99;
    H2    =   0;
    delta    =  0.9;
   % popnum   =  100;
    confidencelevel  =   0;%%阈值
    leng             =   N;
    H                =   N-1;
    Weight           =  (0:H)./H;
    Weight(2,:)      =   1-Weight;
    Weight(Weight==0)   =  0.00001;
    Weight    =     Weight';
    T    =    floor(N/10);
    W     =    Weight;%%权重向量的产生（1） 
    countnumber=1;
%   A  =  [0.01,0.01]; Rp  =  A;  b  = [0.05,0.1]; Rp  = repmat(Rp,leng,1); b  =  repmat(b,leng,1);   W =  b.*W+Rp;%%权重向量的产生（3）     
%% 邻居判断 

%  a=W; e=0.001;%%转化矩阵
%     for i=1:size(a,1)
%         for j=1:2
%             W(i,j)=1/(a(i,j)+e);
%         end
%         W(i,:)=W(i,:)./sum(W(i,:));
%     end   
    
 B  =  zeros(leng);
 for i = 1 : leng-1
      for j = i+1 : leng
           B(i,j) = norm(W(i,:)-W(j,:));
           B(j,i) = B(i,j);
      end
 end
[~,B] = sort(B,2);
B = B(:,1:T);
  
%  
% K=5;%五折交叉
% 
% %       load('E:\第一份工作\实验结果2.0\新数据集/breast.mat');
% % %%    breast  dna  german  letter  mnist  pendigits  satimage  segment  shuttle  svmguide3  usps
% %       datasetsource =  Xtr' ;%instance Xtr
% %       whether =  Ytr';%label Ytr
% %       whether(find(whether==-1))=0;%%负样本标签为0
%      
%       
% [datasetsource,whether]  =  inputdataset(15);
% Indices   =  crossvalind('Kfold', size(datasetsource,2), K); %将数据集随机分成五个部分，分别给以标号1~5
% datasetsource  =  datasetsource';
% %%初始化种群
% %  avePAUCpianhao=zeros(10,1);
% tic;
% DL=zeros( DULI ,1);
% for x=1: DULI    
%       PAUCpianhao  =  zeros(5,1);                                %%用于存放五折交叉的结果
%       avePAUCpianhao  = 0 ;                                      %五折交叉后的平均值
%   for crossnumber  =  1:K
%      datasettrain  =  datasetsource(find(Indices~=crossnumber),:);%%五折交叉
%      datasettrain  =  datasettrain';
%      whethertrain  =  whether(find(Indices~=crossnumber));
%      datasettest  =  datasetsource(find(Indices==crossnumber),:);
%      datasettest  =  datasettest';
%      whethertest  =  whether(find(Indices==crossnumber));
      poplength  =  size(datasettrain,1);%对应于种群的维度，即列数
      minvalue1  =  ones(1,poplength)*(-1);%%边界
      maxvalue1  =  ones(1,poplength);
      Boundary  =  [maxvalue1;minvalue1];                          %%上下边界
%      minvalue  =  repmat(ones(1,poplength),popnum,1)*(-1);        %个体最小值
%      maxvalue  =  repmat(ones(1,poplength),popnum,1);             %个体最大值
%      population1  =  rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群
       population=source;
     evaluation  = population*datasettrain*10^(-3);
     evaluation(find(evaluation>=confidencelevel))  =  1;
     evaluation(find(evaluation<confidencelevel))  =  0;       
%           [tpr,fpr]  =  newEvaluation(evaluation,whethertrain,population1,datasettrain,confidencelevel);%%计算目标函数
        % [tpr,fpr]  =  Evaluation(evaluation,whethertrain,population1,datasettrain,confidencelevel);%%计算目标函数
         [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
    FunctionValue  =  [fpr,1-tpr];
    Z  =  min(FunctionValue);                                %%理想参考点                
    Population=population;
    while evaluationnum<Maxfit   
  %  for i1  =  1:Generations                                     %%循环迭代  
      
        Q = [];                %对每个个体执行操作
              for i1=1:leng
                  if rand < delta
                      P = B(i1,:);
                  else
                      P = 1:leng;
                  end
                  k = randperm(length(P));
                  Offspring = P_generator(Population(P(k(1:2)),:),Boundary,'Real',1 );
                  Q= [Q;Offspring];
              end
          evaluation=Q*datasettrain*10^(-3);
          evaluation(find(evaluation>=confidencelevel))=1;
          evaluation(find(evaluation<confidencelevel))=0;
%         
          %    [tpr,fpr]=Evaluation(evaluation,whethertrain,Q,datasettrain,confidencelevel);%%计算目标函数
              [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
          QFun=[fpr,1-tpr];
          mixPop=[Population;Q];
          mixFun =[FunctionValue;QFun];
          Z=min(Z,min(mixFun));
          [Population,FunctionValue]=selection(mixPop,mixFun,W,Z);

     NonDominated       =    P_sort(FunctionValue,'first')==1;%%寻找非支配解
     Populationtrain    =    Population(NonDominated,:);
     FunctionValuetrain =  FunctionValue(NonDominated,:);
         %测试集
         
           if evaluationnum == 0
            [firstFrontStart,~]=areaoftest(population,datasettest,confidencelevel,whethertest);
        end
           evaluationnum=evaluationnum+popnum/2;
           
        evaluation=Populationtrain*datasettest*10^(-3);
        evaluation(find(evaluation>=confidencelevel))=1;
        evaluation(find(evaluation<confidencelevel))=0;
        [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
        FunctionValue=[fpr,tpr];
        
    tempa=zeros(1,2);
    tempa(1,1)=1;
    tempa(1,2)=1;
    tempb=zeros(1,2);
    tempb(1,1)=0;
    tempb(1,2)=0;
    pareto=chraarea(FunctionValue);
    pareto=[pareto;tempa;tempb];%将这两点加入到种群中，使得计算出来的面积更精确
    sum=calculatearea(pareto);
    convexhullMOEADtrain(countnumber,1)=sum;
    
    [temp,sum]=areaoftest(population,datasettest,confidencelevel,whethertest);
    convexhullMOEADtest(countnumber,1)=sum;
    
   countnumber=countnumber+1;
   disp(['it is MOEAD: ' num2str(evaluationnum)]);
    
    end
    
   firstfronttrainMOEADtemp=pareto;
   firstfronttestMOEADtemp=temp;
    firstFrontEnd = firstfronttestMOEADtemp;
    
firstfronttrainMOEADtemp(size(firstfronttrainMOEADtemp,1)-1:size(firstfronttrainMOEADtemp,1),:)=[];
firstfronttestMOEADtemp(size(firstfronttestMOEADtemp,1)-1:size(firstfronttestMOEADtemp,1),:)=[];
totalTime=toc;
end 
