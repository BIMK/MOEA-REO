function T=Reduce(Q,N,range)
%Q�Ǵ�Լ���ĵ㼯��n��Q��Ӧ��Լ���ĵ�ĸ���
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


beitanumber=11;%������Ħµ�ά��

U=Q;%�Գ�ʼ��ȺQ���и���


i=1;%����ָʾpareto������cell�����е�λ��

%%��CHIM����֮��õ���
%%%%�˴���15����16�������
while(~isempty(U))
    
    [pareto,A]=CHIM(U,range);%�˴���15����16�������
    paretonumber=size(pareto,1);
    
    %ʹ��cell����paretofront(:,1)ȥ����pareto���ϵĸ�����,paretofront(:,2)�������pareto������չ�����ĵ�
    paretofront(i,1)={pareto};
    paretofront(i,2)={A};
    i=i+1;
    
    U=setdiff(U,pareto,'rows');%��U��ȥ��pareto�еĵ�,c = setdiff(A, B, 'rows')
  %��A��B�Ǿ�����ͬ�����ľ���ʱ������A���ж�B��û�е���Щ��   
end
%%%%%
% Q=[p;p];
% Q(17:size(Q(:,1)),:)=[];

% R=[];%���༯��
% U=Q;%�����༯��
% redundancy=[];%�������������
% unredundancy=[];%��������������
%Q�ǽ⼯��n�ǽ��������Ľ�ĸ���


%д���ˣ�������ģ���ֹ�ظ����ִ�����˱���������ط�
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
        if size(cell2mat(paretofront(paretoi,1)),1)>=M %�Ķ�����u��ΪM
            
            deltaareatemp=DeltaArea(cell2mat(paretofront(paretoi,1)));%deltaarea�д�����ǵ�i��pareto���ϵ�������Լ�����deltaarea
            deltaareatemp=sortrows(deltaareatemp,3);%��deltaareatemp��������Ҳ����deltaarea���д�С��������
            %deletearea=deltaareatemp(1:n-size(F(:,1)),1:2);%��i��pareto���н�Ҫ��ɾ���ĵ�
            reservedot=deltaareatemp(size(deltaareatemp,1)-M+1:size(deltaareatemp),1:2);
            T=[T;reservedot];%������뵽T��
            
%             paretofront(paretoi,2)
            
            
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
% %     paretosum=paretocount(pareto);%����pareto���еķ�������
%
%     for paretoi=size(paretosum):-1:1
%         ftemp=[];
%         if(size(F,1)+paretosum(paretoi)<n)
%             ftemp=three2two(pareto(paretoi,:,:),paretosum(paretoi));
%             F=cat(1,F,ftemp);
%             same=deletepareto(U,ftemp);%������U�еĵ�i��pareto���ϵĵ�ɾ��
%             U(same,:)=[];
%         else
%             break;
%         end
%     end
%
%      tempdeltaarea=three2two(pareto(paretoi,:,:),paretosum(paretoi));%�Ƚ���i���pareto���еĵ���������Ϊ��ά
%      deltaareatemp=DeltaArea(tempdeltaarea);%deltaarea�д�����ǵ�i��pareto���ϵ�������Լ�����deltaarea
%      deltaareatemp=sortrows(deltaareatemp,3);%��deltaareatemp��������Ҳ����deltaarea���д�С��������
%      deletearea=deltaareatemp(1:n-size(F(:,1)),1:2);%��i��pareto���н�Ҫ��ɾ���ĵ�
%
%      F=cat(1,F,deletearea);
%      same=deletepareto(U,deletearea);
%      U(same,:)=[];
%      Q=U;
% end
