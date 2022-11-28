function [functionvalue,population,functionvalue1,functionvalue2,functionvalue3]=clos(cankao,U,num,Population)
M=size(cankao,1);
dis=[];
N=size(U,1);
population=[];
functionvalue=[];
functionvalue1=[];
functionvalue2=[];
functionvalue3=[];
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
    discankao=[discankao;index]; 
end
number=0;
ind=[];
ind1=[];
ind2=[];
ind3=[];
j=1;
while number < num
    for i=1:M
        ind=[ind discankao(i,j)];
        ind=unique(ind);        
        number=size(ind,2);
        if number>=num
            population=Population(ind,:);
            functionvalue=U(ind,:);
            return ;
        end
    end
    if j==1
    ind1=ind
    n1=size(ind1,2);
    end
    if j==2      
        ind2=setdiff(ind,ind1)
    end
    if j==3
         ind3=setdiff(ind,ind1);
         ind3=setdiff(ind3,ind2)
       
    end
     functionvalue1=U(ind1,:);
     functionvalue2=U(ind2,:);
     functionvalue3=U(ind3,:);
     j=j+1;
end

