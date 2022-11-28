% sfunction [resultspic,firstfront]=CHMOGP(population,functionname,popnum,fanwei,Maxfit, confidencelevel,dataset,whether,poplength,minvalue,maxvalue)
%functionname�ǲ���Reduce���ǲ���ReduceR
clc
clear all
tic;
global poplength
fanwei=1;
popnum=200; %��Ⱥ��С(��Ϊż��)
confidencelevel=0;%Ԥֵ
K=5;%���۽���

Maxfit=1000;%����������

K=5;%���۽���
[datasetsource,whether]=inputdataset(5);
Indices =crossvalind('Kfold', size(datasetsource,2), K); %�����ݼ�����ֳ�������֣��ֱ���Ա��1~5
datasetsource=datasetsource';

convexhullareatrain=0;
convexhullareatest=0;
convexhullareafornsgatrain=0;
convexhullareafornsgatest=0;
POPULATIONETirm=cell(5,2);
POPULATIONNSGA=cell(5,2);

PAUCETriCM=zeros(5,1);%%���ÿһ�۽���ʱ��PAUCֵ
PAUCNSGA=zeros(5,1);
sumPAUCETriCM=0;
avePAUCETriCM=0;
sumPAUCNSGA=0;
avePAUCNSGA=0;
 for crossnumber=1:K%%��ѵ���Ͳ���
%  crossnumber=1
  
    datasettrain=datasetsource(find(Indices~=crossnumber),:);
    datasettrain=datasettrain';
    whethertrain=whether(find(Indices~=crossnumber));

   datasettest=datasetsource(find(Indices==crossnumber),:);
   datasettest=datasettest';
   whethertest=whether(find(Indices==crossnumber));


%%%%%��ѵ������
  poplength=size(datasettrain,1);%��������newpopulationʱ�Ĳ���
%    poplength=1;                                   %���峤��
 minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %������Сֵ
 maxvalue=repmat(ones(1,poplength),popnum,1);    %�������ֵ
 population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %�����µĳ�ʼ��Ⱥ
 source=population;%����ʼ�㼯��������
 evaluation=population*datasettrain *10^(-3);
 evaluation(find(evaluation>=confidencelevel))=1;
 evaluation(find(evaluation<confidencelevel))=0;

 [tpr,fpr]=Evaluation(evaluation,whethertrain,population,datasettrain,confidencelevel);
 results=[fpr,tpr];

 origin=results;





%%
% population=source;

%ѵ��w
for m=1:Maxfit
    newpopulation=zeros(popnum,poplength);  %�Ӵ���Ⱥ
    for i=1:popnum/2                        %��������Ӵ�
        k=randperm(popnum);                 %����Ⱥ�����ѡ��������ĸ,�����ö�������������,randperm�������һ����������
        beta=(-1).^round(rand(1,poplength)).*abs(randn(1,poplength))*1.481; %������̬�ֲ�������������Ӵ�
        newpopulation(i*2-1,:)=(population(k(1),:)+population(k(2),:))/2+beta.*(population(k(1),:)-population(k(2),:))./2;    %������һ���Ӵ�
        newpopulation(i*2,:)=(population(k(1),:)+population(k(2),:))/2-beta.*(population(k(1),:)-population(k(2),:))./2;      %�����ڶ����Ӵ�
    end
    
    %-------����
    k=rand(size(newpopulation));    %���ѡ��Ҫ����Ļ���λ
    miu=rand(size(newpopulation));  %���ö���ʽ����
    temp=k<1/poplength & miu<0.5;   %Ҫ����Ļ���λ
    newpopulation(temp)=newpopulation(temp)+(maxvalue(temp)-minvalue(temp)).*((2.*miu(temp)+(1-2.*miu(temp)).*(1-(newpopulation(temp)-minvalue(temp))./(maxvalue(temp)-minvalue(temp))).^21).^(1/21)-1);        %�������һ
    newpopulation(temp)=newpopulation(temp)+(maxvalue(temp)-minvalue(temp)).*(1-(2.*(1-miu(temp))+2.*(miu(temp)-0.5).*(1-(maxvalue(temp)-newpopulation(temp))./(maxvalue(temp)-minvalue(temp))).^21).^(1/21));  %���������
    
    %-------Խ�紦��/��Ⱥ�ϲ�
    newpopulation(newpopulation>maxvalue)=maxvalue(newpopulation>maxvalue); %�Ӵ�Խ�Ͻ紦��
    newpopulation(newpopulation<minvalue)=minvalue(newpopulation<minvalue); %�Ӵ�Խ�½紦��
    newpopulation=[population;newpopulation];
    evaluation=newpopulation*datasettrain*10^(-3);
    
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
    %         newpopulation=[newpopulation;a];%��ֹ��Ϊ���еĵ㹲�߶��޷�����͹��
    
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
%      resultstemp=[resultstemp;tempa;tempb];%����������뵽��Ⱥ�У�ʹ�ü���������������ȷ
    pareto=chraarea(resultstemp);
    ETriCMtrainxuhao=findsequence(pareto,resultstemp)%%�ҵ���֧����Ӧ�ķ�������Ҳ����ѵ����ѧ�ĵķ�����
%      sum=calculatearea(pareto);
%      convexhullareaETriCM(countnumber,1)=sum;
%      
%     countnumber=countnumber+1;
   
end


[paretoNSGAII,convexhullNSGAII,tempfunctionvalue,populationend]=NSGAIIfold(source,popnum,Maxfit,confidencelevel,whethertrain,poplength,minvalue,maxvalue,datasettrain);
NSGA2trainxuhao=findsequence(paretoNSGAII,tempfunctionvalue)%%�ҵ���֧����Ӧ�ķ�������Ҳ����ѵ����ѧ�ĵķ�����
% [sum2,sum3]=areaoftestNew(resultstemp);
% [sum4,sum5]=areaoftestNew(tempfunctionvalue)%nsga



%%%��ѵ�����ϣ�����PAUCֵ��ѡ��һ����õ�
populationtrainErim=population(ETriCMtrainxuhao,:);%%ѡ�����ľ���ѵ�����ϵķ�֧�������
populationtrainNSGA=populationend(NSGA2trainxuhao,:);%%ѡ��NSGA��ѵ�����ϵķ�֧�������
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
PAUCtrainETriCM=zeros(size(ETriCMtrainxuhao,1),1);%%�������ѵ������֧����Ӧ�ķ�������PAUC(���ľ�)
PAUCtrainNSGA=zeros(size(NSGA2trainxuhao,1),1);%%�������ѵ������֧����Ӧ�ķ�������PAUC��NSGA��
for i=1:size(ETriCMtrainxuhao,1)
    PAUCtrainETriCM(i)=my_paucpredict(datasettrain', whethertrain',0,0.05,populationtrainErim(i,:)');
end
for i=1:size(NSGA2trainxuhao,1)
    PAUCtrainNSGA(i)=my_paucpredict(datasettrain', whethertrain',0,0.05,populationtrainNSGA(i,:)');
end
[paucmaxETriCM, SVMtrainmaxETriCMxuhao]=max(PAUCtrainETriCM) ;%%ѡ��paucֵ��ߵķ��������
[paucmaxNSGA,SVMtrainmaxNSGAxuhao]=max(PAUCtrainNSGA);%%ѡ��paucֵ��ߵķ��������
SVMtrainmaxETriCM=populationtrainErim(SVMtrainmaxETriCMxuhao,:);
SVMtrainmaxNSGA=populationtrainNSGA(SVMtrainmaxNSGAxuhao,:);



%%%%%%���Լ���
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
 
 
 
% POPULATIONETirm{crossnumber,1}=SVMtrainmaxETriCM;%%c������۽����������������
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

% save('F:\�о�������\MOEAD��һ��ʵ��/data/SVMtrainmaxETriCM.mat','SVMtrainmaxETriCM');%%%%%%%%��    ��ʵ�����������Ϊ�˼���PAUC
% save('F:\�о�������\MOEAD��һ��ʵ��/data/SVMtrainmaxNSGA.mat','SVMtrainmaxNSGA');
% 

% pareto=sortrows(pareto,1);%������Ϊ�˻�ͼʱ����ͷβ����һ��
% paretoNSGAII=sortrows(paretoNSGAII,1);
% save('F:\�о�������\MOEAD��һ��ʵ��/data/pareto.mat','pareto');
% save('F:\�о�������\MOEAD��һ��ʵ��/data/paretoNSGAII.mat','paretoNSGAII');
%---------------------------
%˵����convexhullareaETriCM��ETriCM���õ������������pareto���㷨ETriCM�õ��ĵ�һ��ǰ����
%      convexhullNSGAII ��NSGAII�õ������������paretoNSGAII���㷨NSGAII�õ��ĵ�һ��ǰ����
%---------------------------
% load 'D:\�о�������\MOEAD��һ��ʵ��/data/resultsMOEAD.mat';
% load 'D:\�о�������\MOEAD��һ��ʵ��/data/FunctionValue.mat';
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



