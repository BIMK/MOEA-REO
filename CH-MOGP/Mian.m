%%TANGKE
clc
clear;
dbstop if error;
%%
for x=1 : 1%遍数循环
      fprintf('第%d遍\n',x); 
for s = 21:28%数据集循环     
        flag=0;
tic;
fanwei=1;
popnum=100; %种群大小(须为偶数)
confidencelevel=0;%预值
TBB=0;
raito=1;%噪音添加1,2,3.。0表示不添加噪音，添加10%，20%，30%噪音
generation=400;%最大迭代次数
Gmin=100;%数据子集迭代次数
K=5;%五折交叉
  tubaotrain15=0;
  tubaotest15=0;
[datasetsource,whether]=inputdataset19new(s);
 datasetsource= mapminmax(datasetsource);%数据归一化（-1，1）
Indices =crossvalind('Kfold', size(datasetsource,2), K); %将数据集随机分成五个部分，分别给以标号1~5
datasetsource=datasetsource';
tic;
 for crossnumber=1:K%%分训练和测试
      convexhullkneetrain=[];
      convexhullkneetest=[];
    datasettrain=datasetsource(find(Indices~=crossnumber),:);
   datasettrain=datasettrain';
    whethertrain=whether(find(Indices~=crossnumber));
    datasettest=datasetsource(find(Indices==crossnumber),:);
   datasettest=datasettest';
    whethertest=whether(find(Indices==crossnumber));
    %添加噪音样本
               T=length(whethertrain);
                if raito>=1
               index= randperm(T,ceil(raito/10*T));
               index1=find(whethertrain(index)==1);
               index2=find(whethertrain(index)==0);
               whethertrain(index(index1))=0;
               whethertrain(index(index2))=1;
                end

%%%%%在训练集上
     poplength=size(datasettrain,1);%用作产生newpopulation时的参数
     minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %个体最小值
     maxvalue=repmat(ones(1,poplength),popnum,1);    %个体最大值
     minvalue1  =  ones(1,poplength)*(-1);%%边界
     maxvalue1  =  ones(1,poplength);
     Boundary  =  [maxvalue1;minvalue1]; 
     population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群
     Population=population;
%%聚类
      [datset,lable,Distb]= kMeans(datasettrain',2,whethertrain');  
    [A,areasum]=NSGA22(population,popnum,Gmin,confidencelevel,lable',datset',Boundary,datasettest,whethertest);
       sxn=size(A,2);
%训练w
for m=1:generation   
    Offspring = P_generator(Population,Boundary,'Real',popnum );
    newpopulation=[Population;Offspring];   
     evaluation=newpopulation*datasettrain*10^(-3); 
     evaluation(find(evaluation>=confidencelevel))=1;
     evaluation(find(evaluation<confidencelevel))=0;    
     [tpr,fpr]=Evaluation(evaluation,whethertrain,newpopulation,datasettrain,confidencelevel);
    results=[fpr,tpr];%   
    [U,R]=splitpopulation(results);%%分为冗余和非冗余    
    if size(U,1)<=popnum
        resultstemp=[];
        number=randperm(size(R,1));
        resultstemp=[U;R(number(1:popnum-size(U,1)),:)]; 
    else
        resultstemp=[];
        resultstemp=Reduce(U,size(results,1)-popnum,fanwei);
    end
    number=findsequence(resultstemp,results);
    Population=newpopulation(number,:);
%%
%计算扰动方向和半径
      [index,~,~]=areaoftest(population,datasettrain,confidencelevel,whethertrain);%求出在前沿面上的个体      
       Archive=population(index,:);      
       nonindex=setdiff((1:100)',index,'rows');  
        nonarchive=population(nonindex,:);           
       nonarchive_central_point=sum(nonarchive,1)/size(nonarchive,1);%非外部文档中心点
           B=nonarchive_central_point;
           direction=A-B;%扰动方向
           NN=size(nonarchive,1);
           M=size(nonarchive,2);
           Similarity=zeros(NN,1);
           step=zeros(NN,1);
           disturb=zeros(NN,M);
            X1=[B;A];
            Sim=1-pdist(X1,'cosine');      
            DisC=(Sim+Distb)/2;    %扰动系数           
      for r=1:NN
          CC=nonarchive(r,:);
          X=[CC;A];
          Similarity(r,:)=1-pdist(X,'cosine');
          step(r,:)=(Similarity(r,:)+Distb)*DisC;
          disturb(r,:)=step(r,:)*direction;
      end   
         newnonarchive=nonarchive+disturb;%扰动后新种群  
       %
       Population=[Archive;newnonarchive];
    %%
     evaluation=Population*datasettrain*10^(-3);
     evaluation(find(evaluation>=confidencelevel))=1;
     evaluation(find(evaluation<confidencelevel))=0;      
     [tpr,fpr]=Evaluation(evaluation,whethertrain,Population,datasettrain,confidencelevel);
     FunctionValuetrain=[fpr,tpr];%
     FunctionValuetrain=sortrows(FunctionValuetrain);
     FunctionValuetrain=[0 0;FunctionValuetrain;1 1];
     [indexc,paretotubaotrain]=chraarea(FunctionValuetrain);%画出凸包
    TBtrain=calculatearea(paretotubaotrain);%计算凸包的面积
    convexhullkneetrain=[convexhullkneetrain;TBtrain];
%%在测试集上计算auc值
        evaluation=Population*datasettest*10^(-3);
        evaluation((evaluation>=confidencelevel))=1;
        evaluation((evaluation<confidencelevel))=0;
        [tpr,fpr]=Evaluation(evaluation,whethertest,Population,datasettest,confidencelevel);
        FunctionValue=[fpr,tpr];
         paretotest=FunctionValue;
         paretotest=sortrows(paretotest);
         paretotest=[0 0;paretotest;1 1]; 
        [indexc,paretotubaotest]=chraarea(paretotest);%画出凸包
        TBtest=calculatearea(paretotubaotest);%计算凸包的面积
        convexhullkneetest=[convexhullkneetest;TBtest];
end%迭代结束


 tubaotrain15=tubaotrain15+convexhullkneetrain;
 tubaotest15=tubaotest15+convexhullkneetest;

 end%K循环结束
                   t=toc;
                  time=t/K;
  mtubaotrain15=tubaotrain15/K;
  mtubaotest15=tubaotest15/K;
            switch s
             case 1
                    name='Ionosphere';
              case 21
                    name='appendicitis';              
              case 3
                    name='coil2000';
              case 4
                    name='Parkinsons';
              case 22
                    name='haberman';
              case 23
                    name='liver-disorders';
              case 24
                    name='fourclass';              
              case 25
                    name='mammogra';
              case 26
                    name='breast';
              case 27
                    name='heart';
              case 11
                    name='ecoli1';
              case 28
                    name='wisconsin';              
              case 13
                    name='wdbc';
              case 14
                    name='sonarall';
              case 15
                    name='pima';
              case 16
                    name='titanic';
               case 17
                    name='madelon';              
              case 18
                    name='vehicle3';
              case 19
                    name='skin';      
           
             end
     %datapath='C:\Users\Mr.Simple\Desktop\CH-MOGP\CH-MOGP - 10%噪音\实验结果\';%储存的文件夹路径
     dirpath=['jg_20220302','\',name];
      %保存凸包下面积
      Ydataconvexhullareakneetrain=[dirpath,'\','mtubaotrain15.mat'];
      Ydataconvexhullareakneetest=[dirpath,'\','mtubaotest15.mat'];
      
        tubaoqianyanmiantrain=[dirpath,'\','paretotubaotrain.mat'];
         tubaoqianyanmiantest=[dirpath,'\','paretotubaotest.mat'];
      
%        lujingtime=[dirpath,'\','time.mat'];
      save(Ydataconvexhullareakneetrain,'mtubaotrain15');
      save(Ydataconvexhullareakneetest,'mtubaotest15');
%       save(lujingtime,'time'); 
%         
       save(tubaoqianyanmiantrain,'paretotubaotrain');
      save(tubaoqianyanmiantest,'paretotubaotest');
      
  fprintf('%s-%f\n', name,mtubaotest15(end,:)*100)
                %data(s)=mtubaotest15(end,:)*100;
         %dlmwrite('output.txt',data(s),'-append','delimiter',',') 

 end%数据集循环
      % data2=1;
       %dlmwrite('output.txt',data2,'-append','delimiter',',') 
end%循环遍数
 %
 
 
