%2017.10.5�޸ģ������һ��pareto�棬���ڼ���HV
tic;
clc;
clear all;
close all;

addpath('MOEAD','Public');

rate=0.5;
popnum=100; %��Ⱥ��С(��Ϊż��)
confidencelevel=0;%Ԥֵ
K=5;%���۽���

Maxfit=30000;%����������
MaxDataSet=16;%������Ե����ݼ��ĸ���
allRunTimes=1;%�㷨�ܵ����д���
datasetNumber=1;%����ĳЩ���ݼ������

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


allDataSetTime=[];%ÿ���㷨��ÿ�����ݼ������������ĵ�ʱ����ܼ�¼
allDataSetNumber=[1 2 3 6 7 8 10 11 12 13 14 15 16];
datasetNumber=1;
while datasetNumber<=13
    
    datasetInd = 15;
    
    allMatrixTempMOEAD=[];
    allTime=zeros(1,3);
    
    for totalRunTime=1:allRunTimes
        [datasetsource,whether,datasetName]=inputdataset(datasetInd);%datasetnumber����ǰ���Ե����ݼ�
        Indices =crossvalind('Kfold', size(datasetsource,2), K); %�����ݼ�����ֳ�������֣��ֱ���Ա��1~5
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
                poplength=size(datasettrain,1);%��������newpopulationʱ�Ĳ���
                minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %������Сֵ
                maxvalue=repmat(ones(1,poplength),popnum,1);    %�������ֵ
                population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %�����µĳ�ʼ��Ⱥ
                source=population;
            end
            source=population;

            [firstFrontStartMOEAD,firstFrontEndMOEAD,convexhullMOEADtrain,convexhullMOEADtest,totalTime]=MOEADForFunction(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest);

            
            [firstFrontStartCH3,firstFrontEndCH3,convexhullETriCMtrain,convexhullETriCMtest,firstfronttrainETriCMtemp,firstfronttestETriCMtemp,totalTime]=chthree(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest);

            
            [firstFrontStartNSGA,firstFrontEndNSGA,convexhullnsgatrain,convexhullnsgatest,firstfronttrainnsgatemp,firstfronttestnsgatemp,totalTime]=NSGAIIfold(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest);

            
            [firstFrontStartConvex,firstFrontEndConvex,convexhullkneetrain,convexhullkneetest,firstfronttrainKneetemp,firstfronttestKneetemp,totalTime]=ROCwithKnee(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest,rate);

            
            

            %���ڶԱ��ĸ��㷨�ĵ�һ����
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


