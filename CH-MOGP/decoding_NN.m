 
 
function Output=decoding_NN(Population,HidNum,Data)
%data  n*m
HidNum=HidNum+1;
Data=Data';
for index=1:size(Population,1)
    Individual=Population(index,:); 
    
     H2O_matrix=Individual(end-HidNum+1:end)';
     
    Num=size(Data,2)+1;
    for i=1:Num
        I2H_Matrix(i,:)=Individual((i-1)*HidNum+1 :i*HidNum);
    end
    
%     H2O_matrix=Individual((Num-1)*HidNum+1:Num*HidNum)';
    Temp=[Data ones(size(Data,1),1)];
    H_input=Temp*I2H_Matrix;
    
   % H_out= sigmod(H_input);
    
   % Output(index,:)=(H_out*H2O_matrix)';
 Output(index,:)=(H_input*H2O_matrix)';
end
end
 
 
 
% function f=sigmod(Input)
%  
% f=1./(1+exp(-(Input)));
%  
%  
% end
