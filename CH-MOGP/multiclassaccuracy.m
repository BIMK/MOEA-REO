%%TANGKE  优化PAUC
clc
clear all
tic;
global poplength
fanwei=1;
popnum=100; %种群大小(须为偶数)
confidencelevel=0;%预值
K=5;%五折交叉
generation=100;%最大迭代次数
evaluate1=[];
num=[];
C=0.9;
[N,datasetsource1,whether1]=inputdata(5);
Y=unique(whether1);
for i=1:N
    whether1(whether1==Y(i))=-i*100;
end
Y=unique(whether1);
for i=1:N
    whether1(whether1==Y(i))=i;
end
Y=unique(whether1);
tic;
Y=unique(whether1);
cost=zeros(N);

for  q=1:N
    num=[num numel(find(whether1==Y(q)))];
end  
for i=1:N-1
    for j=i+1:N
        cost(i,j)=num(j)/(num(i)+num(j));
        cost(j,i)=1-cost(i,j);
    end
end
    cost=cost./sum(num);
    
     for i=1:N-1
         for j=i+1:N 
              X=(whether1==Y(i)|whether1==Y(j));
             datasetsource=datasetsource1(:,X);
             whether=whether1(X);
            whether(whether==Y(i))=i;
            whether(whether==Y(j))=j;
            
            
            Indices =crossvalind('Kfold', size(datasetsource,2), K); %将数据集随机分成五个部分，分别给以标号1~5
            datasetsource=datasetsource';

             for crossnumber=1:K%%分训练和测试
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
                 minvalue1  =  ones(1,poplength)*(-1);%%边界
                 maxvalue1  =  ones(1,poplength);
                 Boundary  =  [maxvalue1;minvalue1]; 
                   Population=population;
            %训练w
                for m=1:generation
                    m
                       Offspring=[];
                    Offspring = P_generator(Population,Boundary,'Real',popnum );
                    newpopulation=[Population;Offspring];
                    evaluation=newpopulation*datasettrain*10^(-3);
                    evaluation(find(evaluation>=confidencelevel))=i;
                    evaluation(find(evaluation<confidencelevel))=j;
                   [best,Population]=select(newpopulation,evaluation,whethertrain,cost,C,popnum);
                end    
                evaluate1=evaluate(evaluate1,best,datasetsource1,confidencelevel,Y(i),Y(j));
            end
         end
     end
        q=mode(evaluate1,1);
        p=(q==whether1);
        COST=[];
        for i=1:sum(num)
            COST=[COST cost(whether1(i),q(i))];
        end
        COST=sum(COST) 
        acc=sum(p)/size(whether1,2)
 toc;
 
