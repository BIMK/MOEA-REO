clc;
clear;
%%
dbstop if error;

for myR = 1 : 4
    fprintf('raito=%d\n',myR);
for s = 16 : 16  %���ݼ�
    
    [datasetsource,whether,name] = LOADdata(s);%datasetnumber����ǰ���Ե����ݼ�
    datasetsource= mapminmax(datasetsource);%���ݹ�һ����-1��1��            
    datasetsource=datasetsource';
    dirpath=['jg_20220309\u=',num2str(myR*0.1),'\',name];
    fprintf('���ݼ�-%s\n',name);
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    raito = myR;%�������1,2,3.��0��ʾ��������������10%��20%��30%����
    Parameter = 0.5;
    repetition = 5;
    confidencelevel=0;%Ԥֵ
    K=5;%���۽���
    Maxfit = 300;%����������
    JLDD = 100;%�����������
    %�������ݼ�(����֮����������Ͷ�������*����)
    popnum=100;
    rate=0.2;
    %fprintf('ETriCM-��������+�ޱ�ǩ���ġ�10-20�������Ӽ� \n');
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    FAUCH_test = zeros(repetition,1);
    FAUCH_train = zeros(repetition,1);
    Curve_CHtrain = 0;
    Curve_CHtest = 0;
    time = zeros(repetition,1); 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    for x = 1 : repetition %  ����
             %flag=0;
         %fprintf('��%d��\n',x);
         convexhullareatrain=0;
         convexhullareatest=0;
         
        Indices1 = crossvalind('Kfold', sum(whether==0), K);
        Indices2 = crossvalind('Kfold', sum(whether==1), K); 
        Indices = [Indices1;Indices2];
            
       
%             firstfronttrainETriCM=[];
%             firstfronttestETriCM=[];
         tic;            
        for crossnumber=1:K
                datasettrain=datasetsource((Indices~=crossnumber),:);
                datasettrain=datasettrain';
                whethertrain=whether((Indices~=crossnumber));
                
                datasettest=datasetsource((Indices==crossnumber),:);
                datasettest=datasettest';
                whethertest=whether((Indices==crossnumber));
                
                %��ÿ���������ratio��������������
                if raito>=1
                       index0 = find(whethertrain==0);n0 = length(index0);
                       RenewIndex0 = index0(randperm(n0,ceil(n0*raito/10)));
                       whethertrain(RenewIndex0)=1;
                       index1 = find(whethertrain==1);n1 = length(index1);
                       RenewIndex1 = index1(randperm(n1,ceil(n1*raito/10)));
                       whethertrain(RenewIndex1)=0;
                end
                
                if crossnumber==1
                    poplength=size(datasettrain,1);%��������newpopulationʱ�Ĳ���
                    minvalue=repmat(ones(1,poplength),popnum,1)*(-1);   %������Сֵ
                    maxvalue=repmat(ones(1,poplength),popnum,1);    %�������ֵ
                     minvalue1  =  ones(1,poplength)*(-1);%%�߽�
                     maxvalue1  =  ones(1,poplength);
                     Boundary  =  [maxvalue1;minvalue1]; 
                    population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %�����µĳ�ʼ��Ⱥ
                end
          %�����Ӽ�ѵ����Ⱥ
  [datset,lable,Distb]= kMeans(datasettrain',2,whethertrain',Parameter);
   [A,areasum]=NSGA22(population,popnum,JLDD,confidencelevel,lable',datset',Boundary,datasettest,whethertest);
       sxn=size(A,2);

                
                [convexhullETriCMtrain,convexhullETriCMtest,~,~] = ...
                    chthree(A,Distb,population,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,datasettrain,datasettest);
                convexhullareatrain=convexhullareatrain+convexhullETriCMtrain;
                convexhullareatest=convexhullareatest+convexhullETriCMtest;

%                 firstfronttrainETriCM=[firstfronttrainETriCM;firstfronttrainETriCMtemp];
%                 firstfronttestETriCM=[firstfronttestETriCM;firstfronttestETriCMtemp];
             
        end%����K��
             
%   if flag==1
%  continue;
%  end      
            
        t=toc;
        time(x,1)=t/K;
        Curve_CHtrain = Curve_CHtrain + convexhullareatrain/K;
        Curve_CHtest = Curve_CHtest + convexhullareatest/K;
        FAUCH_train(x,1) = convexhullareatrain(end)/K*100;
        FAUCH_test(x,1) = convexhullareatest(end)/K*100;
    end%������
        AuchMeanCurve_Train = Curve_CHtrain/repetition;
        AuchMeanCurve_Test = Curve_CHtest/repetition;
        performance_test = [mean(FAUCH_test,'all'),std(FAUCH_test,0,'all')];
        performance_train = [mean(FAUCH_train,'all'),std(FAUCH_train,0,'all')];
        MeanTime = [mean(time,'all'),std(time,0,'all')];
        %disp(performance_test);
        %disp(MeanTime);
        fprintf('%.2f %.2f\n',performance_test(1),performance_test(2));

        save([dirpath,'\','AuchMeanCurve_Train.mat'],'AuchMeanCurve_Train');
        save([dirpath,'\','AuchMeanCurve_Test.mat'],'AuchMeanCurve_Test');

        save([dirpath,'\','FAUCH_test.mat'],'FAUCH_test');
        save([dirpath,'\','performance_test.mat'],'performance_test');
        save([dirpath,'\','FAUCH_train.mat'],'FAUCH_train');
        save([dirpath,'\','performance_train.mat'],'performance_train');
        save([dirpath,'\','MeanTime.mat'],'MeanTime');
        save([dirpath,'\','time.mat'],'time');
        
end%�������ݼ�
end
            
            
%              switch d
%              case 1
%                     name='Ionosphere';
%               case 21
%                     name='appendicitis';              
%               case 3
%                     name='coil2000';
%               case 4
%                     name='Parkinsons';
%               case 22
%                     name='haberman';
%               case 23
%                     name='liver-disorders';
%               case 24
%                     name='fourclass';              
%               case 25
%                     name='mammogra';
%               case 26
%                     name='breast';
%               case 27
%                     name='heart';
%               case 11
%                     name='ecoli1';
%               case 28
%                     name='wisconsin';              
%               case 13
%                     name='wdbc';
%               case 14
%                     name='sonarall';
%               case 15
%                     name='pima';
%               case 16
%                     name='titanic';
%                case 17
%                     name='madelon';              
%               case 18
%                     name='vehicle3';
%               case 19
%                     name='skin';      
%            
%              end
%    
%           
%             %datapath='E:\��ǿǿ\��Ⱥ����\ETriCM\ETriCM - 10%\ʵ����\';%������ļ���·��
%             dirpath=['jg_20220302','\',name];
%   
%             %% ����������ݺ͵�һ��pareto���ϵĵ�����
%             datafirstfrontETriCMtrain=[dirpath,'\','firstfrontETriCMtrain.mat'];
%             datafirstfrontETriCMtest=[dirpath,'\','firstfrontETriCMtest.mat'];
% %             
%             dataconvexhullareaETriCMtrain=[dirpath,'\','convexhullareaETriCMtrain.mat'];
%             dataconvexhullareaETriCMtest=[dirpath,'\','convexhullareaETriCMtest.mat'];
%               lujingtime=[dirpath,'\','time.mat'];
% 
%             
%             %�����һ��pareto���ϵĵ�����
%             save(datafirstfrontETriCMtrain,'firstfronttrainETriCM');
%             save(datafirstfrontETriCMtest,'firstfronttestETriCM');
% % 
% %             %����͹�������
%             save(dataconvexhullareaETriCMtrain,'convexhullareaETriCMtrain');
%             save(dataconvexhullareaETriCMtest,'convexhullareaETriCMtest');
% %                  save(lujingtime,'time'); 
% 
%         fprintf('%s-%f\n',name,convexhullareaETriCMtest(end,:)*100);
%         %
% %         data(d)=convexhullareaETriCMtest(end,:)*100;
% %          dlmwrite('output.txt',data(d),'-append','delimiter',',') 
%       end  
% %        data2=1;
% %        dlmwrite('output.txt',data2,'-append','delimiter',',') 
% end
% % fprintf('hello end');
