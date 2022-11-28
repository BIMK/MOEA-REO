function T=Reduce(Q,N,range)
%Q是待约减的点集，n是Q中应当约减的点的个数
beitanumber=11;%构造出的β的维数
U=Q;%对初始种群Q进行复制
i=1;%用来指示pareto储存在cell数组中的位置
while(~isempty(U))
    
    [pareto,A]=CWR(U,range);
    paretonumber=size(pareto,1);
    paretofront(i,1)={pareto};
    paretofront(i,2)={A};
    i=i+1;
    U=setdiff(U,pareto,'rows');%从U中去除pareto中的点,c = setdiff(A, B, 'rows')
  %当A和B是具有相同列数的矩阵时，返回A中有而B中没有的那些行   
end
%%%%%
T=[];
M=N;
for paretoi=1:size(paretofront,1)
    if size(cell2mat(paretofront(paretoi,1)),1)+size(cell2mat(paretofront(paretoi,2)),1)>=M
        if size(cell2mat(paretofront(paretoi,1)),1)>=M %改动：将u改为M
            
            deltaareatemp=DeltaArea(cell2mat(paretofront(paretoi,1)));%deltaarea中储存的是第i层pareto面上点的坐标以及它的deltaarea
            deltaareatemp=sortrows(deltaareatemp,3);%将deltaareatemp按第三列也就是deltaarea进行从小到大排序
            reservedot=deltaareatemp(size(deltaareatemp,1)-M+1:size(deltaareatemp),1:2);
            T=[T;reservedot];%将点加入到T中
            
            
        else
            
            T=[T;cell2mat(paretofront(paretoi,1))];
            remaining=M-size(cell2mat(paretofront(paretoi,1)),1);
            tempRtemp=cell2mat(paretofront(paretoi,2));
            tempRtemp=sortrows(tempRtemp,3);%将tempRtemp按第三列也就是D进行从小到大排序，优先取前面D比较小的点
            reservedot=tempRtemp(1:remaining,1:2);
            T=[T;reservedot];            
            
        end
        break;
    else
        temppareto=cell2mat(paretofront(paretoi,1));
        tempR=cell2mat(paretofront(paretoi,2));
        
        
        
        if ~isempty(tempR)
            tempR(:,3)=[];
            T=[T;temppareto;tempR];
        else
            T=[T;temppareto];
        end
        M=M-size(cell2mat(paretofront(paretoi,1)),1)-size(cell2mat(paretofront(paretoi,2)),1);
    end
end
end

