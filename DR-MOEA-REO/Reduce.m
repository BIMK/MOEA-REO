function T=Reduce(Q,N,range)
%Q是待约减的点集，n是Q中应当约减的点的个数
% clc
% clear all;
% 
% N=50;
% 
% dimension=2;
% number=100;
% range=1;
% 
% Q=rand(number,dimension);


beitanumber=11;%构造出的β的维数

U=Q;%对初始种群Q进行复制


i=1;%用来指示pareto储存在cell数组中的位置

%%将CHIM运行之后得到的
%%%%此处是15年与16年的区别
while(~isempty(U))
    
    [pareto,A]=CHIM(U,range);%此处是15年与16年的区别
    paretonumber=size(pareto,1);
    
    %使用cell数组paretofront(:,1)去储存pareto面上的各个点,paretofront(:,2)来储存从pareto边上扩展出来的点
    paretofront(i,1)={pareto};
    paretofront(i,2)={A};
    i=i+1;
    
    U=setdiff(U,pareto,'rows');%从U中去除pareto中的点,c = setdiff(A, B, 'rows')
  %当A和B是具有相同列数的矩阵时，返回A中有而B中没有的那些行   
end
%%%%%
% Q=[p;p];
% Q(17:size(Q(:,1)),:)=[];

% R=[];%冗余集合
% U=Q;%非冗余集合
% redundancy=[];%储存冗余点的序号
% unredundancy=[];%储存非冗余点的序号
%Q是解集，n是将被丢弃的解的个数


%写错了，下面更改，防止重复出现错误，因此保留在这个地方
% for i=1:size(Q(:,1))
%    for j=i+1:size(Q(:,1))
%        if((Q(i,1)==Q(j,1))&&(Q(i,2)==Q(j,2)))
%             redundancy=[redundancy;j];
%        end
%
%    end
% end

% for i=1:size(Q,1)
%    for j=i+1:size(Q,1)
%        if(Q(i,:)==Q(j,:))
%             redundancy=[redundancy;j];
%        end
%
%    end
% end
% redundancy=unique(redundancy,'rows');
%
% R=Q(redundancy,:);
% U(redundancy,:)=[];
T=[];
M=N;
for paretoi=1:size(paretofront,1)
    if size(cell2mat(paretofront(paretoi,1)),1)+size(cell2mat(paretofront(paretoi,2)),1)>=M
%         number=ceil(M*rand(1,1));
        if size(cell2mat(paretofront(paretoi,1)),1)>=M %改动：将u改为M
            
            deltaareatemp=DeltaArea(cell2mat(paretofront(paretoi,1)));%deltaarea中储存的是第i层pareto面上点的坐标以及它的deltaarea
            deltaareatemp=sortrows(deltaareatemp,3);%将deltaareatemp按第三列也就是deltaarea进行从小到大排序
            %deletearea=deltaareatemp(1:n-size(F(:,1)),1:2);%第i层pareto面中将要被删除的点
            reservedot=deltaareatemp(size(deltaareatemp,1)-M+1:size(deltaareatemp),1:2);
            T=[T;reservedot];%将点加入到T中
            
%             paretofront(paretoi,2)
            
            
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


% if(size(R,1)>=n)
%     number=randperm(size(R,1));
%     delete=number(1:n);
%     temp=R;
%     temp(delete,:)=[];
%     Q=[];
%     Q=[U;temp];
% else
%     F=R;
%     [paretosum,pareto]=CWR(U,fanwei);
% %     paretosum=paretocount(pareto);%各个pareto层中的非零点个数
%
%     for paretoi=size(paretosum):-1:1
%         ftemp=[];
%         if(size(F,1)+paretosum(paretoi)<n)
%             ftemp=three2two(pareto(paretoi,:,:),paretosum(paretoi));
%             F=cat(1,F,ftemp);
%             same=deletepareto(U,ftemp);%将集合U中的第i层pareto面上的点删除
%             U(same,:)=[];
%         else
%             break;
%         end
%     end
%
%      tempdeltaarea=three2two(pareto(paretoi,:,:),paretosum(paretoi));%先将第i层的pareto面中的点坐标设置为二维
%      deltaareatemp=DeltaArea(tempdeltaarea);%deltaarea中储存的是第i层pareto面上点的坐标以及它的deltaarea
%      deltaareatemp=sortrows(deltaareatemp,3);%将deltaareatemp按第三列也就是deltaarea进行从小到大排序
%      deletearea=deltaareatemp(1:n-size(F(:,1)),1:2);%第i层pareto面中将要被删除的点
%
%      F=cat(1,F,deletearea);
%      same=deletepareto(U,deletearea);
%      U(same,:)=[];
%      Q=U;
% end
