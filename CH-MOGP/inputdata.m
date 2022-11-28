function [N,datasetsource1,whether1]=inputdata(i)
switch(i)
    case 1
        fid = fopen('E:\multidata\wine.data','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ','); 
        N=3;
    case 2
         fid = fopen('E:\multidata\balance.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f','delimiter', ','); 
        N=3;
    case 3
        fid = fopen('E:\multidata\ecoli.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f','delimiter', ','); 
        N=5;
    case 4
        fid = fopen('E:\multidata\newabalone.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f','delimiter', ','); 
        N=3;
    case 5
        fid = fopen('E:\multidata\newglass.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f','delimiter', ','); 
        N=6;
    case 6
        fid = fopen('E:\multidata\newsegment1.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ','); 
        N=3;
    case 7
        fid = fopen('E:\multidata\newyeast.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f','delimiter', ','); 
        N=4;
    case 8
        fid = fopen('E:\multidata\satimage.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ','); 
        N=6;
    case 9
        fid = fopen('E:\multidata\satimage1.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ','); 
        N=5;
end
        datasetsource1=cell2mat(juzhen);
        whether1=datasetsource1(:,end);
        whether1=whether1';
        datasetsource1=datasetsource1(:,1:end-1);
        datasetsource1=datasetsource1';
         fclose(fid);
