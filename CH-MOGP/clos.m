function f=clos(cankao,U,num)
M=size(cankao,1);
dis=[];
N=size(U,1);
f=[];
n=0;
discankao=[];

for i=1:M
    distance1=zeros(1,N);
    paixu=[];
    index=[];
    for j=1:N
        distance1(j)=sqrt((cankao(i,1)-U(j,1))^2+(cankao(i,2)-U(j,2))^2);
    end
    [paixu,index]=sort(distance1);
    discankao=[discankao; index]; 
end
number=0;
ind=[];
j=1;
while number < num
    for i=1:M
        ind=[ind discankao(i,j)];
        ind=unique(ind);
        number=size(ind,2);
        if number>=num
            f=U(ind,:);
            return ;
        end
    end
    j=j+1;
end
 f=U(ind,:);

