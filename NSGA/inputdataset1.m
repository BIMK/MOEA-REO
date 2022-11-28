function [dataset,whether,datasetName]=inputdataset(i)
switch i
    case 1
[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,whethertemp] =textread('C:\Users\Mr.Simple\Desktop\poker1.txt','%f%f%f%f%f%f%f%f%f%f%s','delimiter', ' ');
        whethertemp=whethertemp';
        whether=zeros(1,size(whethertemp,2));
        for i=1:size(whethertemp,2)
            if whethertemp{i}=='6'
                whether(i)=1;
            else
                whether(i)=0;
            end
        end
        
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10];
        dataset=dataset';
       % datasetName = '';
end