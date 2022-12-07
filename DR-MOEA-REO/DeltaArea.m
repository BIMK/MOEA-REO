% clear all
% clc

function Q=DeltaArea(pareto)
 % pareto=rand(10,2);
Q=pareto;
m=size(Q,1);%该层pareto面中的点的个数
mianji=zeros(m,1);
if m<3
    mianji(:,1)=inf;
    Q=[Q,mianji];
else
    mianji(1)=inf;
    mianji(m)=inf;
    for i=2:m-1
        mianji(i)=0.5*abs((Q(i,2)-Q(i-1,2))*(Q(i+1,1)-Q(i-1,1))-(Q(i,1)-Q(i-1,1))*(Q(i+1,2)-Q(i-1,2)));%s=0.5*|(y2-y1)(x3-x1)-(x2-x1)(y3-y1)|
    end
    Q=[Q,mianji];
    
    temp=Q;
    while size(temp)>2
        [~,r]=min(temp(:,3));    
        temp(r,:)=[];
        
        m=size(temp(:,3));
        temp(1,3)=inf;
        temp(m,3)=inf;
        for i=2:m-1
            temp(i,3)=0.5*abs((temp(i,2)-temp(i-1,2))*(temp(i+1,1)-temp(i-1,1))-(temp(i,1)-temp(i-1,1))*(temp(i+1,2)-temp(i-1,2)));%s=0.5*|(y2-y1)(x3-x1)-(x2-x1)(y3-y1)|
        end
        
        for tempi=1:size(temp)
            for tempj=1:size(Q)
                if((temp(tempi,1)==Q(tempj,1))&&(temp(tempi,2)==Q(tempj,2))&&(temp(tempi,3)~=Q(tempj,3)))
                    Q(tempi,3)=temp(tempi,3);
                end
            end
        end
        
    end
    
end
