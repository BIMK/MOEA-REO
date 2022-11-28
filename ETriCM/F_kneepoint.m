function [kneepoint,distance,r,t,R] = F_kneepoint(functionvalue,frontvalue,maxfront,r,t,rate)
%分前沿面选出kneepoint
    R=[];%★★★★自己加的,因为原来的代码中，R只在第一层包含多余一个值的点的时候才会被赋值，因此会导致程序出现问题
    [N,M]=size(functionvalue);

    kneepoint=false(1,N);
    distance=zeros(1,N);
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
            %★★★★这地方也改了，下面是原来的代码
%             if i==1
%                 R = maxjuli;
%             end
            
            if isempty(R)
                R = maxjuli;
            end
            %按范围选择出最优的个体作为参考点
            [~,rank]=sort(distance(temp),'descend');
            choose=zeros(1,length(rank));
            canchoose=ones(1,length(rank));
            for j=rank
                if canchoose(j)
                    for k=1:length(temp)     
                        if abs(functionvalue(temp(j),:)-functionvalue(temp(k),:))<=maxjuli
                            canchoose(k)=0;
                        end
                    end
                    choose(j)=1;
                end
            end
            t(i)=sum(choose)/length(temp);
            choose(rank(find(choose(rank)==1,1,'last')))=0;
            kneepoint(temp(choose==1))=1;
        end
    end
end

