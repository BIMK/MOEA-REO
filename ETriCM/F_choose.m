function choose = F_choose(functionvalue,frontvalue,maxfront,kneepoint,distance,k)
%环境选择

    choose=false(1,size(functionvalue,1));
    %选出前面前沿面的所有个体
    choose(frontvalue<maxfront)=1;
    %先选择最后一个面中的kneepoint
    choose(kneepoint)=1;
    %增减为popnum个  
    if sum(choose)<k
        temp=find(frontvalue==maxfront & kneepoint==0);        
        [null,rank]=sort(distance(temp),'descend');
        choose(temp(rank(1:(k-sum(choose)))))=1;
    elseif sum(choose)>k
        temp=find(frontvalue==maxfront & kneepoint==1);        
        [null,rank]=sort(distance(temp));
        choose(temp(rank(1:(sum(choose)-k))))=0;       
    end
end

