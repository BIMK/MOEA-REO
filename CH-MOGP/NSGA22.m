% function [tempfunctionvalue,firstfront]=NSGAII(population,popnum,Maxfit,confidencelevel,dataset,whether,poplength,minvalue,maxvalue,fanwei)
function [A,areasum]=NSGA22(population,popnum,Maxfit,confidencelevel,whethertrain,traindataset,Boundary,datasettest,whethertest)
 
evaluationnum=0;
    %%
%---��ʼ��������
Maxfit=100;
    countnumber2=1;
    while evaluationnum<Maxfit                     %��ʼ����

%%ͳһ�Ľ������
        Offspring = P_generator(population,Boundary,'Real',popnum );%%�����Ӵ�        
         newpopulation=[population;Offspring];
        evaluation=newpopulation*traindataset*10^(-3);
        evaluation(find(evaluation>=confidencelevel))=1;
        evaluation(find(evaluation<confidencelevel))=0;
        [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
        functionvalue=[fpr,tpr];%
%-------��֧������        
        fnum=0;                                             %��ǰ�����ǰ������
        cz=false(1,size(functionvalue,1));                  %��¼�����Ƿ��ѱ�������
        frontvalue=zeros(size(cz));                         %ÿ�������ǰ������
        [functionvalue_sorted,newsite]=sortrows(functionvalue);    %����Ⱥ����һάĿ��ֵ��С��������
        while ~all(cz)                                      %��ʼ�����ж�ÿ�������ǰ����,���øĽ���deductive sort   all(),���ȫ��������0���ͷ���1�����򣬷���0�������һ����0�������ѭ����
            fnum=fnum+1;
            d=cz;
            for i=1:size(functionvalue,1)
                if ~d(i)
                    for j=i+1:size(functionvalue,1)
                        if ~d(j)
                            k=1;                            
                            for m=2:size(functionvalue,2)
                                if functionvalue_sorted(i,m)<functionvalue_sorted(j,m)%����Ϊ��classification�Ķ���
                                    k=0;
                                    break
                                end
                            end
                            if k
                                d(j)=true;   %˵��i�ǿ���֧��j�ģ������¼j�Ѿ������䣬����j�϶�������һ��ġ�
                            end
                        end
                    end
                    frontvalue(newsite(i))=fnum;
                    cz(i)=true;  %ֻ���޷��������ĵ�֧��ĵ����������һ��
                end
            end
        end
        
%-------����ӵ������/ѡ����һ������        
        fnum=0;                                                                 %��ǰǰ����
        while numel(frontvalue,frontvalue<=fnum+1)<=popnum                      %�ж�ǰ���ٸ���ĸ�������ȫ������һ����Ⱥ
            fnum=fnum+1;
        end        
        newnum=numel(frontvalue,frontvalue<=fnum);                              %ǰfnum����ĸ�����
        tempfunctionvalue(1:newnum,:)=functionvalue(frontvalue<=fnum,:); 
        population(1:newnum,:)=newpopulation(frontvalue<=fnum,:);               %��ǰfnum����ĸ��帴������һ��                       
        popu=find(frontvalue==fnum+1);                                          %popu��¼��fnum+1�����ϵĸ�����
        distancevalue=zeros(size(popu));                                        %popu�������ӵ������
        fmax=max(functionvalue(popu,:),[],1);                                   %popuÿά�ϵ����ֵ
        fmin=min(functionvalue(popu,:),[],1);                                   %popuÿά�ϵ���Сֵ
        for i=1:size(functionvalue,2)                                           %��Ŀ�����ÿ��Ŀ����popu�������ӵ������
            [~,newsite]=sortrows(functionvalue(popu,i));
            distancevalue(newsite(1))=inf;
            distancevalue(newsite(end))=inf;
            for j=2:length(popu)-1
                distancevalue(newsite(j))=distancevalue(newsite(j))+(functionvalue(popu(newsite(j+1)),i)-functionvalue(popu(newsite(j-1)),i))/(fmax(i)-fmin(i));
            end
        end                                      
        popu=-sortrows(-[distancevalue;popu]')';                                %��ӵ�����뽵�������fnum+1�����ϵĸ���
        population(newnum+1:popnum,:)=newpopulation(popu(2,1:popnum-newnum),:);	%����fnum+1������ӵ������ϴ��ǰpopnum-newnum�����帴������һ��         
       %% 
       %����͹���Ͻ�����ĵ�
        [index,~,~]=areaoftest(newpopulation,traindataset,confidencelevel,whethertrain);%�����ǰ�����ϵĸ���      
       Archive=newpopulation(index,:);              
       archive_central_point=sum(Archive,1)/size(Archive,1);%�ⲿ�ĵ����ĵ�
       A=archive_central_point;
       
       
       %%
        tempfunctionvalue(newnum+1:popnum,:)=functionvalue(popu(2,1:popnum-newnum),:);%tempfunctionvalue������¼����������Ŀ�꺯��ֵ
        evaluationnum=evaluationnum+1;
     
        [firstfronttest,areasum]=area_test(population,datasettest,confidencelevel,whethertest);
        convexhullareaNSGAIItest(countnumber2,1)=areasum;
        
        countnumber2=countnumber2+1;
      %  disp(['it is NSGA: ' num2str(evaluationnum)]);
    end

%     firstfronttrain=pareto;
%     firstfronttest=temp;
%     firstFrontEnd = firstfronttest;
    
% firstfronttrain(size(firstfronttrain,1)-1:size(firstfronttrain,1),:)=[];
% firstfronttest(size(firstfronttest,1)-1:size(firstfronttest,1),:)=[];
end

