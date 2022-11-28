%MOEA/D
clc;format compact;tic;
clear all;
%-----------------------------------------------------------------------------------------
%�����趨
    
    Generations=600;
    N=100;
    p1=99;
    p2=0;
    Coding='Real';
    M=2;
    
    K=5;%���۽���
    popnum=N;
    confidencelevel=0;
%-------------------------------------------------------------------------------------------
%�����㷨��������Ҫ������
[datasetsource,whether]=inputdataset(1);
Indices =crossvalind('Kfold', size(datasetsource,2), K); %�����ݼ�����ֳ�������֣��ֱ���Ա��1~5
datasetsource=datasetsource';
    
convexhullareatrain=0;
convexhullareatest=0;
convexhullareafornsgatrain=0;
convexhullareafornsgatest=0;

for crossnumber=1:1

datasettrain=datasetsource(find(Indices~=crossnumber),:);
datasettrain=datasettrain';
whethertrain=whether(find(Indices~=crossnumber));

datasettest=datasetsource(find(Indices==crossnumber),:);
datasettest=datasettest';
whethertest=whether(find(Indices==crossnumber));

countnumber=1;


    A = 1;	%1.�����б�ѩ�򷽷� 2.����PBI����
%-----------------------------------------------------------------------------------------
%�㷨��ʼ
    %��ʼ������
    Evaluations = Generations*N;
    [N,W] = F_weight(p1,p2,M);
    W(W==0) = 0.000001;
    T = floor(N/10);
    Generations = floor(Evaluations/N);

    %�ھ��ж�
    B = zeros(N);
    for i = 1 : N
        for j = i : N
            B(i,j) = norm(W(i,:)-W(j,:));
            B(j,i) = B(i,j);
        end
    end
    [~,B] = sort(B,2);
    B = B(:,1:T);
    
    %��ʼ����Ⱥ
    poplength=size(datasettrain,1);%��������newpopulationʱ�Ĳ���
    minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %������Сֵ
    maxvalue=repmat(ones(1,poplength),popnum,1);    %�������ֵ
    population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %�����µĳ�ʼ��Ⱥ
    source=population;%����ʼ�㼯��������
    evaluation=population*datasettrain*10^(-3);
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
    
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
    results=[fpr,tpr];
    origin=results;
    
%     [population,Boundary,Coding] = P_objective('init',Problem,M,N);
%     FunctionValue = P_objective('value',Problem,M,population);
    
    Boundary=[maxvalue(1,:);minvalue(1,:)];
    FunctionValue=[fpr,-tpr];
    Z = min(FunctionValue);

    AllAreaTtrain=zeros(Generations,1);
    AllAreaTtest=zeros(Generations,1);
    
    %��ʼ����
    for Gene = 1 : Generations
        %��ÿ������ִ�в���
        for i = 1 : N
            %��һ��
%             Fmax = max(FunctionValue);
%             Fmin = Z;
%             FunctionValue = (FunctionValue-repmat(Fmin,N,1))./repmat(Fmax-Fmin,N,1);
            
            %ѡ����ĸ
            k = randperm(T);
            k = B(i,k(1:2));

            %�����Ӵ�
            Offspring = P_generator([population(k(1),:);population(k(2),:)],Boundary,Coding,1);
%             OffFunValue = P_objective('value',Problem,M,Offspring);

            evaluation=Offspring*datasettrain*10^(-3);
            evaluation(find(evaluation>=confidencelevel))=1;
            evaluation(find(evaluation<confidencelevel))=0;
    
            [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
            OffFunValue=[fpr,-tpr];
            Z = min(FunctionValue);
%             OffFunValue = (OffFunValue-Fmin)./(Fmax-Fmin);
            
            %�������������
            Z = min(Z,OffFunValue);

            %�����ھӸ���
            for j = 1 : T
                if A == 1
                    g_old = max(abs(FunctionValue(B(i,j),:)-Z).*W(B(i,j),:));
                    g_new = max(abs(OffFunValue-Z).*W(B(i,j),:));
                elseif A == 2
                    d1 = abs(sum((FunctionValue(B(i,j),:)-Z).*W(B(i,j),:)))/norm(W(B(i,j),:));
                    g_old = d1+5*norm(FunctionValue(B(i,j),:)-(Z+d1*W(B(i,j),:)/norm(W(B(i,j),:))));               
                    d1 = abs(sum((OffFunValue-Z).*W(B(i,j),:)))/norm(W(B(i,j),:));
                    g_new = d1+5*norm(OffFunValue-(Z+d1*W(B(i,j),:)/norm(W(B(i,j),:))));
                end
                if g_new < g_old
                    %���µ�ǰ�����ĸ���
                    population(B(i,j),:) = Offspring;
                    FunctionValue(B(i,j),:) = OffFunValue;
                end
            end
            %����һ��
%             FunctionValue = FunctionValue.*repmat(Fmax-Fmin,N,1)+repmat(Fmin,N,1);
        end
        
        [~,area]=areaoftest(population,datasettrain,confidencelevel,whethertrain);
        AllAreaTtrain(Gene,1)=area;

        [~,area]=areaoftest(population,datasettest,confidencelevel,whethertest);
        AllAreaTtest(Gene,1)=area;   
        
        
        
        fprintf('��ǰ������%f\n',Gene);
    end
end


evaluation=population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
results=[fpr,tpr];
figure(1)
results=chraarea(results);
plot( results(:,1), results(:,2),'.-r');
set(gcf,'Name','ѵ�������');
title('����㼯','fontsize',16);
xlabel('fpr');
ylabel('tpr');
axis([-0.1 1.1 -0.1 1.1]);


evaluation=population*datasettest*10^(-3);
evaluation(find(evaluation>=confidencelevel))=1;
evaluation(find(evaluation<confidencelevel))=0;
[tpr,fpr]=calculatetprandfpr(evaluation,whethertest);
results=[fpr,tpr];
results=chraarea(results);
figure(2)
plot( results(:,1), results(:,2),'.-r');
set(gcf,'Name','���Լ����');
title('����㼯','fontsize',16);
xlabel('fpr');
ylabel('tpr');
axis([-0.1 1.1 -0.1 1.1]);

% 
% figure(3)
% plot( AllAreaTtrain,'.r');
% set(gcf,'Name','ѵ�������');
% title('AUC','fontsize',16);
% xlabel('generations');
% ylabel('area');
% % axis([-0.1 1.1 -0.1 1.1]);
% 
% 
% figure(4)
% plot( AllAreaTtest,'.r');
% set(gcf,'Name','���Լ����');
% title('AUC','fontsize',16);
% xlabel('generations');
% ylabel('area');
% % axis([-0.1 1.1 -0.1 1.1]);





