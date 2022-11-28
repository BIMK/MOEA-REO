% function [firstFrontStart,firstFrontEnd,convexhullareaMOEADtrain,convexhullareaMOEADtest,totalTime]=MOEADForFunction(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest)
function [convexhullareaMOEADtrain,convexhullareaMOEADtest,firstfronttrainMOEADtemp,firstfronttestMOEADtemp]=MOEADForFunction(source,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest)
%2017.10.5�޸ģ����ص�һ���棬��������HV
%���ʹ��MOEAD������������
%-----------------------------------------------------------------------------------------

firstFrontStart = [];
firstFrontEnd   = [];

%�����趨
    tic;
    Generations=Maxfit/(popnum/2);
    N=popnum;
    p1=99;
    p2=0;
    Coding='Real';
    M=2;
    A = 1;	%1.�����б�ѩ�򷽷� 2.����PBI����
%-----------------------------------------------------------------------------------------
%�㷨��ʼ
    %��ʼ������
   % Evaluations = Generations*N;
    [N,W] = F_weight(p1,p2,M);
    W(W==0) = 0.000001;
    T = floor(N/10);
  %  Generations = floor(Evaluations/N);

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
    

    m=1;
    t=1;
    countnumber=1;
    population=source;%����ʼ�㼯��������
    evaluation=population*datasettrain*10^(-3);
    evaluation(find(evaluation>=confidencelevel))=1;
    evaluation(find(evaluation<confidencelevel))=0;
    [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
    results=[fpr,tpr];
    origin=results;
    
    Boundary=[maxvalue(1,:);minvalue(1,:)];
    FunctionValue=[fpr,-tpr];
    Z = min(FunctionValue);
    
    %��ʼ����
    for Gene = 1 : Generations
        
        %��ÿ������ִ�в���
        for i = 1 : N
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
        
        if Gene == 1
            [firstFrontStart,~]=areaoftest(population,datasettest,confidencelevel,whethertest);
        end
        
        [firstfronttrain,area]=areaoftest(population,datasettrain,confidencelevel,whethertrain);
        convexhullareaMOEADtrain(Gene,1)=area;

        [firstfronttest,area]=areaoftest(population,datasettest,confidencelevel,whethertest);
        convexhullareaMOEADtest(Gene,1)=area; 
       disp(['it is MOEAD: ' num2str(Gene)]);
    end
    
   % firstFrontEnd = firstfronttest;
   firstfronttrainMOEADtemp=firstfronttrain;
   firstfronttestMOEADtemp=firstfronttest;
    firstFrontEnd = firstfronttestMOEADtemp;
    
firstfronttrainMOEADtemp(size(firstfronttrainMOEADtemp,1)-1:size(firstfronttrainMOEADtemp,1),:)=[];
firstfronttestMOEADtemp(size(firstfronttestMOEADtemp,1)-1:size(firstfronttestMOEADtemp,1),:)=[];
    
    totalTime=toc;
end







