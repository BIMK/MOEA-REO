% function [tempfunctionvalue,firstfront]=NSGAII(population,popnum,Maxfit,confidencelevel,dataset,whether,poplength,minvalue,maxvalue,fanwei)
function [convexhullarea]=NSGAII(population,popnum,Maxfit,confidencelevel,whether,poplength,minvalue,maxvalue,fanwei,dataset)
   
    evaluationnum=0;
    %%
%---开始迭代进化

    countnumber2=1;
    convexhullarea=[];
    while evaluationnum<Maxfit                    %开始迭代
%-------交叉 
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
        newpopulation=[population;newpopulation];                               %合并父子种群
        
% %-------计算目标函数值        
%         functionvalue=zeros(size(newpopulation,1),2);           %合并后种群的各目标函数值,这里的问题是ZDT1
%         functionvalue(:,1)=newpopulation(:,1);                  %计算第一维目标函数值
%         g=1+9*sum(newpopulation(:,2:poplength),2)./(poplength-1);           %为什么这里要乘以9
%         functionvalue(:,2)=g.*(1-(newpopulation(:,1)./g).^0.5); %计算第二维目标函数值

%1:SCH
%2:FON
%3:POL
%4:KUR
%5:ZDT1
%6:ZDT2
%7:ZDT3
%8:ZDT4
%9:ZDT6

%         functionvalue=benchmarkformob(newpopulation,9);
        evaluation=newpopulation*dataset*10^(-3);
        
        %暂时把评估值小于0.9的判定为负样本
        evaluation(find(evaluation>=confidencelevel))=1;
        evaluation(find(evaluation<confidencelevel))=0;
%         newpopulation=[newpopulation;a];%防止因为所有的点共线而无法生成凸包

        [tpr,fpr]=calculatetprandfpr(evaluation,whether);
%         tpr=-tpr;
        functionvalue=[fpr,tpr];%
        
%         functionvalue=benchmarkformob(newpopulation,9);

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
        tempfunctionvalue(newnum+1:popnum,:)=functionvalue(popu(2,1:popnum-newnum),:);%tempfunctionvalue用来记录满足条件的目标函数值
        evaluationnum=evaluationnum+popnum/2;
%         firstfront=functionvalue(frontvalue==1,:); 


        tempa=zeros(1,2);
        tempa(1,1)=1;
        tempa(1,2)=1;
    
        tempb=zeros(1,2);
        tempb(1,1)=0;
        tempb(1,2)=0;

        pareto=chraarea(tempfunctionvalue);
        pareto=[pareto;tempa;tempb];%将这两点加入到种群中，使得计算出来的面积更精确
        area=calculatearea(pareto);
        convexhullarea(countnumber2,1)=area;
        countnumber2=countnumber2+1;
        
    end

end

