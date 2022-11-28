function [kneepoint,distance,r,t,R]=three(functionvalue,frontvalue,maxfront,r,t,rate)
%将kmeans方法应用到kneepoint方法中，每一个聚类中都单独计算distance
[N,M]=size(functionvalue);
R=[];
kneepoint=false(1,N);
distance=zeros(1,N);
%分前沿面依次找出各面中的kneepoint
for i=1:maxfront
    temp=find(frontvalue==i);                           %当前前沿面的个体
    if length(temp)<=M                                  %若点不足则全选为kneepoint
        kneepoint(temp)=1;
    else
        if t(i)==-1
            r(i)=1;
        else
            r(i)=r(i)/exp((1-t(i)/rate)/M);
        end
        sortnumber = 5;%实验只聚成一个类的时候，算法的结果
%         sortnumber=ceil(1/r(i));
        if sortnumber>size(functionvalue(temp,:),1)
            sortnumber=size(functionvalue(temp,:),1);%因为某种问题，导致sortnumber大于functionvalue的个数
        end
        if sortnumber<=0
            sortnumber=1;
        end
        %首先对该层中的点进行聚类
        %由于在某一步骤中
        try
            rand=kmeans(functionvalue(temp,:),sortnumber,'MaxIter',1000);
        catch
            rand(1:end)=1;
        end
        %对该层中的每一个聚类进行进行选取kneePoint
        for sorti=1:sortnumber
            dotnumber=temp(find(rand==sorti));%对应于某一层中某一个聚类的点的集合
            dottemp=functionvalue(dotnumber,:);%将具体的坐标取出来
            if size(dottemp,1)==1
               distance(dotnumber)==0; 
            else
            distancetemp=calculatedis(dottemp,M);
            %将distance赋值给相应的distance中
            for disi=1:size(distancetemp,1)
                distance(dotnumber(disi))=distancetemp(disi);
            end
            [~,tempdot]=max(distance(dotnumber));
            tempdot=dotnumber(tempdot);
            end
            kneepoint(dotnumber)=1;
        end
        t(i)=sortnumber/length(temp);%kennpoint占总的点的比例
    end
end
end