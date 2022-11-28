function [kneepoint,area,r,t,R]=two(functionvalue,frontvalue,maxfront,r,t,rate)
%将kmeans方法应用到kneepoint方法中，并将点之间的面积作为评价点的优先级标准，主要用于ROC的两维比较
    [N,M]=size(functionvalue);
    R=[];
    kneepoint=false(1,N);
    area=zeros(1,N);
    %分前沿面依次找出各面中的kneepoint
    for i=1:maxfront
        temp=find(frontvalue==i);                           %当前前沿面的个体
        if length(temp)<=M                                  %若点不足则全选为kneepoint
            kneepoint(temp)=1;
        else
            %找出边界点
            [~,rank]=sort(functionvalue(temp,:),'descend');
            extreme=zeros(1,M);                             %用来保存边界点编号,边界点的数目和目标维数相同
            extreme(1)=rank(1,1);                           %第一维值最大的个体
            for j=2:length(extreme)                         %分别寻找后面每一维值最大的个体
                k=1;
                extreme(j)=rank(k,j);
                while ismember(extreme(j),extreme(1:j-1))   %若当前维值最大的个体与之前已选出的边界点相同,则取次大值,直至不同
                    k=k+1;
                    extreme(j)=rank(k,j);
                end
            end
            %计算由边界点构成的线,面或超平面的一般式方程的系数
            hyperplane=functionvalue(temp(extreme),:)\ones(length(extreme),1);
            %确定每个点(个体)到线,面或超平面的距离值(距离越大越好)
            distance(temp)=-(functionvalue(temp,:)*hyperplane-1)./sqrt(sum(hyperplane.^2));
            %更新邻居范围
            fmax=max(functionvalue(temp,:),[],1);
            fmin=min(functionvalue(temp,:),[],1);
            if t(i)==-1
                r(i)=1;
            else
                r(i)=r(i)/exp((1-t(i)/rate)/M);
            end
            maxjuli=(fmax-fmin).*r(i);
            if i == 1
                R = maxjuli;
            end
            %按范围选择出最优的个体作为参考点
            sortnumber=ceil(1/r(i));
            if sortnumber>size(functionvalue(temp,:),1)
               sortnumber=size(functionvalue(temp,:),1);%因为某种问题，导致sortnumber大于functionvalue的个数
            end
            rank=kmeans(functionvalue(temp,:),sortnumber,'MaxIter',1000);
            for sorti=1:sortnumber
                dotnumber=temp(find(rank==sorti));%对应于某一层中某一个聚类的点的集合
                [~,tempdot]=max(distance(dotnumber));
                tempdot=dotnumber(tempdot);
                kneepoint(tempdot)=1;
            end
            
            t(i)=sortnumber/length(temp);%kennpoint占总的点的比例
        end
    end
end