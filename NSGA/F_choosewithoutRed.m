function choose = F_choosewithoutRed(functionvalue,frontvalue,maxfront,kneepoint,distance,k)
%������������ѡ����ԭ����ʦ��F_choose�������޸ģ�

    choose=false(1,size(functionvalue,1));
    
    %�Ķ�ԭ�㷨����NSGAII�е�ѡ����Ʊ仯֮����ӵ����㷨�У���ѡ��kneepoint��
    fnum=0;                                                                 %��ǰǰ����
    while numel(frontvalue,frontvalue<=fnum+1)<=k                      %�ж�ǰ���ٸ���ĸ�������ȫ������һ����Ⱥ
        fnum=fnum+1;
    end
    newnum=numel(frontvalue,frontvalue<=fnum);                              %ǰfnum����ĸ�����
   
    %ѡ��ǰfnum�����е����и���
    choose(frontvalue<fnum+1)=1;
    %��ѡ���funm+1�����е�kneepoint
    choose(frontvalue==(fnum+1)&kneepoint==1)=1;
    %����Ϊpopnum��  
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

