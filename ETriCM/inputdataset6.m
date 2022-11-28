%导入数据集(处理之后的数据类型都是属性*样本形式)

function [dataset,whether,datasetName]=inputdataset(i)
%说明：函数根据输入的序号来读取相应的数据集，序号与数据集对应如上
%输入：i:所需要读取的数据集的序号
%输出：dataset:      读取的数据（属性*样本数）
%      whether:      读取出的数据标签（标签*样本数）
%      datasetName:  数据集的名称



switch i
    case 1
        %导入liver-disorders数据集选自libsvm  145个样本
        [whether,A1,A2,A3,A4,A5] =textread('C:\Users\Mr.Simple\Desktop\二分类数据集\svm\liver-disorders.txt','%f%f%f%f%f%f');
        whether=whether';
        dataset=[A1,A2,A3,A4,A5];
        dataset=dataset';
        datasetName = 'liver-disorders';
        % end
        
    case 2
        %导入svmguide1数据集选自libsvm  3089个样本
         [whether,A1,A2,A3,A4] =textread('C:\Users\Mr.Simple\Desktop\二分类数据集\svm\svmguide1.txt','%f%f%f%f%f');
        whether=whether';
        dataset=[A1,A2,A3,A4];
        dataset=dataset';
        datasetName = 'svmguide1';
        % end
     case 3
        %导入banknote authentication数据集选自uci  1372个样本
         [A1,A2,A3,A4,whether] =textread('C:\Users\Mr.Simple\Desktop\二分类数据集\uci\banknote authentication.txt','%f%f%f%f%f','delimiter', ',');
        whether=whether';
        dataset=[A1,A2,A3,A4];
        dataset=dataset';
        datasetName = 'banknote authentication';
        % end 
      case 4
        %导入Blood Transfusion Service Center数据集选自uci  %748个样本 4个特征
       load('C:\Users\Mr.Simple\Desktop\二分类数据集\uci\Blood Transfusion Service Center.mat');%%%导入数据集
       dataset =  A(:,1:4)' ;%instance Xtr          %%行为特征数，列为数据量3186
       whether =  A(:,5)';%label Ytr
        %end
        case 5
        %导入banknote authentication数据集选自uci  100个样本 9个特征
         load('C:\Users\Mr.Simple\Desktop\二分类数据集\uci\Fertility.mat');%%%导入数据集
       dataset =dataset';%instance Xtr          %%行为特征数，列为数据量3186
       whether = label';%label Ytr
        datasetName = 'Fertility';
        
       
    case 6
        %导入spambase的数据集,数据集选自uci  %4601个样本 57个特征
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,whethertemp] =textread('C:\Users\Mr.Simple\Desktop\二分类数据集\uci\spambase.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        whether=whethertemp';
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57];
        dataset=dataset';
        datasetName = 'spambase';
        % end
        
        
end