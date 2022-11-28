%2017.10.5修改，保存第一层pareto面，用于计算HV
tic;
clc;
clear all;
close all;

addpath('MOEAD','Public');

rate=0.5;
popnum=100; %种群大小(须为偶数)
confidencelevel=0;%预值
K=5;%五折交叉

Maxfit=30000;%最大迭代次数
MaxDataSet=16;%定义测试的数据集的个数
allRunTimes=1;%算法总的运行次数
datasetNumber=1;%跳过某些数据集的序号

allBestResultsTrain(1,1)={'alldata'};
allBestResultsTrain(1,2)={'MOEAD'};

allBestResultsTest(1,1)={'alldata'};
allBestResultsTest(1,2)={'MOEAD'};
% allBestResults(1,2)={'ETriCM'};
% allBestResults(1,3)={'NSGAII'};
% allBestResults(1,4)={'KnEA'};

allBestResultsTrain(2:14,1)=[{'australian'};{'transfusion'};{'magic'};{'pima-indians-diabetes'};{'musk1'};{'musk2'};{'Hill_Valley_without_noise_full'};{'Hill_Valley_with_noise_full'};{'skin'};{'a1a'};{'a2a'};{'w1a'};{'mushrooms'}];
allTimeMOEAD=0;
allBestResultsTest(2:14,1)=[{'australian'};{'transfusion'};{'magic'};{'pima-indians-diabetes'};{'musk1'};{'musk2'};{'Hill_Valley_without_noise_full'};{'Hill_Valley_with_noise_full'};{'skin'};{'a1a'};{'a2a'};{'w1a'};{'mushrooms'}];


allDataSetTime=[];%每个算法在每个数据集上运行所消耗的时间的总记录
allDataSetNumber=[1 2 3 6 7 8 10 11 12 13 14 15 16];
datasetNumber=1;
while datasetNumber<=13
    
    datasetInd = 15;
    
    allMatrixTempMOEAD=[];
    allTime=zeros(1,3);
    
    for totalRunTime=1:allRunTimes
        [datasetsource,whether,datasetName]=inputdataset(datasetInd);%datasetnumber代表当前测试的数据集
        Indices =crossvalind('Kfold', size(datasetsource,2), K); %将数据集随机分成五个部分，分别给以标号1~5
        datasetsource=datasetsource';
        

        convexhullareaforMOEADtrain=0;
        convexhullareaforMOEADtest=0;

        for crossnumber=1:1
            
            datasettrain=datasetsource(find(Indices~=crossnumber),:);
            datasettrain=datasettrain';
            whethertrain=whether(find(Indices~=crossnumber));
            
            datasettest=datasetsource(find(Indices==crossnumber),:);
            datasettest=datasettest';
            whethertest=whether(find(Indices==crossnumber));
            
            if crossnumber==1
                poplength=size(datasettrain,1);%用作产生newpopulation时的参数
                minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %个体最小值
                maxvalue=repmat(ones(1,poplength),popnum,1);    %个体最大值
                population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群
                source=population;
            end
            source=population;

            [firstFrontStartMOEAD,firstFrontEndMOEAD,convexhullMOEADtrain,convexhullMOEADtest,totalTime]=MOEADForFunction(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest);

            
            [firstFrontStartCH3,firstFrontEndCH3,convexhullETriCMtrain,convexhullETriCMtest,firstfronttrainETriCMtemp,firstfronttestETriCMtemp,totalTime]=chthree(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest);

            
            [firstFrontStartNSGA,firstFrontEndNSGA,convexhullnsgatrain,convexhullnsgatest,firstfronttrainnsgatemp,firstfronttestnsgatemp,totalTime]=NSGAIIfold(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest);

            
            [firstFrontStartConvex,firstFrontEndConvex,convexhullkneetrain,convexhullkneetest,firstfronttrainKneetemp,firstfronttestKneetemp,totalTime]=ROCwithKnee(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest,rate);

            
            

            %用于对比四个算法的第一层面
            figure(1)
            plot(firstFrontStartMOEAD(:,1),firstFrontStartMOEAD(:,2),'*r');
            hold on
            plot(firstFrontStartCH3(:,1),firstFrontStartCH3(:,2),'*k');
            hold on
            plot(firstFrontStartNSGA(:,1),firstFrontStartNSGA(:,2),'*b');
            hold on
            plot(firstFrontStartConvex(:,1),firstFrontStartConvex(:,2),'*g');
            xlabel('FPR');
            ylabel('TPR');
            title(datasetName);
            legend('MOEA/D','ETriCM','NSGAII','CN-KnEA');

            
            
            figure(2)
            plot(firstFrontEndMOEAD(:,1),firstFrontEndMOEAD(:,2),'*r');
            hold on
            plot(firstFrontEndCH3(:,1),firstFrontEndCH3(:,2),'*k');
            hold on
            plot(firstFrontEndNSGA(:,1),firstFrontEndNSGA(:,2),'*b');
            hold on
            plot(firstFrontEndConvex(:,1),firstFrontEndConvex(:,2),'*g');
            xlabel('FPR');
            ylabel('TPR');
            title(datasetName);
            legend('MOEA/D','ETriCM','NSGAII','CN-KnEA');
            
            
        end
    end
end


