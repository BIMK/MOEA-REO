%�������ݼ�(����֮����������Ͷ�������*������ʽ)

function [dataset,whether,datasetName]=inputdataset(i)
%˵������������������������ȡ��Ӧ�����ݼ�����������ݼ���Ӧ����
%���룺i:����Ҫ��ȡ�����ݼ������
%�����dataset:      ��ȡ�����ݣ�����*��������
%      whether:      ��ȡ�������ݱ�ǩ����ǩ*��������
%      datasetName:  ���ݼ�������



switch i
    case 1
        %����liver-disorders���ݼ�ѡ��libsvm  145������
        [whether,A1,A2,A3,A4,A5] =textread('C:\Users\Mr.Simple\Desktop\���������ݼ�\svm\liver-disorders.txt','%f%f%f%f%f%f');
        whether=whether';
        dataset=[A1,A2,A3,A4,A5];
        dataset=dataset';
        datasetName = 'liver-disorders';
        % end
        
    case 2
        %����svmguide1���ݼ�ѡ��libsvm  3089������
         [whether,A1,A2,A3,A4] =textread('C:\Users\Mr.Simple\Desktop\���������ݼ�\svm\svmguide1.txt','%f%f%f%f%f');
        whether=whether';
        dataset=[A1,A2,A3,A4];
        dataset=dataset';
        datasetName = 'svmguide1';
        % end
     case 3
        %����banknote authentication���ݼ�ѡ��uci  1372������
         [A1,A2,A3,A4,whether] =textread('C:\Users\Mr.Simple\Desktop\���������ݼ�\uci\banknote authentication.txt','%f%f%f%f%f','delimiter', ',');
        whether=whether';
        dataset=[A1,A2,A3,A4];
        dataset=dataset';
        datasetName = 'banknote authentication';
        % end 
      case 4
        %����Blood Transfusion Service Center���ݼ�ѡ��uci  %748������ 4������
       load('C:\Users\Mr.Simple\Desktop\���������ݼ�\uci\Blood Transfusion Service Center.mat');%%%�������ݼ�
       dataset =  A(:,1:4)' ;%instance Xtr          %%��Ϊ����������Ϊ������3186
       whether =  A(:,5)';%label Ytr
        %end
        case 5
        %����banknote authentication���ݼ�ѡ��uci  100������ 9������
         load('C:\Users\Mr.Simple\Desktop\���������ݼ�\uci\Fertility.mat');%%%�������ݼ�
       dataset =dataset';%instance Xtr          %%��Ϊ����������Ϊ������3186
       whether = label';%label Ytr
        datasetName = 'Fertility';
        
       
    case 6
        %����spambase�����ݼ�,���ݼ�ѡ��uci  %4601������ 57������
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,whethertemp] =textread('C:\Users\Mr.Simple\Desktop\���������ݼ�\uci\spambase.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        whether=whethertemp';
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57];
        dataset=dataset';
        datasetName = 'spambase';
        % end
        
        
end