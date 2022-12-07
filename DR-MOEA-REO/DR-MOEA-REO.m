function DR-MOEA-REO()

%%
%--------------------------------------------------------------------------

   %Parameter setting
   clc;
   clear;
   format short;
   %fprintf('根据参考点的密度来移动参考点，21个参考点-40\n');
for myr = 3 : 3
fprintf('raito=%d\n',myr);
for s =16 : 16%数据集 
    
         [datasetsource,whether,name] = LOADdata(s);
         datasetsource= mapminmax(datasetsource);%数据归一化(-1,1)
         datasetsource  =  datasetsource';
         %dirpath=['jg_20220325\r=',num2str(parar*0.1),'\u=',num2str(myr*0.1),'\',name];
         dirpath=['jg_20220314\u=',num2str(myr*0.1),'\',name];
         fprintf('数据集开始-%s\n',name);
         
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        raito = myr;  %噪音添加1,2,3.。0表示不添加噪音，添加10%，20%，30%噪音
        repetition = 5 ;
        Parameter = 0.2;
        K = 5;    %  KN=0;%保留阈值的种群个数
        N = 100;%种群大小
        Narchive=N-2;%外部文档2的种群大小
        confidencelevel = 0;
        Generations = 300;%迭代次数
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        FAUCH_test = zeros(repetition,1);
        FAUCH_train = zeros(repetition,1);
        Curve_CHtrain = 0;
        Curve_CHtest = 0;
        time = zeros(repetition,1); 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    for rep = 1 : repetition %跑多少遍
            %flag=0;
            warning('off'); 
            fprintf('第%d遍\n',rep);  
            fanwei=1;
%            PTT=0;
%            TBB=0;
      % Y=0.1;
       
%       archive =[];
%       archive0=[];
%       archive1=[];
%       archive2=[];
%       archive3=[];
%       archive4=[];
%       Populationtrain1=[];
%       Populationbaoliu11=[];
%       Populationbaoliu12=[];
       cankaotrain=0;
       cankaotest=0;
   %% Generate random population
        %将数据集随机分成五个部分，分别给以标号1~5
        Indices1 = crossvalind('Kfold', sum(whether==0), K);
        Indices2 = crossvalind('Kfold', sum(whether==1), K); 
        Indices = [Indices1;Indices2];
        tic;
        for crossnumber  =  1 : K        
          Y=0.1;      
           PointsY1=[0;0;0;0;0;0;0;0;0;0;0];
          PointsY2=[1;0.9;0.8;0.7;0.6;0.5;0.4;0.3;0.2;0.1;0];
          PointsX1=[0;0.1;0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9;1];
          PointsX2=[1;1;1;1;1;1;1;1;1;1;1];
          PointsY=[PointsY1,PointsY2];
          PointsX=[PointsX1,PointsX2];
          Points=[PointsY(1,:);PointsX(1,:);PointsX(2,:);PointsY(2,:);PointsX(3,:);PointsY(3,:);PointsX(4,:);PointsY(4,:);PointsX(5,:);PointsY(5,:);PointsX(6,:);PointsY(6,:);PointsX(7,:);PointsY(7,:);PointsX(8,:);PointsY(8,:);PointsX(9,:);PointsY(9,:);PointsX(10,:);PointsY(10,:);PointsX(11,:);PointsY(11,:);];
          Populationbaoliu=[];
          Populationbaoliu1=[];
          C=[]; 
          C1=[];
          convexhullkneetrain=[];
          convexhullkneetest=[];
           datasettrain  =  datasetsource((Indices~=crossnumber),:);%%五折交叉
           datasettrain  =  datasettrain';
           whethertrain  =  whether((Indices~=crossnumber));
           datasettest  =  datasetsource((Indices==crossnumber),:);
           datasettest  =  datasettest';
           whethertest  =  whether((Indices==crossnumber));

       
            %给每类样本添加ratio比例的噪音样本
            if raito>=1
                   index0 = find(whethertrain==0);n0 = length(index0);
                   RenewIndex0 = index0(randperm(n0,ceil(n0*raito/10)));
                   whethertrain(RenewIndex0)=1;
                   index1 = find(whethertrain==1);n1 = length(index1);
                   RenewIndex1 = index1(randperm(n1,ceil(n1*raito/10)));
                   whethertrain(RenewIndex1)=0;
            end
       
       if crossnumber==1      
           poplength  =  size(datasettrain,1);%对应于种群的维度，即列数
           minvalue1  =  ones(1,poplength)*(-1);%%边界
           maxvalue1  =  ones(1,poplength);
           Boundary  =  [maxvalue1;minvalue1];                          %%上下边界
           minvalue  =  repmat(ones(1,poplength),N,1)*(-1);        %个体最小值
           maxvalue  =  repmat(ones(1,poplength),N,1);             %个体最大值       
           population  =  rand(N,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群
       end
   %%%%在训练集上     
       evaluation  =  population*datasettrain*10^(-3);
       evaluation((evaluation>=confidencelevel))  =  1;
       evaluation((evaluation<confidencelevel))  =  0;   
       [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
       FunctionValue=  [fpr,tpr];
       Population=population;    
       %%聚类
        [datset,lable,Distb]= kMeans(datasettrain',2,whethertrain',Parameter);  
        [A,~]=NSGA22(Population,N,100,confidencelevel,lable',datset',Boundary,datasettest,whethertest);
        sxn=size(A,2);
    %% Optimization
        for g  = 1 : Generations  %%循环迭代  
            Y=Y/g;            
        Offspring = P_generator(Population,Boundary,'Real',N );%%产生子代
        evaluation=  Offspring *datasettrain*10^(-3);
        evaluation((evaluation>=confidencelevel))=1;
        evaluation((evaluation<confidencelevel))=0;       
       [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
         QFun=[fpr,tpr];%子代          
         Population1=[Population;Offspring];
         FunctionValue1=[FunctionValue;QFun]; 
        [FunctionValue,Population]=clos(Points,FunctionValue1,N,Population1);

 %%    更新保留种群
%%选小于阈值的点
  M1=size(Points,1);
  NN1=size(FunctionValue1,1);
  %discankao1=[];
  ind1=[];
 for i=1:M1
    distance1=zeros(1,NN1);
    %paixu1=[];
    %index1=[];
    for j=1:NN1
        distance1(j)=sqrt((Points(i,1)-FunctionValue1(j,1))^2+(Points(i,2)-FunctionValue1(j,2))^2);
    end
    [paixu1,index1]=sort(distance1);
if paixu1(1) <=Y
%% 
 %M2=M1-2;
 %Ydist=[];
 %Xdist=[];
 Ydist=caly(PointsY2);
 Xdist=calx(PointsX1);
 [~,indY] =max(Ydist);
 [~,indX] =max(Xdist);
 if i~=1
 if mod(i,2)==0
     i=i/2; 
          PointsY2(i)=(PointsY2(indY)+PointsY2(indY+1))/2;
          PointsY2=sort(PointsY2,1,'descend');
          PointsY=[PointsY1,PointsY2];
          Points=[PointsY(1,:);PointsX(1,:);PointsX(2,:);PointsY(2,:);PointsX(3,:);PointsY(3,:);PointsX(4,:);PointsY(4,:);PointsX(5,:);PointsY(5,:);PointsX(6,:);PointsY(6,:);PointsX(7,:);PointsY(7,:);PointsX(8,:);PointsY(8,:);PointsX(9,:);PointsY(9,:);PointsX(10,:);PointsY(10,:);PointsX(11,:);PointsY(11,:);];
 else
     i=(i+1)/2;

          PointsX1(i)=(PointsX1(indX)+PointsX1(indX+1))/2;
          PointsX1=sort(PointsX1,1,'ascend');
          PointsX=[PointsX1,PointsX2];    
          Points=[PointsY(1,:);PointsX(1,:);PointsX(2,:);PointsY(2,:);PointsX(3,:);PointsY(3,:);PointsX(4,:);PointsY(4,:);PointsX(5,:);PointsY(5,:);PointsX(6,:);PointsY(6,:);PointsX(7,:);PointsY(7,:);PointsX(8,:);PointsY(8,:);PointsX(9,:);PointsY(9,:);PointsX(10,:);PointsY(10,:);PointsX(11,:);PointsY(11,:);];
 end
 end
  %%   
 %%
  ind1=[ind1;index1(1)];
  Populationbaoliu11=Population1(ind1,:);
  Populationbaoliu=[Populationbaoliu;Populationbaoliu11];
  KN=size(Populationbaoliu,1);
  if KN>98
       evaluation= Populationbaoliu*datasettrain*10^(-3);
        evaluation((evaluation>=confidencelevel))=1;
        evaluation((evaluation<confidencelevel))=0;       
       [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
         knf=[fpr,tpr];%子代
          [U,R]=splitpopulation(knf);%%分为冗余和非冗余    
         if size(U,1)<=Narchive%此处应该是98，也就是N-2，是需要保留的个数
         %resultstemp=[];
        number=randperm(size(R,1));
        resultstemp=[U;R(number(1:Narchive-size(U,1)),:)]; 
        else
        %resultstemp=[];
        resultstemp=Reduce(U,size(knf,1)-Narchive,fanwei);
        end
    number=findsequence(resultstemp,knf);
    Populationbaoliu=Populationbaoliu(number,:);
  end
end
end
 %%
 %选落在坐标轴上的点
        tpr1=FunctionValue1(:,1)==0;
        maxtpr=max(FunctionValue1(tpr1,2));
        if(isempty( maxtpr))
          maxtpr=0;
        end
        archive1=[0,maxtpr];      
        fpr1=FunctionValue1(:,2)==1;    
        minfpr=min(FunctionValue1(fpr1,1));
        if(isempty(minfpr))
         minfpr=1;
        end
        archive2=[minfpr,1];
        archive3=[archive1;archive2];
        for i=1:size(archive3,1)
            for j=1:size(FunctionValue1,1)
                if archive3(i,:)==FunctionValue1(j,:)
                   C=[C;j];          
                end
            end
        end
     C=unique(C);
   Populationbaoliu12=Population1(C,:);
   k=size(Populationbaoliu12,1);
        if k>2
         Populationbaoliu12=Populationbaoliu12(randperm(k, 2),:);
        end
  Populationbaoliu1=[ Populationbaoliu1;Populationbaoliu12];
%    end
 %%对坐标轴上的点只保留两个
       if (isempty(Populationbaoliu1))
          Populationbaoliu1=[];         
       else
        evaluation=Populationbaoliu1*datasettrain*10^(-3);
        evaluation((evaluation>=confidencelevel))=1;
        evaluation((evaluation<confidencelevel))=0;
        [ztpr,zfpr]=calculatetprandfpr(evaluation,whethertrain);
        zuobiao=[zfpr,ztpr];
   
        ztpr1=zuobiao(:,1)==0;
        zmaxtpr=max(zuobiao(ztpr1,2));
        if(isempty( zmaxtpr))
          zmaxtpr=0;
        end
        archive11=[0,zmaxtpr];      
        zfpr1=zuobiao(:,2)==1;    
        zminfpr=min(zuobiao(zfpr1,1));
        if(isempty(zminfpr))
         zminfpr=1;
        end
        archive22=[zminfpr,1];
        archive33=[archive11;archive22];
        for i=1:size(archive33,1)
            for j=1:size(zuobiao,1)
                if archive33(i,:)==zuobiao(j,:)
                C1=[C1;j];          
                end
            end
        end
     C1=unique(C1);
  Populationbaoliu1=Populationbaoliu1(C1,:);
  k=size(Populationbaoliu1,1);
            if k>2
              Populationbaoliu1= Populationbaoliu1(randperm(k,2),:);
            end
       end

        blPopulation=[Populationbaoliu;Populationbaoliu1];                                                                                                                                                                                                                               ;
%%
      %% 
 %计算扰动方向和半径
       [index,~,~]=areaoftest(Population,datasettrain,confidencelevel,whethertrain);%求出在前沿面上的个体      
       Archive=Population(index,:);      
       nonindex=setdiff((1:100)',index,'rows');  
        nonarchive=Population(nonindex,:);           
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
       
        Population=[Archive;newnonarchive];

%%在训练集和测试集上计算auc只值
        Populationhb=[blPopulation;Population];
        evaluation= Populationhb*datasettrain*10^(-3);
        evaluation((evaluation>=confidencelevel))=1;
        evaluation((evaluation<confidencelevel))=0;       
        [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);         
        zFunctionValue=[fpr,tpr];      
        Points1=[0 1;0 1;0.1 1;0 0.9;0.2 1;0 0.8;0.3 1;0 0.7;0.4 1;0 0.6;0.5 1;0 0.5;0.6 1;0 0.4;0.7 1;0 0.3;0.8 1;0 0.2;0.9 1;0 0.1;1 1;0 0];%22个坐标
        %在训练集上计算FunctionValue
        [FunctionValuetrain,Populationhb]=clos(Points1,zFunctionValue,N,Populationhb);  
        %在测试集上计算FunctionValue
        evaluation= Populationhb*datasettest*10^(-3);
        evaluation((evaluation>=confidencelevel))=1;
        evaluation((evaluation<confidencelevel))=0;       
        [tpr,fpr]=calculatetprandfpr(evaluation,whethertest);
        FunctionValuetest=[fpr,tpr];
        
        %训练集上计算凸包面积
        paretotrain=sortrows(FunctionValuetrain);
        paretotrain=[0 0;paretotrain;1 1];
        [~,paretotubaotrainck]=chraarea(paretotrain);%画出凸包
        TBtrain=calculatearea(paretotubaotrainck);%计算凸包的面积
        convexhullkneetrain=[convexhullkneetrain;TBtrain];
        %测试集上计算凸包面积
        pareto=sortrows(FunctionValuetest);
        pareto=[0 0;pareto;1 1];
        [~,paretotubaotestck]=chraarea(pareto);%画出凸包
        TBtest=calculatearea(paretotubaotestck);%计算凸包的面积
        convexhullkneetest=[convexhullkneetest;TBtest];
        end%%迭代结束
        cankaotrain=cankaotrain+convexhullkneetrain;
        cankaotest=cankaotest+convexhullkneetest;
   
        end %%K折循环结束
        t=toc;
        time(rep,1)=t/K;
        Curve_CHtrain = Curve_CHtrain + cankaotrain/K;
        Curve_CHtest = Curve_CHtest + cankaotest/K;
        FAUCH_train(rep,1) = cankaotrain(end)/K*100;
        FAUCH_test(rep,1) = cankaotest(end)/K*100;
    end%结束遍
        AuchMeanCurve_Train = Curve_CHtrain/repetition;
        AuchMeanCurve_Test = Curve_CHtest/repetition;
        performance_test = [mean(FAUCH_test,'all'),std(FAUCH_test,0,'all')];
        performance_train = [mean(FAUCH_train,'all'),std(FAUCH_train,0,'all')];
        MeanTime = [mean(time,'all'),std(time,0,'all')];
        fprintf('%.2f %.2f\n',performance_test(1),performance_test(2));
        %disp(performance_test);
        %disp(MeanTime);

        save([dirpath,'\','AuchMeanCurve_Train.mat'],'AuchMeanCurve_Train');
        save([dirpath,'\','AuchMeanCurve_Test.mat'],'AuchMeanCurve_Test');

        save([dirpath,'\','FAUCH_test.mat'],'FAUCH_test');
        save([dirpath,'\','performance_test.mat'],'performance_test');
        save([dirpath,'\','FAUCH_train.mat'],'FAUCH_train');
        save([dirpath,'\','performance_train.mat'],'performance_train');
        save([dirpath,'\','MeanTime.mat'],'MeanTime');
        save([dirpath,'\','time.mat'],'time');
        
end%结束数据集
end
end
        
%%
  
% %       %保存凸包下面积
%       lujingtrain=[dirpath,'\','mcankaotrain.mat'];
%       lujingtest=[dirpath,'\','mcankaotest.mat'];
%       tubaoqianyanmiantrain=[dirpath,'\','paretotubaotrainck.mat'];
%       tubaoqianyanmiantest=[dirpath,'\','paretotubaotestck.mat'];
%       
%       lujingtime=[dirpath,'\','time.mat'];
%       save(lujingtrain,'mcankaotrain');
%       save(lujingtest,'mcankaotest');
%       save(lujingtime,'time'); 
%         
%       save(tubaoqianyanmiantrain,'paretotubaotrainck');
%       save(tubaoqianyanmiantest,'paretotubaotestck');
% %      fprintf('%f\n', (cankaotrain/5)*100);
% %      fprintf('\n');
%       fprintf('%s-%f\n',name,mcankaotest(end,:)*100);
%       
% %    plot(Points(:,1),Points(:,2),'p')
% %    hold on
% %    plot(FunctionValuetest(:,1),FunctionValuetest(:,2),'*r')
%     end%数据集循环
%         


    
