%�������ݼ�(����֮����������Ͷ�������*������ʽ)
%1��australian
% 2:transfusion
% 3:magic
% 4:Ionosphere
% 5:sonarall
% 6:pima-indians-diabetes
% 7:musk1
% 8:musk2
% 9:madelon
%10��Hill_Valley_without_noise_full
%11��Hill_Valley_with_noise_full
%12:skin
%13��a1a
%14:a2a
%15:w1a
%16:mushrooms
%:German��δ��ɣ�
%��WBCD��δ��ɣ�
%��lung-cancer��δ��ɣ�
function [dataset,whether]=inputdataset(i)
switch i
    case 1
        %����ausralian���ݼ�
        [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,whether] =textread('E:\dataset\australian.txt','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f');
        whether=whether';
        dataset=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14];
        dataset=dataset';
        % end
        
    case 2
        %����transfusion���ݼ�
        % function [dataset,whether]=inputdataset()
        [Recency,Frequency,Monetary,Time,whether]=textread('E:\dataset\transfusion.txt','%f%f%f%f%f','delimiter', ',');
        dataset=[Recency,Frequency,Monetary,Time];
        dataset=dataset';
        whether=whether';
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
        %��whether���д�������-1��Ϊ0
        whether(find(whether==-1))=0;
        
        fclose(fid);
        
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
        
        
    case 12
        %����skin���ݼ�
        fid = fopen('E:\dataset\skin\skin.data','r');
        juzhen=textscan(fid,'%f%f%f%f','delimiter', ',');  
        dataset=cell2mat(juzhen);
        whether=dataset(:,size(dataset,2):size(dataset,2));
        %�����ݽ��г�����������2��Ϊ0��Ϊ��ǩ
        whether(find(whether==2))=0;
        dataset=dataset(:,1:size(dataset,2)-1);
        dataset=dataset';
        whether=whether';
        fclose(fid);
        
    case 13
        %����a1a���ݼ�
        dataset=load('E:\dataset\a1a\a1adata.mat');
        whether=load('E:\dataset\a1a\a1awhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
        
    case 14
        %����a2a���ݼ�
        dataset=load('E:\dataset\a2a\a2adata.mat');
        whether=load('E:\dataset\a2a\a2awhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
        
    case 15
        %����w1a���ݼ�
        dataset=load('E:\dataset\w1a\w1adata.mat');
        whether=load('E:\dataset\w1a\w1awhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
        
        
    case 16
        %����mushrooms���ݼ�
        dataset=load('E:\dataset\mushrooms\mushroomsdata.mat');
        whether=load('E:\dataset\mushrooms\mushroomswhether.mat');
        dataset=(cell2mat(struct2cell(dataset)))';
        whether=(cell2mat(struct2cell(whether)))';
        
end



