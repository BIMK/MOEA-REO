function Output=decoding_NN(Individual,HidNum,Data)
%data  n*m
Num=length(Individual)/HidNum;
for i=1:Num-1
    I2H_Matrix(i,:)=Individual((i-1)*HidNum+1 :i*HidNum);
end

H2O_matrix=Individual((Num-1)*HidNum+1:Num*HidNum);

H_input=Data*I2H_Matrix;

H_out= sigmod(H_input);

Output=H_out*H2O_matrix;
end



function f=sigmod(Input)

f=1/(1+exp(-(Input)));
 

end