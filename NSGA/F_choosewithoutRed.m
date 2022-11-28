function choose = F_choosewithoutRed(functionvalue,frontvalue,maxfront,kneepoint,distance,k)
%■■■■环境选择（与原张老师的F_choose进行了修改）

    choose=false(1,size(functionvalue,1));
    
    %改动原算法，将NSGAII中的选择机制变化之后添加到该算法中（先选择kneepoint）
    fnum=0;                                                                 %当前前沿面
    while numel(frontvalue,frontvalue<=fnum+1)<=k                      %判断前多少个面的个体能完全放入下一代种群
        fnum=fnum+1;
    end
    newnum=numel(frontvalue,frontvalue<=fnum);                              %前fnum个面的个体数
   
    %选出前fnum个面中的所有个体
    choose(frontvalue<fnum+1)=1;
    %先选择第funm+1个面中的kneepoint
    choose(frontvalue==(fnum+1)&kneepoint==1)=1;
    %增减为popnum个  
    if sum(choose)<k
        temp=find(frontvalue==fnum+1 & kneepoint==0);        
        [null,rank]=sort(distance(temp),'descend');
        choose(temp(rank(1:(k-sum(choose)))))=1;
    elseif sum(choose)>k
        temp=find(frontvalue==fnum+1 & kneepoint==1);        
        [null,rank]=sort(distance(temp));
        choose(temp(rank(1:(sum(choose)-k))))=0;       
    end
end

