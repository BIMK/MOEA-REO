% sfunction [resultspic,firstfront]=CHMOGP(population,functionname,popnum,fanwei,Maxfit, confidencelevel,dataset,whether,poplength,minvalue,maxvalue)
%functionname是采用Reduce还是采用ReduceR
clc
clear all
tic;
global poplength
fanwei=1;
popnum=200; %种群大小(须为偶数)
confidencelevel=0;%预值
K=5;%五折交叉

Maxfit=1000;%最大迭代次数

K=5;%五折交叉
[datasetsource,whether]=inputdataset(5);
Indices =crossvalind('Kfold', size(datasetsource,2), K); %将数据集随机分成五个部分，分别给以标号1~5
datasetsource=datasetsource';

convexhullareatrain=0;
convexhullareatest=0;
convexhullareafornsgatrain=0;
convexhullareafornsgatest=0;
POPULATIONETirm=cell(5,2);
POPULATIONNSGA=cell(5,2);

PAUCETriCM=zeros(5,1);%%存放每一折交叉时的PAUC值
PAUCNSGA=zeros(5,1);
sumPAUCETriCM=0;
avePAUCETriCM=0;
sumPAUCNSGA=0;
avePAUCNSGA=0;
 for crossnumber=1:K%%分训练和测试
%  crossnumber=1
  
    datasettrain=datasetsource(find(Indices~=crossnumber),:);
    datasettrain=datasettrain';
    whethertrain=whether(find(Indices~=crossnumber));

   datasettest=datasetsource(find(Indices==crossnumber),:);
   datasettest=datasettest';
   whethertest=whether(find(Indices==crossnumber));


%%%%%在训练集上
  poplength=size(datasettrain,1);%用作产生newpopulation时的参数
%    poplength=1;                                   %个体长度
 minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %个体最小值
 maxvalue=repmat(ones(1,poplength),popnum,1);    %个体最大值
 population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群
 source=population;%将初始点集保存下来
 evaluation=population*datasettrain *10^(-3);
 evaluation(find(evaluation>=confidencelevel))=1;
 evaluation(find(evaluation<confidencelevel))=0;

 [tpr,fpr]=Evaluation(evaluation,whethertrain,population,datasettrain,confidencelevel);
 results=[fpr,tpr];

 origin=results;





%%
% population=source;

%训练w
for m=1:Maxfit
    newpopulation=zeros(popnum,poplength);  %子代种群
    for i=1:popnum/2                        %交叉产生子代
        k=randperm(popnum);                 %从种群中随机选出两个父母,不采用二进制联赛方法,randperm随机打乱一个数字序列
        beta=(-1).^round(rand(1,poplength)).*abs(randn(1,poplength))*1.481; %采用正态分布交叉产生两个子代
        newpopulation(i*2-1,:)=(population(k(1),:)+population(k(2),:))/2+beta.*(population(k(1),:)-population(k(2),:))./2;    %产生第一个子代
        newpopulation(i*2,:)=(population(k(1),:)+population(k(2),:))/2-beta.*(population(k(1),:)-population(k(2),:))./2;      %产生第二个子代
    end
    
    %-------变异
    k=rand(size(newpopulation));    %随机选定要变异的基因位
    miu=rand(size(newpopulation));  %采用多项式变异
    temp=k<1/poplength & miu<0.5;   %要变异的基因位
    newpopulation(temp)=newpopulation(temp)+(maxvalue(temp)-minvalue(temp)).*((2.*miu(temp)+(1-2.*miu(temp)).*(1-(newpopulation(temp)-minvalue(temp))./(maxvalue(temp)-minvalue(temp))).^21).^(1/21)-1);        %变异情况一
    newpopulation(temp)=newpopulation(temp)+(maxvalue(temp)-minvalue(temp)).*(1-(2.*(1-miu(temp))+2.*(miu(temp)-0.5).*(1-(maxvalue(temp)-newpopulation(temp))./(maxvalue(temp)-minvalue(temp))).^21).^(1/21));  %变异情况二
    
    %-------越界处理/种群合并
    newpopulation(newpopulation>maxvalue)=maxvalue(newpopulation>maxvalue); %子代越上界处理
    newpopulation(newpopulation<minvalue)=minvalue(newpopulation<minvalue); %子代越下界处理
    newpopulation=[population;newpopulation];
    evaluation=newpopulation*datasettrain*10^(-3);
    
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
    %         newpopulation=[newpopulation;a];%防止因为所有的点共线而无法生成凸包
    
    [tpr,fpr]=Evaluation(evaluation,whethertrain,newpopulation,datasettrain,confidencelevel);
    results=[fpr,tpr];%
    
    [U,R]=splitpopulation(results);
    
    if size(U,1)<=popnum
        resultstemp=[];
        number=randperm(size(R,1));
        resultstemp=[U;R(number(1:popnum-size(U,1)),:)];
         
    else
        resultstemp=[];
        resultstemp=Reduce(U,size(results,1)-popnum,fanwei);
    end
    number=findsequence(resultstemp,results);
    population=newpopulation(number,:);
%     m=m+popnum/2;
 

%     tempa=zeros(1,2);
%      tempa(1,1)=1;
%      tempa(1,2)=1;
%      tempb=zeros(1,2);
%      tempb(1,1)=0;
%      tempb(1,2)=0;
    %resultstemp
%      resultstemp=[resultstemp;tempa;tempb];%将这两点加入到种群中，使得计算出来的面积更精确
    pareto=chraarea(resultstemp);
    ETriCMtrainxuhao=findsequence(pareto,resultstemp)%%找到非支配解对应的分类器，也就是训练集学的的分类器
%      sum=calculatearea(pareto);
%      convexhullareaETriCM(countnumber,1)=sum;
%      
%     countnumber=countnumber+1;
   
end


[paretoNSGAII,convexhullNSGAII,tempfunctionvalue,populationend]=NSGAIIfold(source,popnum,Maxfit,confidencelevel,whethertrain,poplength,minvalue,maxvalue,datasettrain);
NSGA2trainxuhao=findsequence(paretoNSGAII,tempfunctionvalue)%%找到非支配解对应的分类器，也就是训练集学的的分类器
% [sum2,sum3]=areaoftestNew(resultstemp);
% [sum4,sum5]=areaoftestNew(tempfunctionvalue)%nsga



%%%在训练集上，计算PAUC值，选出一个最好的
populationtrainErim=population(ETriCMtrainxuhao,:);%%选出洪文静在训练集上的非支配分类器
populationtrainNSGA=populationend(NSGA2trainxuhao,:);%%选出NSGA在训练集上的非支配分类器
d=size(whethertrain,2);
for i=1:d
    if whethertrain(i)==0
        whethertrain(i)=-1;
    end
end
dd=size(whethertest,2);
for i=1:dd
    if whethertest(i)==0
        whethertest(i)=-1;
    end
end
PAUCtrainETriCM=zeros(size(ETriCMtrainxuhao,1),1);%%用来存放训练集非支配解对应的分类器的PAUC(洪文静)
PAUCtrainNSGA=zeros(size(NSGA2trainxuhao,1),1);%%用来存放训练集非支配解对应的分类器的PAUC（NSGA）
for i=1:size(ETriCMtrainxuhao,1)
    PAUCtrainETriCM(i)=my_paucpredict(datasettrain', whethertrain',0,0.05,populationtrainErim(i,:)');
end
for i=1:size(NSGA2trainxuhao,1)
    PAUCtrainNSGA(i)=my_paucpredict(datasettrain', whethertrain',0,0.05,populationtrainNSGA(i,:)');
end
[paucmaxETriCM, SVMtrainmaxETriCMxuhao]=max(PAUCtrainETriCM) ;%%选出pauc值最高的分类器序号
[paucmaxNSGA,SVMtrainmaxNSGAxuhao]=max(PAUCtrainNSGA);%%选出pauc值最高的分类器序号
SVMtrainmaxETriCM=populationtrainErim(SVMtrainmaxETriCMxuhao,:);
SVMtrainmaxNSGA=populationtrainNSGA(SVMtrainmaxNSGAxuhao,:);



%%%%%%测试集上
% dd=size(whethertest,2);
% for i=1:dd
%     if whethertest(i)==0
%         whethertest(i)=-1;
%     end
% end
PAUCETriCM(crossnumber,1)=my_paucpredict(datasettest', whethertest',0,0.05,SVMtrainmaxETriCM(1,:)');
PAUCNSGA(crossnumber,1)=my_paucpredict(datasettest', whethertest',0,0.05,SVMtrainmaxNSGA(1,:)');
 end
 toc;
 for i=1:5
     sumPAUCETriCM=sumPAUCETriCM+PAUCETriCM(i,1);
     sumPAUCNSGA=sumPAUCNSGA+PAUCNSGA(i,1);
 end
avePAUCETriCM=sumPAUCETriCM/5;
avePAUCNSGA= sumPAUCNSGA/5;
 
 
 
% POPULATIONETirm{crossnumber,1}=SVMtrainmaxETriCM;%%c存放五折交叉过后的五个分类器
% POPULATIONETirm{crossnumber,2}=paucmaxETriCM;
% POPULATIONNSGA{crossnumber,1}=SVMtrainmaxNSGA;
% POPULATIONNSGA{crossnumber,2}=paucmaxNSGA;     
% % end
% temp1=zeros(K,1);
% temp2=zeros(K,1);
% for i=1:K
%     temp1(i)=POPULATIONETirm{i,2};
%     temp2(i)=POPULATIONNSGA{i,2};
% end
% [PAUCendETriCM,temptemp]=max(temp1);
% [PAUCendNSGA,temptemp2]=max(temp2);
% SVMendETriCM=POPULATIONETirm{temptemp,1};
% SVMendNSGA=POPULATIONNSGA{temptemp2,1};

% save('F:\研究生生涯\MOEAD第一次实验/data/SVMtrainmaxETriCM.mat','SVMtrainmaxETriCM');%%%%%%%%付    本实验这里表明是为了计算PAUC
% save('F:\研究生生涯\MOEAD第一次实验/data/SVMtrainmaxNSGA.mat','SVMtrainmaxNSGA');
% 

% pareto=sortrows(pareto,1);%排序是为了画图时不会头尾连在一起
% paretoNSGAII=sortrows(paretoNSGAII,1);
% save('F:\研究生生涯\MOEAD第一次实验/data/pareto.mat','pareto');
% save('F:\研究生生涯\MOEAD第一次实验/data/paretoNSGAII.mat','paretoNSGAII');
%---------------------------
%说明：convexhullareaETriCM是ETriCM最后得到的所有面积，pareto是算法ETriCM得到的第一层前沿面
%      convexhullNSGAII 是NSGAII得到的所有面积，paretoNSGAII是算法NSGAII得到的第一层前沿面
%---------------------------
% load 'D:\研究生生涯\MOEAD第一次实验/data/resultsMOEAD.mat';
% load 'D:\研究生生涯\MOEAD第一次实验/data/FunctionValue.mat';
% figure(1)
% xlabel('fpr'); ylabel('tpr');
% plot(pareto(:,1),pareto(:,2),'-b');
% hold on;
% plot(paretoNSGAII(:,1),paretoNSGAII(:,2),'-.K');
% hold on;
% % plot(resultsMOEAD(:,1),resultsMOEAD(:,2),'--*r');
% % hold on;
% %  plot(FunctionValue(:,1),FunctionValue(:,2),'*r')
% legend('ETriCM','NSGAII');



