%�������ݼ�(����֮����������Ͷ�������*������ʽ)
%1��australian��14,307:383��
% 2:transfusion��4,178:570��
% 3:magic(10,12332:6688)
% 4:Ionosphere��34��225��126��
% 5:sonarall��60��111��97��
% 6:pima-indians-diabetes(8,268:500)
% 7:musk1(166,207:269)
% 8:musk2(166,1017:5581)
% 9:madelon��500��1000��1000��
%13��Hill_Valley_without_noise_full(100,612:600)
%14��Hill_Valley_with_noise_full(100,606:606)
%12:skin��3��50859��194198��
%13��a1a��123��7841��24720��
%14:a2a��123��7841��24720��
%15:w1a��300��1479��48270��
%17:Wine(13,178)
%18:Zoo(17,101)
%19:Parkinsons(22,195)
%20:German(24,1000)
%21:Wbcd(30,569)
%22:Spectf(44,267)
%23:Lung Cancer(56,32)
%24:Libras(90,360)
%25:Hillvalley������ѡ��ר�ã�������������ظ�������Ϊ�˱��ֶԱȣ���Ȼ��ӣ�(100,606)
%26:Voice(310,126)

function [dataset,whether,datasetName]=inputdataset(i)
%˵������������������������ȡ��Ӧ�����ݼ�����������ݼ���Ӧ����
%���룺i:����Ҫ��ȡ�����ݼ������
%�����dataset:      ��ȡ�����ݣ�����*��������
%      whether:      ��ȡ�������ݱ�ǩ����ǩ*��������
%      datasetName:  ���ݼ�������



switch i
    case 1
        %����ausralian���ݼ�
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,whether] =textread('E:\dataset\australian.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f');
        whether=whether';
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14];
        dataset=dataset';
        datasetName = 'ausralian';
        % end
        
    case 2
        %����transfusion���ݼ�
        % function [dataset,whether]=inputdataset()
        [Recency,Frequency,Monetary,Time,whether]=textread('E:\dataset\transfusion.txt','%f%f%f%f%f','delimiter', ',');
        dataset=[Recency,Frequency,Monetary,Time];
        dataset=dataset';
        whether=whether';
        datasetName = 'transfusion';
        % end
        
    case 3
        %����magic�����ݼ�
        % function [dataset,whether]=inputdataset()
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,whethertemp] =textread('E:\dataset\magic.txt','%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
        whethertemp=whethertemp';
        % whether=str2num(char(whethertemp));
        % a=size(whethertemp);
        
        whether=zeros(1,size(whethertemp,2));
        for i=1:size(whethertemp,2)
            if whethertemp{i}=='g'
                whether(i)=1;
            else
                whether(i)=0;
            end
        end
        
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10];
        dataset=dataset';
        datasetName = 'magic';
        % end
        
    case 4
        % %����Ionosphere�����ݼ�,g����good,b����bad,��ˣ�g��ֵΪ1��b��ֵΪ0
        % function [dataset,whether]=inputdataset()
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,whethertemp] =textread('E:\dataset\ionosphere.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
        whethertemp=whethertemp';
        % whether=str2num(char(whethertemp));
        % a=size(whethertemp);
        
        whether=zeros(1,size(whethertemp,2));
        for i=1:size(whethertemp,2)
            if whethertemp{i}=='g'
                whether(i)=1;
            else
                whether(i)=0;
            end
        end
        
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34];
        dataset=dataset';
        datasetName = 'Ionosphere';
        % end
        
        
        
        %ģ��
        % function [dataset,whether]=inputdataset()
        % [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,A58,A59,A60,A61,A62,A63,A64,A65,A66,A67,A68,A69,A70,A71,A72,A73,A74,A75,A76,A77,A78,A79,A80,A81,A82,A83,A84,A85,A86,A87,A88,A89,A90,A91,A92,A93,A94,A95,A96,A97,A98,A99,A100,A101,A102,A103,A104,A105,A106,A107,A108,A109,A110,whethertemp] =textread('F:\dataset\sonarmines.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
        % whethertemp=whethertemp';
        % % whether=str2num(char(whethertemp));
        % % a=size(whethertemp);
        %
        % whether=zeros(1,size(whethertemp,2));
        % for i=1:size(whethertemp,2)
        %     if whethertemp{i}=='M'
        %         whether(i)=1;
        %     else
        %         whether(i)=0;
        %     end
        % end
        %
        % dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,A58,A59,A60,A61,A62,A63,A64,A65,A66,A67,A68,A69,A70,A71,A72,A73,A74,A75,A76,A77,A78,A79,A80,A81,A82,A83,A84,A85,A86,A87,A88,A89,A90,A91,A92,A93,A94,A95,A96,A97,A98,A99,A100,A101,A102,A103,A104,A105,A106,A107,A108,A109,A110];
        % dataset=dataset';
        % end
        
    case 5
        %����sonarall�����ݼ�,R��Ϊ0��M��Ϊ1
        % function [dataset,whether]=inputdataset()
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,A58,A59,A60,whethertemp] =textread('E:\dataset\sonarall.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','delimiter', ',');
        whethertemp=whethertemp';
        % whether=str2num(char(whethertemp));
        % a=size(whethertemp);
        
        whether=zeros(1,size(whethertemp,2));
        for i=1:size(whethertemp,2)
            if whethertemp{i}=='M'
                whether(i)=1;
            else
                whether(i)=0;
            end
        end
        
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,A58,A59,A60];
        dataset=dataset';
        datasetName = 'sonarall';
        % end
        
        
    case 6
        %����pima-indians-diabetes.data���ݼ�
        % function [dataset,whethertemp]=inputdataset()
        [A1,A2,A3,A4,A5,A6,A7,A8,whether] =textread('E:\dataset\pimaindiansdiabetesdata.txt','%f%f%f%f%f%f%f%f%f','delimiter', ',');
        whether=whether';
        % whether=str2num(char(whethertemp));
        % a=size(whethertemp);
        
        % whether=zeros(1,size(whethertemp,2));
        % for i=1:size(whethertemp,2)
        %     if whethertemp{i}=='M'
        %         whether(i)=1;
        %     else
        %         whether(i)=0;
        %     end
        % end
        
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8];
        dataset=dataset';
        datasetName = 'pima-indians-diabetes';
        
    case 7
        %����musk1���ݼ�
        fid = fopen('E:\dataset\musk1\clean1\clean1.data','r');
        juzhen=textscan(fid,'%*s%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        %         datasettemp=textscan(fid,'%s',167,'delimiter', ',');
        %textscan(fid,'%*s %*s','delimiter', ',');
        %xs = fscanf(fid, '%f', [476 167])��
        fclose(fid);
        datasetName = 'musk1';
        
    case 8
        %����musk2���ݼ�
        fid = fopen('E:\dataset\musk1\clean2\clean2.data','r');
        juzhen=textscan(fid,'%*s%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        %         datasettemp=textscan(fid,'%s',167,'delimiter', ',');
        %textscan(fid,'%*s %*s','delimiter', ',');
        %xs = fscanf(fid, '%f', [476 167])��
        fclose(fid);
        datasetName = 'musk2';
        
    case 9
        %����madelon���ݼ�
        fid = fopen('E:\dataset\madelon\madelon_train.data','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        dataset=cell2mat(juzhen);
        dataset=dataset';
        fclose(fid);
        
        fid = fopen('E:\dataset\madelon\madelon_train.labels','r');
        whethertemp=textscan(fid,'%f','delimiter', ',');
        whether=cell2mat(whethertemp);
        whether=whether';
        %��whether���д�����-1��Ϊ0
        whether(find(whether==-1))=0;
        fclose(fid);
        datasetName = 'madelon';
        
    case 10
        %����Hill_Valley_without_noise_full���ݿ�
        fid = fopen('E:\dataset\hillvalley\Hill_Valley_without_noise_full.data','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2):size(dataset,2));
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        whether=whether';
        fclose(fid);
        datasetName = 'Hill_Valley_without_noise_full';
        
    case 11
        %����Hill_Valley_with_noise_full���ݿ�
        fid = fopen('E:\dataset\hillvalley\Hill_Valley_with_noise_full.data','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2):size(dataset,2));
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        whether=whether';
        fclose(fid);
        datasetName = 'Hill_Valley_with_noise_full';
        
%     case 12
%         %����skin���ݼ�
%         fid = fopen('E:\dataset\skin\skin.data','r');
%         juzhen=textscan(fid,'%f%f%f%f','delimiter', ',');
%         dataset=cell2mat(juzhen);
%         whether=dataset(:,size(dataset,2):size(dataset,2));
%         %�����ݽ��г���������2��Ϊ0��Ϊ��ǩ
%         whether(find(whether==2))=0;
%         dataset=dataset(:,1:size(dataset,2)-1);
%         dataset=dataset';
%         whether=whether';
%         fclose(fid);
%         datasetName = 'skin';
        
    case 12
        %����a1a���ݼ�
        dataset=load('E:\dataset\a1a\a1adata.mat');
        whether=load('E:\dataset\a1a\a1awhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
        datasetName = 'a1a';
        
    case 13
        %����a2a���ݼ�
        dataset=load('E:\dataset\a2a\a2adata.mat');
        whether=load('E:\dataset\a2a\a2awhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
        datasetName = 'a2a';
        
    case 14
        %����w1a���ݼ�
        dataset=load('E:\dataset\w1a\w1adata.mat');
        whether=load('E:\dataset\w1a\w1awhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
        datasetName = 'w1a';
        
    case 15
        %����mushrooms���ݼ�
        dataset=load('E:\dataset\mushrooms\mushroomsdata.mat');
        whether=load('E:\dataset\mushrooms\mushroomswhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
        datasetName = 'mushrooms';
        
        
    %%%%    
    case 16
        %����Wine���ݼ�,������
        fid = fopen('E:\dataset\xxs\1wine3.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        %         datasettemp=textscan(fid,'%s',167,'delimiter', ',');
        %textscan(fid,'%*s %*s','delimiter', ',');
        %xs = fscanf(fid, '%f', [476 167])��
        fclose(fid);
        datasetName = 'Wine';
        
    case 17
        %����Zoo���ݼ�
        fid = fopen('E:\dataset\xxs\3Zoo7.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        %         datasettemp=textscan(fid,'%s',167,'delimiter', ',');
        %textscan(fid,'%*s %*s','delimiter', ',');
        %xs = fscanf(fid, '%f', [476 167])��
        fclose(fid);
        datasetName = 'Zoo';
        
    case 18
        %����Parkinsons���ݼ�
        fid = fopen('E:\dataset\xxs\V5 Parkinsons.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Parkinsons';
        
    case 19
        %����German���ݼ�
        fid = fopen('E:\dataset\xxs\5German2.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        whether(whether==(-1)) = 0;
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'German';
        
    case 20
        %����Wbcd���ݼ�
        fid = fopen('E:\dataset\xxs\6World breast cancer-Diagnostic2.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Wbcd';
        
    case 21
        %����Spectf���ݼ�
        fid = fopen('E:\dataset\xxs\V6 Spectf.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        fclose(fid);
        datasetName = 'Spectf';
        
    case 22
        %����Lung Cancer���ݼ�
        fid = fopen('E:\dataset\xxs\8Lung cancer3.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        %         datasettemp=textscan(fid,'%s',167,'delimiter', ',');
        %textscan(fid,'%*s %*s','delimiter', ',');
        %xs = fscanf(fid, '%f', [476 167])��
        fclose(fid);
        datasetName = 'Lung Cancer';
        
    case 23
        %����Libras���ݼ�
        fid = fopen('E:\dataset\xxs\V3 Libras.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        %         datasettemp=textscan(fid,'%s',167,'delimiter', ',');
        %textscan(fid,'%*s %*s','delimiter', ',');
        %xs = fscanf(fid, '%f', [476 167])��
        fclose(fid);
        datasetName = 'Libras';
        
%     case 25
%         %����Hillvalley���ݼ�
%         fid = fopen('E:\dataset\xxs\9HillValey2.txt','r');
%         juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
%         
%         dataset=cell2mat(juzhen);
%         whether=dataset(:,size(dataset,2));
%         whether=whether';
%         dataset=dataset(:,1:size(dataset,2)-1);
%         dataset=dataset';
%         fclose(fid);
%         datasetName = 'Hillvalley';
        
    case 24
        %����Voice���ݼ�
        fid = fopen('E:\dataset\xxs\V4 Voice.txt','r');
        juzhen=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter', ',');
        
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2));
        whether=whether';
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        %         datasettemp=textscan(fid,'%s',167,'delimiter', ',');
        %textscan(fid,'%*s %*s','delimiter', ',');
        %xs = fscanf(fid, '%f', [476 167])��
        fclose(fid);
        datasetName = 'Voice';
        

end




