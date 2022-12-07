function [dataset,whether,name] = LOADdata(s)
%LOADDATA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
        switch s

            case 28
                name = 'thyroid1';
                A = load('C:\Users\admin\Desktop\dataset\imbalance\thyroid1.csv');%%%�������ݼ�
%             case 2
%                 name = 'thyroid2';
%                 A = load('C:\Users\admin\Desktop\dataset\imbalance\thyroid2.csv');%%%�������ݼ�
            case 30
                name = 'ecoli3';
                S = load('C:\Users\admin\Desktop\dataset\imbalance\ecoli3.mat');%%%�������ݼ�
                A = S.A;
            case 3
                name = 'glass2';
                A = load('C:\Users\admin\Desktop\dataset\imbalance\glass2.csv');%%%�������ݼ�
            case 29
                name = 'glass6';
                A = load('C:\Users\admin\Desktop\dataset\imbalance\glass6.csv');%%%�������ݼ�
%             case 6
%                 name = 'segment0';
%                 A = load('C:\Users\admin\Desktop\dataset\imbalance\segment0.csv');%%%�������ݼ�
%             case 7
%                 name = 'yeast3';
%                 A = load('C:\Users\admin\Desktop\dataset\imbalance\yeast3.csv');%%%�������ݼ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%--extreme imbalance--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 5
                name = 'abalone19';
                A = load('C:\Users\admin\Desktop\dataset\imbalance\100\abalone19.csv');%%%�������ݼ�
            case 32
                name = 'kddcup';
                A = load('C:\Users\admin\Desktop\dataset\imbalance\100\kddcup-rootkit.csv');%%%�������ݼ�
            case 31
                name = 'poker';
                A = load('C:\Users\admin\Desktop\dataset\imbalance\100\poker.csv');%%%�������ݼ�
            case 8
                name = 'shuttle0';
                S = load('C:\Users\admin\Desktop\dataset\shuttle0.mat');%%%�������ݼ�
                A = S.A;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%--larger1--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 11
                name = 'letter';
                A = load('C:\Users\admin\Desktop\dataset\large\01\letter.csv');%%%�������ݼ�
            case 12
                name = 'page-block0';
                A = load('C:\Users\admin\Desktop\dataset\large\01\page-block0.csv');%%%�������ݼ�
            case 13
                name = 'penbased';
                A = load('C:\Users\admin\Desktop\dataset\large\01\penbased.csv');%%%�������ݼ�
            case 14
                name = 'magic';
                A = load('C:\Users\admin\Desktop\dataset\large\01\magic.csv');%%%�������ݼ�
            case 15
                name = 'coil2000';
                S = load('C:\Users\admin\Desktop\dataset\large\01\coil2000.mat');%%%�������ݼ�
                A = S.A;
%             case 16
%                 name = 'ring';
%                 A = load('C:\Users\admin\Desktop\dataset\large\ring.csv');%%%�������ݼ�
%             case 15
%                 name = 'twonorm';
%                 A = load('C:\Users\admin\Desktop\dataset\large\01\twonorm.csv');%%%�������ݼ�
            case 16
                name = 'HTRU2';
                A = load('C:\Users\admin\Desktop\dataset\large\01\HTRU2.csv');%%%�������ݼ�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%--larger2--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             case 31
%                 name = 'letter01';
%                 S = load('C:\Users\admin\Desktop\dataset\large\letter.mat');%%%�������ݼ�
%                 A = S.A;
%             case 32
%                 name = 'wilt';
%                 A = load('C:\Users\admin\Desktop\dataset\large\wilt.csv');%%%�������ݼ�
            case 33
                name = 'satimage';
                S = load('C:\Users\admin\Desktop\dataset\large\satimage.mat');%%%�������ݼ�
                A = S.A;
            case 34
                name = 'spambase';
                S = load('C:\Users\admin\Desktop\dataset\large\spambase.mat');%%%�������ݼ�
                A = S.A;
            case 35
                name = 'phishing';
                 S = load('C:\Users\admin\Desktop\dataset\large\phishing.mat');%%%�������ݼ�
                A = S.A;
            case 36
                name = 'splice0';
                S = load('C:\Users\admin\Desktop\dataset\large\splice0.mat');%%%�������ݼ�
                A = S.A;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%--original--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 21
               name = 'appendicitis';
               S = load('C:\Users\admin\Desktop\dataset\appendicitis.mat');%%%�������ݼ�
               A = S.A;
            case 22
                name='haberman'; 
                S = load('C:\Users\admin\Desktop\dataset\haberman.mat');%%%�������ݼ�
                A = S.A;
            case 23       
                name='liver-disorders';
                S = load('C:\Users\admin\Desktop\dataset\liver-disorders.mat');%%%�������ݼ�
                A = S.A;
            case 24
                name = 'fourclass';
                S = load('C:\Users\admin\Desktop\dataset\fourclass.mat');%%%�������ݼ�
                A = [full(S.instance) S.label];
            case 25 
                name = 'mammogra';
                S = load('C:\Users\admin\Desktop\dataset\mammogra.mat');%%%�������ݼ�
                A = S.A;

%             case 26
%                 name = 'breast';
%                 S = load('C:\Users\admin\Desktop\dataset\breast.mat');%%%�������ݼ�
%                 A = [full(S.Xtr) S.Ytr];
       
            case 26       
                name = 'heart';
                S = load('C:\Users\admin\Desktop\dataset\heart.mat');%%%�������ݼ�
                A = S.A;
                %        whether(find(whether==2))=0;%%��������ǩΪ%%��ע������ǩ���Էֱ棬����ʵ�����ж�Ӧ�����������Ƚ϶ࡣ

            case 27
                name = 'wisconsin';
                S = load('C:\Users\admin\Desktop\dataset\wisconsin.mat');%%%�������ݼ�
                A = S.A;
                %        whether(find(whether==2))=0;%%��������ǩΪ
                %        whether(find(whether==4))=1;%%��������ǩΪ
                
            case 101
                name = 'Half-kernel';
                S = load('C:\Users\admin\Desktop\dataset\Half-kernel-i.mat');%%%�������ݼ�
                A = S.A;
            case 102
                name = 'Full-Moon';
                S = load('C:\Users\admin\Desktop\dataset\Full-Moon.mat');%%%�������ݼ�
                A = S.A;
            case 103
                name = 'outlier';
                S = load('C:\Users\admin\Desktop\dataset\outlier-i.mat');%%%�������ݼ�
                A = S.A;
            case 104
                name = 'twospirals';
                S = load('C:\Users\admin\Desktop\dataset\twospirals-i.mat');%%%�������ݼ�
                A = S.A;
            case 107
                name = 'corners';
                S = load('C:\Users\admin\Desktop\dataset\corners-i.mat');%%%�������ݼ�
                A = S.A;


        end
                dataset = A(:,1:end-1)' ;%instance          %%��Ϊ������85����Ϊ������9822  ��������Ϊ586
                whether =  A(:,end)';%label
                whether(whether == -1) = 0;
                whether(whether == 2) = 0;
                whether(whether == 4) = 1;

                [whether,index] = sort(whether);
                dataset = dataset(:,index);
                
            
end

