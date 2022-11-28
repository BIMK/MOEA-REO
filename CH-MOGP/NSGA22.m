% function [tempfunctionvalue,firstfront]=NSGAII(population,popnum,Maxfit,confidencelevel,dataset,whether,poplength,minvalue,maxvalue,fanwei)
function [A,areasum]=NSGA22(population,popnum,Maxfit,confidencelevel,whethertrain,traindataset,Boundary,datasettest,whethertest)
 
evaluationnum=0;
    %%
%---开始迭代进化
Maxfit=100;
    countnumber2=1;
    while evaluationnum<Maxfit                     %开始迭代

%%统一的交叉变异
        Offspring = P_generator(population,Boundary,'Real',popnum );%%产生子代        
         newpopulation=[population;Offspring];
        evaluation=newpopulation*traindataset*10^(-3);
        evaluation(find(evaluation>=confidencelevel))=1;
        evaluation(find(evaluation<confidencelevel))=0;
        [tpr,fpr]=calculatetprandfpr(evaluation,whethertrain);
        functionvalue=[fpr,tpr];%
%-------非支配排序        
        fnum=0;                                             %当前分配的前沿面编号
        cz=false(1,size(functionvalue,1));                  %记录个体是否已被分配编号
        frontvalue=zeros(size(cz));                         %每个个体的前沿面编号
        [functionvalue_sorted,newsite]=sortrows(functionvalue);    %对种群按第一维目标值大小进行排序
        while ~all(cz)                                      %开始迭代判断每个个体的前沿面,采用改进的deductive sort   all(),如果全部都不是0，就返回1，否则，返回0（如果有一个是0，则进行循环）
            fnum=fnum+1;
            d=cz;
            for i=1:size(functionvalue,1)
                if ~d(i)
                    for j=i+1:size(functionvalue,1)
                        if ~d(j)
                            k=1;                            
                            for m=2:size(functionvalue,2)
                                if functionvalue_sorted(i,m)<functionvalue_sorted(j,m)%这里为了classification改动了
                                    k=0;
                                    break
                                end
                            end
                            if k
                                d(j)=true;   %说明i是可以支配j的，这里记录j已经被分配，所以j肯定不是这一层的。
                            end
                        end
                    end
                    frontvalue(newsite(i))=fnum;
                    cz(i)=true;  %只有无法被其他的点支配的点才能属于这一层
                end
            end
        end
        
%-------计算拥挤距离/选出下一代个体        
        fnum=0;                                                                 %当前前沿面
        while numel(frontvalue,frontvalue<=fnum+1)<=popnum                      %判断前多少个面的个体能完全放入下一代种群
            fnum=fnum+1;
        end        
        newnum=numel(frontvalue,frontvalue<=fnum);                              %前fnum个面的个体数
        tempfunctionvalue(1:newnum,:)=functionvalue(frontvalue<=fnum,:); 
        population(1:newnum,:)=newpopulation(frontvalue<=fnum,:);               %将前fnum个面的个体复制入下一代                       
        popu=find(frontvalue==fnum+1);                                          %popu记录第fnum+1个面上的个体编号
        distancevalue=zeros(size(popu));                                        %popu各个体的拥挤距离
        fmax=max(functionvalue(popu,:),[],1);                                   %popu每维上的最大值
        fmin=min(functionvalue(popu,:),[],1);                                   %popu每维上的最小值
        for i=1:size(functionvalue,2)                                           %分目标计算每个目标上popu各个体的拥挤距离
            [~,newsite]=sortrows(functionvalue(popu,i));
            distancevalue(newsite(1))=inf;
            distancevalue(newsite(end))=inf;
            for j=2:length(popu)-1
                distancevalue(newsite(j))=distancevalue(newsite(j))+(functionvalue(popu(newsite(j+1)),i)-functionvalue(popu(newsite(j-1)),i))/(fmax(i)-fmin(i));
            end
        end                                      
        popu=-sortrows(-[distancevalue;popu]')';                                %按拥挤距离降序排序第fnum+1个面上的个体
        population(newnum+1:popnum,:)=newpopulation(popu(2,1:popnum-newnum),:);	%将第fnum+1个面上拥挤距离较大的前popnum-newnum个个体复制入下一代         
       %% 
       %计算凸包上解的中心点
        [index,~,~]=areaoftest(newpopulation,traindataset,confidencelevel,whethertrain);%求出在前沿面上的个体      
       Archive=newpopulation(index,:);              
       archive_central_point=sum(Archive,1)/size(Archive,1);%外部文档中心点
       A=archive_central_point;
       
       
       %%
        tempfunctionvalue(newnum+1:popnum,:)=functionvalue(popu(2,1:popnum-newnum),:);%tempfunctionvalue用来记录满足条件的目标函数值
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

