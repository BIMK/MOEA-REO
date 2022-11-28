%%TANGKE
clc
clear;
dbstop if error;
%%
for x=1 : 1%����ѭ��
      fprintf('��%d��\n',x); 
for s = 21:28%���ݼ�ѭ��     
        flag=0;
tic;
fanwei=1;
popnum=100; %��Ⱥ��С(��Ϊż��)
confidencelevel=0;%Ԥֵ
TBB=0;
raito=1;%�������1,2,3.��0��ʾ��������������10%��20%��30%����
generation=400;%����������
Gmin=100;%�����Ӽ���������
K=5;%���۽���
  tubaotrain15=0;
  tubaotest15=0;
[datasetsource,whether]=inputdataset19new(s);
 datasetsource= mapminmax(datasetsource);%���ݹ�һ����-1��1��
Indices =crossvalind('Kfold', size(datasetsource,2), K); %�����ݼ�����ֳ�������֣��ֱ���Ա��1~5
datasetsource=datasetsource';
tic;
 for crossnumber=1:K%%��ѵ���Ͳ���
      convexhullkneetrain=[];
      convexhullkneetest=[];
    datasettrain=datasetsource(find(Indices~=crossnumber),:);
   datasettrain=datasettrain';
    whethertrain=whether(find(Indices~=crossnumber));
    datasettest=datasetsource(find(Indices==crossnumber),:);
   datasettest=datasettest';
    whethertest=whether(find(Indices==crossnumber));
    %�����������
               T=length(whethertrain);
                if raito>=1
               index= randperm(T,ceil(raito/10*T));
               index1=find(whethertrain(index)==1);
               index2=find(whethertrain(index)==0);
               whethertrain(index(index1))=0;
               whethertrain(index(index2))=1;
                end

%%%%%��ѵ������
     poplength=size(datasettrain,1);%��������newpopulationʱ�Ĳ���
     minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %������Сֵ
     maxvalue=repmat(ones(1,poplength),popnum,1);    %�������ֵ
     minvalue1  =  ones(1,poplength)*(-1);%%�߽�
     maxvalue1  =  ones(1,poplength);
     Boundary  =  [maxvalue1;minvalue1]; 
     population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %�����µĳ�ʼ��Ⱥ
     Population=population;
%%����
      [datset,lable,Distb]= kMeans(datasettrain',2,whethertrain');  
    [A,areasum]=NSGA22(population,popnum,Gmin,confidencelevel,lable',datset',Boundary,datasettest,whethertest);
       sxn=size(A,2);
%ѵ��w
for m=1:generation   
    Offspring = P_generator(Population,Boundary,'Real',popnum );
    newpopulation=[Population;Offspring];   
     evaluation=newpopulation*datasettrain*10^(-3); 
     evaluation(find(evaluation>=confidencelevel))=1;
     evaluation(find(evaluation<confidencelevel))=0;    
     [tpr,fpr]=Evaluation(evaluation,whethertrain,newpopulation,datasettrain,confidencelevel);
    results=[fpr,tpr];%   
    [U,R]=splitpopulation(results);%%��Ϊ����ͷ�����    
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
%�����Ŷ�����Ͱ뾶
      [index,~,~]=areaoftest(population,datasettrain,confidencelevel,whethertrain);%�����ǰ�����ϵĸ���      
       Archive=population(index,:);      
       nonindex=setdiff((1:100)',index,'rows');  
        nonarchive=population(nonindex,:);           
       nonarchive_central_point=sum(nonarchive,1)/size(nonarchive,1);%���ⲿ�ĵ����ĵ�
           B=nonarchive_central_point;
           direction=A-B;%�Ŷ�����
           NN=size(nonarchive,1);
           M=size(nonarchive,2);
           Similarity=zeros(NN,1);
           step=zeros(NN,1);
           disturb=zeros(NN,M);
            X1=[B;A];
            Sim=1-pdist(X1,'cosine');      
            DisC=(Sim+Distb)/2;    %�Ŷ�ϵ��           
      for r=1:NN
          CC=nonarchive(r,:);
          X=[CC;A];
          Similarity(r,:)=1-pdist(X,'cosine');
          step(r,:)=(Similarity(r,:)+Distb)*DisC;
          disturb(r,:)=step(r,:)*direction;
      end   
         newnonarchive=nonarchive+disturb;%�Ŷ�������Ⱥ  
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
     [indexc,paretotubaotrain]=chraarea(FunctionValuetrain);%����͹��
    TBtrain=calculatearea(paretotubaotrain);%����͹�������
    convexhullkneetrain=[convexhullkneetrain;TBtrain];
%%�ڲ��Լ��ϼ���aucֵ
        evaluation=Population*datasettest*10^(-3);
        evaluation((evaluation>=confidencelevel))=1;
        evaluation((evaluation<confidencelevel))=0;
        [tpr,fpr]=Evaluation(evaluation,whethertest,Population,datasettest,confidencelevel);
        FunctionValue=[fpr,tpr];
         paretotest=FunctionValue;
         paretotest=sortrows(paretotest);
         paretotest=[0 0;paretotest;1 1]; 
        [indexc,paretotubaotest]=chraarea(paretotest);%����͹��
        TBtest=calculatearea(paretotubaotest);%����͹�������
        convexhullkneetest=[convexhullkneetest;TBtest];
end%��������


 tubaotrain15=tubaotrain15+convexhullkneetrain;
 tubaotest15=tubaotest15+convexhullkneetest;

 end%Kѭ������
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
     %datapath='C:\Users\Mr.Simple\Desktop\CH-MOGP\CH-MOGP - 10%����\ʵ����\';%������ļ���·��
     dirpath=['jg_20220302','\',name];
      %����͹�������
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

 end%���ݼ�ѭ��
      % data2=1;
       %dlmwrite('output.txt',data2,'-append','delimiter',',') 
end%ѭ������
 %
 
 
