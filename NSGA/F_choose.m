function choose = F_choose(functionvalue,frontvalue,maxfront,kneepoint,distance,k)
%����ѡ��

    choose=false(1,size(functionvalue,1));
    %ѡ��ǰ��ǰ��������и���
    choose(frontvalue<maxfront)=1;
    %��ѡ�����һ�����е�kneepoint
    choose(kneepoint)=1;
    %����Ϊpopnum��  
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

