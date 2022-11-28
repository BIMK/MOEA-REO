
function [Pauc ]=caAUC( Xte,Yte,alpha,beta,w)  %Xte是数据集，Yte是标签，alpha=0，beta=1，w是种群也是就分类器权重
pos_num1=sum(Yte==1);%number of positive Xte
neg_num1=sum(Yte==0);%number of negative Xte

n_alpha2=alpha*neg_num1;
if(n_alpha2==round(n_alpha2))
    j_alpha2=ceil(n_alpha2)+1;
else
j_alpha2=ceil(n_alpha2);
end
n_beta2=beta*neg_num1;
if(n_beta2==round(n_beta2)) 
    j_beta2=floor(n_beta2)-1;
else
j_beta2=floor(n_beta2);%测试集变量，
end

f=Xte*w;
f1=[Yte,f];
ff=flipud(sortrows(f1,2));
xx=0;yy=0;num=0;

for i=1:size(Xte,1)
if(ff(i,1)==1)
    yy=yy+1;
    
else
    xx=xx+1;
        
    if(xx>n_alpha2)
      if(xx==j_alpha2)
          y1=yy*(j_alpha2-n_alpha2);
          num=num+y1;
      else
      if(xx==(j_beta2+1))
          y1=yy*(n_beta2-j_beta2);
          num=num+y1;
      else
       num=num+yy;
      end
      end
    
    if(xx>=j_beta2+1)
        break;
    end
    end
end
 
end


% disp(n_alpha2);
%输出pauc
Pauc=num/((beta-alpha)*pos_num1*neg_num1);
% disp('Pauc=');
% disp(Pauc);
