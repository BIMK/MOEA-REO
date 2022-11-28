clc
clear all

datapath='Ionosphere\';%储存的文件夹路径
for popnum=100:100
    for rate=0.5:0.5  
        for datasetnumber=4:4
            switch datasetnumber
                case 1
                    name='ausralian';
                case 2
                    name='transfusion';
                case 3
                    name='magic';
                case 4
                    name='Ionosphere';
                case 5
                    name='sonarall';
                case 6
                    name='pima-indians-diabetes';
                case 7
                    name='musk1';
                case 8
                    name='musk2';
                case 9
                    name='madelon';
                case 10
                    name='Hill_Valley_without_noise_full';
                case 11
                    name='Hill_Valley_with_noise_full';
                case 12
                    name='skin';
                case 13
                    name='a1a';
                case 14
                    name='a2a';
                case 15
                    name='w1a';
                case 16
                    name='mushrooms';
            end
            
            
            dirpath=[datapath,'popnum=',num2str(popnum),'\','rate=',num2str(rate),'\',name];
            mkdir(dirpath);
        end
    end
end
fprintf('complete\n');