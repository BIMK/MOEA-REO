clc;
clear;
%%
dbstop if error;

%popnum=50; %种群大小(须为偶数)
trainset=cell(1,5);
lable=cell(1,5);
ZAUC=[];
for r =  1 : 4
    fprintf('raito-%d\n',r);
for s = 107 : 107 %数据集
    
        [datasetsource,whether,name] = LOADdata(s); %datasetnumber代表当前测试的数据集
        datasetsource= mapminmax(datasetsource); %数据归一化（-1，1）
        datasetsource=datasetsource';
        
        %dirpath=['jg_20220325\r=',num2str(parar*0.1),'\u=',num2str(r*0.1),'\',name];
        dirpath=['jg_20220404\u=',num2str(r*0.1),'\',name];
        fprintf('数据集开始-%s\n',name);
        
        raito = r; %噪音添加1,2,3.。0表示不添加噪音，添加10%，20%，30%噪音

        Again = 5;
        Parameter = 0.2;
        confidencelevel=0;%预值
        K=5;%五折交叉
        popnum=100;
        Maxfit=300;%最大迭代次数%代数
        JLDD=100;%聚类后迭代次数
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        FAUCH_test = zeros(Again,1);
        FAUCH_train = zeros(Again,1);
        Curve_CHtrain = 0;
        Curve_CHtest = 0;
        time = zeros(Again,1); 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      
    for d = 1 : Again%遍数
        
        fprintf('第%d遍\n',d);
        flag=0;
        aa=0;
        convexhullareafornsgatrain=0;
        convexhullareafornsgatest=0;
        %将数据集随机分成五个部分，分别给以标号1~5
        Indices1 = crossvalind('Kfold', sum(whether==0), K);
        Indices2 = crossvalind('Kfold', sum(whether==1), K); 
        Indices = [Indices1;Indices2];

        tic; 
        for crossnumber = 1 : K
          
            datasettrain=datasetsource((Indices~=crossnumber),:);
            datasettrain=datasettrain';
            whethertrain=whether((Indices~=crossnumber));
            datatrain=[datasettrain;whethertrain];


            datasettest=datasetsource((Indices==crossnumber),:);
            datasettest=datasettest';
            whethertest=whether((Indices==crossnumber));
            
            %给每类样本添加ratio比例的噪音样本
            if raito>=1
                   index0 = find(whethertrain==0);n0 = length(index0);
                   RenewIndex0 = index0(randperm(n0,ceil(n0*raito/10)));
                   whethertrain(RenewIndex0)=1;
                   index1 = find(whethertrain==1);n1 = length(index1);
                   RenewIndex1 = index1(randperm(n1,ceil(n1*raito/10)));
                   whethertrain(RenewIndex1)=0;
            end
   %初始种群
            if crossnumber==1
                   poplength=size(datasettrain,1);%用作产生newpopulation时的参数,特征数目
                   minvalue1  =  ones(1,poplength)*(-1);%%边界
                   maxvalue1  =  ones(1,poplength);
                   Boundary  =  [maxvalue1;minvalue1];  
                   minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %个体最小值
                   maxvalue=repmat(ones(1,poplength),popnum,1);    %个体最大值
                   population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群
            end   
                
  

            [datset,lable,Distb]= kMeans(datasettrain',2,whethertrain',Parameter);
            [A,areasum]=NSGA22(population,popnum,JLDD,confidencelevel,lable',datset',Boundary,datasettest,whethertest);
            sxn=size(A,2);
            if sxn~=poplength
                fprintf('聚类失败 \n');
                flag=1;
                break; 
            end

            [convexhullnsgatrain,convexhullnsgatest,firstfronttrainnsgatemp,firstfronttestnsgatemp]=NSGA2(A,Distb,population,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest,Boundary);
            convexhullareafornsgatrain=convexhullareafornsgatrain+convexhullnsgatrain;
            convexhullareafornsgatest=convexhullareafornsgatest+convexhullnsgatest;
            aa=aa+areasum;
%         firstfronttrainnsga=[firstfronttrainnsga;firstfronttrainnsgatemp];
%         firstfronttestnsga=[firstfronttestnsga;firstfronttestnsgatemp];
                           

        end %结束五折
        t=toc;
        time(d,1) = t/K;
        if flag==1
            continue;
        end
        
        Curve_CHtrain = Curve_CHtrain + convexhullareafornsgatrain/K;
        Curve_CHtest = Curve_CHtest + convexhullareafornsgatest/K;
        FAUCH_train(d,1) = convexhullareafornsgatrain(end)/K*100;
        FAUCH_test(d,1) = convexhullareafornsgatest(end)/K*100;
    end%结束轮
        
        AuchMeanCurve_Train = Curve_CHtrain/Again;
        AuchMeanCurve_Test = Curve_CHtest/Again;
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
        firstfronttest2 = firstfronttestnsgatemp;
        save([dirpath,'\','firstfronttest2.mat'],'firstfronttest2');
end%数据集遍历结束
        
end

        
%          juli=aa/K;

            %datapath='E:\张强强\NSGA-II\NSGA-2鲁棒算法有噪音 - 10%-20%的数据子集+噪音率取平均 - 绕动系数自适应\实验结果\';%储存的文件夹路径

            %% 保存面积数据和第一层pareto面上的点数据
      
%             datafirstfrontnsgatrain=[dirpath,'\','firstfrontnsgatrain.mat'];
%             datafirstfrontnsgatest=[dirpath,'\','firstfrontnsgatest.mat'];
%              datafirstfrontnsgatrain1=[dirpath,'\','firstfronttrainnsgatemp.mat'];
%             datafirstfrontnsgatest1=[dirpath,'\','firstfronttestnsgatemp.mat'];
            
%             
% 
%            dataconvexhullareansgatrain=[dirpath,'\','convexhullareansgatrain.mat'];
%             dataconvexhullareansgatest=[dirpath,'\','convexhullareansgatest.mat'];
%              lujingtime=[dirpath,'\','time.mat'];
%             %保存第一层pareto面上的点坐标
%             save(datafirstfrontnsgatrain,'firstfronttrainnsga');
%             save(datafirstfrontnsgatest,'firstfronttestnsga');
%             save(datafirstfrontnsgatrain1,'firstfronttrainnsgatemp');
%             save(datafirstfrontnsgatest1,'firstfronttestnsgatemp');
%             
%              save(lujingtime,'time'); 
% 
%             %保存凸包下面积 
%              fprintf('%f\n',ZAUC); 
  
%              fprintf('聚类%f\n',juli(end,:)*100);       
%   fprintf('14个数据集总时间%f\n',sum(time)); 
  % fprintf('\n');
%     end      
% end
