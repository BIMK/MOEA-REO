 function [convexhullareaETriCMtrain,convexhullareaETriCMtest,firstfronttrain,firstfronttest]=chthree(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest)
%████chthree使用ch-3算法来产生测试集和训练集的凸包下面积
tic;
population=source;%将初始点集保存下来
evaluation=population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
 % [tpr,fpr]  =  Evaluation(evaluation,whethertrain);%%计算目标函数
results=[fpr,tpr];
origin=results;

firstFrontStart = [];
firstFrontEnd   = [];

m=1;
t=1;
countnumber=1;
%训练
while m <= Maxfit
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
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
    %  [tpr,fpr]  =  Evaluation(evaluation,whethertrain);%%计算目标函数
    results=[fpr,tpr];
    [U,R]=splitpopulation(results);
    if size(U,1)<=popnum
        resultstemp=[];
        number=randperm(size(R,1));
        resultstemp=[U;R(number(1:popnum-size(U,1)),:)];     
    else
        resultstemp=[];
        resultstemp=Reduce(U,size(results,1)-popnum);
    end
    %找出resultstemp中的值在results中的序号,这里调用之前写的删除pareto面中的点的函数
    number=findsequence(resultstemp,results);
    %number=unique(number,'rows');
    population=newpopulation(number,:);
    
    if m == 1
        [firstFrontStart,~]=areaoftest(population,datasettest,confidencelevel,whethertest);
    end
    
    m=m+popnum/2;
    t=t+1;
    tempa=zeros(1,2);
    tempa(1,1)=1;
    tempa(1,2)=1;
    tempb=zeros(1,2);
    tempb(1,1)=0;
    tempb(1,2)=0;
    pareto=chraarea(resultstemp);
    pareto=[pareto;tempa;tempb];%将这两点加入到种群中，使得计算出来的面积更精确
    sum=calculatearea(pareto);
    convexhullareaETriCMtrain(countnumber,1)=sum;
    
    [temp,sum]=areaoftest(population,datasettest,confidencelevel,whethertest);
    convexhullareaETriCMtest(countnumber,1)=sum;
    
   countnumber=countnumber+1;
   disp(['it is chthree: ' num2str(m)]);
end

firstFrontEnd = temp;
firstfronttrain=pareto;
firstfronttest=temp;

firstfronttrain(size(firstfronttrain,1)-1:size(firstfronttrain,1),:)=[];
firstfronttest(size(firstfronttest,1)-1:size(firstfronttest,1),:)=[];

end


