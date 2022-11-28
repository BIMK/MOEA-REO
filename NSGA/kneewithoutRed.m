function [convexhullkneetrain,convexhullkneetest,firstfronttrain,firstfronttest]=kneewithoutRed(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest,rate)

% clc
% clear all
% popnum=50;
% 
% populationnumber=100;
% [dataset,whether]=inputdataset(1);%datasetnumber����ǰ���Ե����ݼ�
% poplength=size(dataset,1);%��������newpopulationʱ�Ĳ���
% minvalue=repmat(ones(1,poplength),populationnumber,1)*(-1);   %������Сֵ
% maxvalue=repmat(ones(1,poplength),populationnumber,1);    %�������ֵ
% population=rand(populationnumber,poplength).*(maxvalue-minvalue)+minvalue;    %�����µĳ�ʼ��Ⱥ
% source=population;
% confidencelevel=0;%Ԥֵ
% Maxfit=100;

newnumber=[];%����Ⱥ�е�ı��
convexhullkneetrain=[];
convexhullkneetest=[];
r=zeros(1,2*popnum)-1;          %����Ӧ����1
t=zeros(1,2*popnum)-1;          %����Ӧ����2
% rate=0.6;

population=source;%����ʼ�㼯��������
evaluation=population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
functionvalue=[fpr,tpr];

frontvalue=P_sort(functionvalue);                                   %��Ⱥǰ������
kneepoint=zeros(1,popnum);                                          %��ʼkneepoint����

rrr = zeros(1,Maxfit);
ttt = rrr;
RRR = rrr;
evalnumber=0;
m=1;
sumall=[];
while evalnumber<Maxfit
    newpopulation=F_generator(population,maxvalue(1,:),minvalue(1,:),functionvalue,frontvalue,kneepoint);
    population=[population;newpopulation];
    %����÷�������ѵ�������������
    evaluation=population*datasettrain*10^(-3);
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
    functionvalue=[fpr,-tpr];%
    functionvaluetemp=[fpr,tpr];%
    a=[0 0];
    b=[1 1];
    functionvaluetemp=[functionvaluetemp;a;b];
    functionvaluetemp=chraarea(functionvaluetemp);%�����ȡ�㼯��pareto��
    sum=calculatearea(functionvaluetemp);
    convexhullkneetrain=[convexhullkneetrain;sum];
    %����÷������ڲ��Լ����������
    evaluation=population*datasettest*10^(-3);
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertest);
    functionvaluetemp=[fpr,tpr];%    
    a=[0 0];
    b=[1 1];
    functionvaluetemp=[functionvaluetemp;a;b];
    functionvaluetemp=chraarea(functionvaluetemp);%�����ȡ�㼯��pareto��
    sum=calculatearea(functionvaluetemp);
    convexhullkneetest=[convexhullkneetest;sum];
    
    %���������ͷ�����㼯��
    R=[];%���༯�ϣ����洢����Ǹ�������������
    U=[1:size(functionvalue,1)]';%������������
    redundancy=[];%�������������
    unredundancy=[];%��������������
    for i=1:size(functionvalue,1)
        for j=i+1:size(functionvalue,1)
            if(functionvalue(i,:)==functionvalue(j,:))
                redundancy=[redundancy;j];
            end
            
        end
    end
    redundancy=unique(redundancy,'rows');
    
    RE=redundancy;
    U(redundancy,:)=[];
    
    if numel(U)<=popnum
        newnumber=[];
        [frontvalue,maxfront]=P_sort(functionvalue);
        [kneepoint,distance,r,t,R]=F_kneepoint(functionvalue,frontvalue,maxfront,r,t,rate);	%�ҳ�ǰmaxfront�����kneepoint
        newnumber=[newnumber;U];
        tempnumber=randperm(size(RE,1));
        newnumber=[newnumber;RE(tempnumber(1:popnum-size(U,1)))];
        population=population(newnumber,:);
        frontvalue=frontvalue(newnumber);
        functionvalue=functionvalue(newnumber,:);
        kneepoint=kneepoint(newnumber);
    else
        %�������ĸ�������popnum�����Ҫ�ӷ�����㼯��ѡ���ȽϺõ�popnum����
        poptemp=functionvalue(U,:);
        [frontvalue,maxfront]=P_sort(poptemp);             %����ϲ���Ⱥ��ǰ������
        [kneepoint,distance,r,t,R]=F_kneepoint( poptemp,frontvalue,maxfront,r,t,rate);	%�ҳ�ǰmaxfront�����kneepoint
        newpopulation= F_choosewithoutRed(poptemp,frontvalue,maxfront,kneepoint,distance,popnum);%ʹ�øĽ���F_choosewithoutRed����ѡ��
        newpopulationforfrontvalue=newpopulation;
        newnumber=U(newpopulation);
        population=population(newpopulation,:);                         %��һ����Ⱥ
        functionvalue=functionvalue(newpopulation,:);                   %��һ����Ⱥ�ĺ���ֵ
        frontvalue=frontvalue(newpopulationforfrontvalue);                           %��һ����Ⱥ��ǰ������
        kneepoint=kneepoint(newpopulationforfrontvalue);
    end
    rrr(m) = r(1);
    ttt(m) = t(1);
    if ~isempty(R)
        RRR(m) = R(1);
    end
    %��һ����Ⱥ
    
    evalnumber=evalnumber+popnum/2;
    m=m+1;
    
end
   
evaluation=population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
functionvaluetemp=[fpr,tpr];%
a=[0 0];
b=[1 1];
functionvaluetemp=[functionvaluetemp;a;b];
functionvaluetemp=chraarea(functionvaluetemp);%�����ȡ�㼯��pareto��
sum=calculatearea(functionvaluetemp);
convexhullkneetrain=[convexhullkneetrain;sum];
firstfronttrain=functionvaluetemp;
% figure (5)
% plot(functionvaluetemp(:,1),functionvaluetemp(:,2),'r.');
% hold on
% title('��һ�����ϵĵ�','fontsize',16);
% legend('CH-3','NSGAII','ROCknee');

evaluation=population*datasettest*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertest);
functionvaluetemp=[fpr,tpr];
a=[0 0];
b=[1 1];
functionvaluetemp=[functionvaluetemp;a;b];
functionvaluetemp=chraarea(functionvaluetemp);%�����ȡ�㼯��pareto��
firstfronttest=functionvaluetemp;
sum=calculatearea(functionvaluetemp);
convexhullkneetest=[convexhullkneetest;sum];

firstfronttrain(size(firstfronttrain,1)-1:size(firstfronttrain,1),:)=[];
firstfronttest(size(firstfronttest,1)-1:size(firstfronttest,1),:)=[];

end
    
