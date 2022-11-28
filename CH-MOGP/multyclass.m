%%TANGKE  �Ż�PAUC
clc
clear all
tic;
global poplength
fanwei=1;
popnum=100; %��Ⱥ��С(��Ϊż��)
confidencelevel=0;%Ԥֵ
K=2;%���۽���
generation=100;%����������
mAUC=0;

[N,datasetsource1,whether1]=inputdata(9);
tic;
 for i=1:N-1
     for j=i+1:N
            Y=unique(whether1);
           X=(whether1==Y(i)|whether1==Y(j));
         datasetsource=datasetsource1(:,X);
         whether=whether1(X);
         whether=(whether==Y(i));
         
        Indices =crossvalind('Kfold', size(datasetsource,2), K); %�����ݼ�����ֳ�������֣��ֱ���Ա��1~5
        datasetsource=datasetsource';
        
         for crossnumber=1:K%%��ѵ���Ͳ���
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
             minvalue1  =  ones(1,poplength)*(-1);%%�߽�
             maxvalue1  =  ones(1,poplength);
             Boundary  =  [maxvalue1;minvalue1]; 
               Population=population;
        %ѵ��w
        for m=1:generation
            m
               Offspring=[];
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
            results=resultstemp;
        end
            pareto=chraarea(resultstemp);
         end

            tempa=zeros(1,2);
            tempa(1,1)=1;
            tempa(1,2)=1;
            tempb=zeros(1,2);
            tempb(1,1)=0;
            tempb(1,2)=0;

            pareto=[tempa;pareto;tempb];
          AUC=calculatearea(pareto)
            mAUC=mAUC+AUC;
     end
 end
    mAUC=mAUC/((N*(N-1))/2)
 toc;
 
