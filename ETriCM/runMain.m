clc;
clear;
%%
dbstop if error;

for myR = 1 : 4
    fprintf('raito=%d\n',myR);
for s = 16 : 16  %数据集
    
    [datasetsource,whether,name] = LOADdata(s);%datasetnumber代表当前测试的数据集
    datasetsource= mapminmax(datasetsource);%数据归一化（-1，1）            
    datasetsource=datasetsource';
    dirpath=['jg_20220309\u=',num2str(myR*0.1),'\',name];
    fprintf('数据集-%s\n',name);
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    raito = myR;%噪音添加1,2,3.。0表示不添加噪音，添加10%，20%，30%噪音
    Parameter = 0.5;
    repetition = 5;
    confidencelevel=0;%预值
    K=5;%五折交叉
    Maxfit = 300;%最大迭代次数
    JLDD = 100;%聚类迭代次数
    %导入数据集(处理之后的数据类型都是属性*样本)
    popnum=100;
    rate=0.2;
    %fprintf('ETriCM-聚类引导+无标签更改—10-20的数据子集 \n');
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    FAUCH_test = zeros(repetition,1);
    FAUCH_train = zeros(repetition,1);
    Curve_CHtrain = 0;
    Curve_CHtest = 0;
    time = zeros(repetition,1); 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    for x = 1 : repetition %  遍数
             %flag=0;
         %fprintf('第%d遍\n',x);
         convexhullareatrain=0;
         convexhullareatest=0;
         
        Indices1 = crossvalind('Kfold', sum(whether==0), K);
        Indices2 = crossvalind('Kfold', sum(whether==1), K); 
        Indices = [Indices1;Indices2];
            
       
%             firstfronttrainETriCM=[];
%             firstfronttestETriCM=[];
         tic;            
        for crossnumber=1:K
                datasettrain=datasetsource((Indices~=crossnumber),:);
                datasettrain=datasettrain';
                whethertrain=whether((Indices~=crossnumber));
                
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
                
                if crossnumber==1
                    poplength=size(datasettrain,1);%用作产生newpopulation时的参数
                    minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %个体最小值
                    maxvalue=repmat(ones(1,poplength),popnum,1);    %个体最大值
                     minvalue1  =  ones(1,poplength)*(-1);%%边界
                     maxvalue1  =  ones(1,poplength);
                     Boundary  =  [maxvalue1;minvalue1]; 
                    population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群
                end
          %纯净子集训练种群
  [datset,lable,Distb]= kMeans(datasettrain',2,whethertrain',Parameter);
   [A,areasum]=NSGA22(population,popnum,JLDD,confidencelevel,lable',datset',Boundary,datasettest,whethertest);
       sxn=size(A,2);

                
                [convexhullETriCMtrain,convexhullETriCMtest,~,~] = ...
                    chthree(A,Distb,population,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest);
                convexhullareatrain=convexhullareatrain+convexhullETriCMtrain;
                convexhullareatest=convexhullareatest+convexhullETriCMtest;

%                 firstfronttrainETriCM=[firstfronttrainETriCM;firstfronttrainETriCMtemp];
%                 firstfronttestETriCM=[firstfronttestETriCM;firstfronttestETriCMtemp];
             
        end%结束K折
             
%   if flag==1
%  continue;
%  end      
            
        t=toc;
        time(x,1)=t/K;
        Curve_CHtrain = Curve_CHtrain + convexhullareatrain/K;
        Curve_CHtest = Curve_CHtest + convexhullareatest/K;
        FAUCH_train(x,1) = convexhullareatrain(end)/K*100;
        FAUCH_test(x,1) = convexhullareatest(end)/K*100;
    end%结束遍
        AuchMeanCurve_Train = Curve_CHtrain/repetition;
        AuchMeanCurve_Test = Curve_CHtest/repetition;
        performance_test = [mean(FAUCH_test,'all'),std(FAUCH_test,0,'all')];
        performance_train = [mean(FAUCH_train,'all'),std(FAUCH_train,0,'all')];
        MeanTime = [mean(time,'all'),std(time,0,'all')];
        %disp(performance_test);
        %disp(MeanTime);
        fprintf('%.2f %.2f\n',performance_test(1),performance_test(2));

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
            
            
%              switch d
%              case 1
%                     name='Ionosphere';
%               case 21
%                     name='appendicitis';              
%               case 3
%                     name='coil2000';
%               case 4
%                     name='Parkinsons';
%               case 22
%                     name='haberman';
%               case 23
%                     name='liver-disorders';
%               case 24
%                     name='fourclass';              
%               case 25
%                     name='mammogra';
%               case 26
%                     name='breast';
%               case 27
%                     name='heart';
%               case 11
%                     name='ecoli1';
%               case 28
%                     name='wisconsin';              
%               case 13
%                     name='wdbc';
%               case 14
%                     name='sonarall';
%               case 15
%                     name='pima';
%               case 16
%                     name='titanic';
%                case 17
%                     name='madelon';              
%               case 18
%                     name='vehicle3';
%               case 19
%                     name='skin';      
%            
%              end
%    
%           
%             %datapath='E:\张强强\种群更新\ETriCM\ETriCM - 10%\实验结果\';%储存的文件夹路径
%             dirpath=['jg_20220302','\',name];
%   
%             %% 保存面积数据和第一层pareto面上的点数据
%             datafirstfrontETriCMtrain=[dirpath,'\','firstfrontETriCMtrain.mat'];
%             datafirstfrontETriCMtest=[dirpath,'\','firstfrontETriCMtest.mat'];
% %             
%             dataconvexhullareaETriCMtrain=[dirpath,'\','convexhullareaETriCMtrain.mat'];
%             dataconvexhullareaETriCMtest=[dirpath,'\','convexhullareaETriCMtest.mat'];
%               lujingtime=[dirpath,'\','time.mat'];
% 
%             
%             %保存第一层pareto面上的点坐标
%             save(datafirstfrontETriCMtrain,'firstfronttrainETriCM');
%             save(datafirstfrontETriCMtest,'firstfronttestETriCM');
% % 
% %             %保存凸包下面积
%             save(dataconvexhullareaETriCMtrain,'convexhullareaETriCMtrain');
%             save(dataconvexhullareaETriCMtest,'convexhullareaETriCMtest');
% %                  save(lujingtime,'time'); 
% 
%         fprintf('%s-%f\n',name,convexhullareaETriCMtest(end,:)*100);
%         %
% %         data(d)=convexhullareaETriCMtest(end,:)*100;
% %          dlmwrite('output.txt',data(d),'-append','delimiter',',') 
%       end  
% %        data2=1;
% %        dlmwrite('output.txt',data2,'-append','delimiter',',') 
% end
% % fprintf('hello end');
