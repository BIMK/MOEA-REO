
function [convexhullareaNSGAIItrain,convexhullareaNSGAIItest,firstfronttrain,firstfronttest]=NSGA2(A,Distb,population,popnum,Maxfit,confidencelevel,whethertrain,whethertest,poplength,minvalue,maxvalue,traindataset,testdataset,Boundary)
 

firstFrontStart = [];
firstFrontEnd   = [];
Lab=[];
LD=[];
LD1=[];
labChange=[];
evaluationnum=0;
%Distb=0.2%�Ŷ�������Ϊ�̶�ֵ
    %%
%---��ʼ��������

    countnumber2=1;
    convexhullareaNSGAIItrain=[];
    convexhullareaNSGAIItest=[];
    while evaluationnum<Maxfit  %��ʼ����
 
    auctrain1=[];    
   auctrain2=[];     
    auctrain3=[];
    Archive=[];
    index=[];
%%ͳһ�Ľ������
% if size(population,1)~=100
%    pause;
% end
        Offspring = P_generator(population,Boundary,'Real',popnum );%%�����Ӵ�        
         newpopulation=[population;Offspring];   %�ϲ�������Ⱥ                          
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
        %tempfunctionvalue(1:newnum,:)=functionvalue(frontvalue<=fnum,:); 
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
        popu=-sortrows(-[distancevalue;popu]')';   %��ӵ�����뽵�������fnum+1�����ϵĸ���  
        population(newnum+1:popnum,:)=newpopulation(popu(2,1:popnum-newnum),:);	%����fnum+1������ӵ������ϴ��ǰpopnum-newnum�����帴������һ��         

      %%
  
      %�����Ŷ�����Ͱ뾶
%     if evaluationnum > 100 
       [index,~,~]=areaoftest(population,traindataset,confidencelevel,whethertrain);%�����ǰ�����ϵĸ���      
       Archive=population(index,:);      
       nonindex=setdiff((1:100)',index,'rows');  
        nonarchive=population(nonindex,:);           
       nonarchive_central_point=sum(nonarchive,1)/size(nonarchive,1);%���ⲿ�ĵ����ĵ�
           B=nonarchive_central_point;
           direction=A-B;%�Ŷ�����
           N=size(nonarchive,1);
           M=size(nonarchive,2);
           Similarity=zeros(N,1);
           step=zeros(N,1);
           disturb=zeros(N,M);
            X1=[B;A];
            Sim=1-pdist(X1,'cosine');      
            DisC=(Sim+Distb)/2;    %�Ŷ�ϵ��
           
      for r=1:N
          C=nonarchive(r,:);
          X=[C;A];
          Similarity(r,:)=1-pdist(X,'cosine');
          step(r,:)=(Similarity(r,:)+Distb)*DisC;
          disturb(r,:)=step(r,:)*direction;
      end   
         newnonarchive=nonarchive+disturb;%�Ŷ�������Ⱥ
         %%     
         population=[Archive;newnonarchive];
       %%  ����������ǩ     %%

         
         [firstfronttrain,area]=area_test(population,traindataset,confidencelevel,whethertrain);
        convexhullareaNSGAIItrain(countnumber2,1)=area;
        
        [firstfronttest,areasum]=area_test(population,testdataset,confidencelevel,whethertest);
        convexhullareaNSGAIItest(countnumber2,1)=areasum;
        
        countnumber2=countnumber2+1;
        evaluationnum=evaluationnum+1;
    end
end

