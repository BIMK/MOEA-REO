function T=Reduce(Q,N,range)
%Q�Ǵ�Լ���ĵ㼯��n��Q��Ӧ��Լ���ĵ�ĸ���
beitanumber=11;%������Ħµ�ά��
U=Q;%�Գ�ʼ��ȺQ���и���
i=1;%����ָʾpareto������cell�����е�λ��
while(~isempty(U))
    
    [pareto,A]=CWR(U,range);
    paretonumber=size(pareto,1);
    paretofront(i,1)={pareto};
    paretofront(i,2)={A};
    i=i+1;
    U=setdiff(U,pareto,'rows');%��U��ȥ��pareto�еĵ�,c = setdiff(A, B, 'rows')
  %��A��B�Ǿ�����ͬ�����ľ���ʱ������A���ж�B��û�е���Щ��   
end
%%%%%
T=[];
M=N;
for paretoi=1:size(paretofront,1)
    if size(cell2mat(paretofront(paretoi,1)),1)+size(cell2mat(paretofront(paretoi,2)),1)>=M
        if size(cell2mat(paretofront(paretoi,1)),1)>=M %�Ķ�����u��ΪM
            
            deltaareatemp=DeltaArea(cell2mat(paretofront(paretoi,1)));%deltaarea�д�����ǵ�i��pareto���ϵ�������Լ�����deltaarea
            deltaareatemp=sortrows(deltaareatemp,3);%��deltaareatemp��������Ҳ����deltaarea���д�С��������
            reservedot=deltaareatemp(size(deltaareatemp,1)-M+1:size(deltaareatemp),1:2);
            T=[T;reservedot];%������뵽T��
            
            
        else
            
            T=[T;cell2mat(paretofront(paretoi,1))];
            remaining=M-size(cell2mat(paretofront(paretoi,1)),1);
            tempRtemp=cell2mat(paretofront(paretoi,2));
            tempRtemp=sortrows(tempRtemp,3);%��tempRtemp��������Ҳ����D���д�С������������ȡǰ��D�Ƚ�С�ĵ�
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

