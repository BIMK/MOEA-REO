%������
function Main()
clc;format short;addpath public;
    
    %�㷨����
    Algorithm = {'MOEAD'};
    %��������
    Problem = {'ZDT1'};
    %����ά��
    Objectives = 2;

    %��������
    Start(Algorithm,Problem,Objectives);
end