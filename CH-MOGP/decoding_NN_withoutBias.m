 
 
function Output=decoding_NN(Population,HidNum,Data)
%data  n*m
Data=Data';
for index=1:size(Population,1)
    Individual=Population(index,:); 
    Num=length(Individual)/HidNum;
    for i=1:Num-1
        I2H_Matrix(i,:)=Individual((i-1)*HidNum+1 :i*HidNum);
    end
    
    H2O_matrix=Individual((Num-1)*HidNum+1:Num*HidNum)';
    
    H_input=Data*I2H_Matrix;
    
    H_out= sigmod(H_input);
    
    Output(index,:)=(H_out*H2O_matrix)';
 
end
end
 
 
 
function f=sigmod(Input)
 
f=1./(1+exp(-(Input)));
 
 
end
