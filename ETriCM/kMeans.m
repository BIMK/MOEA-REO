%% kMeans的核心程序，不断迭代求解聚类中心
% function [ centroids ] = kMeans( dataSet, k,whether)
function [datset,lable,Distb] = kMeans( dataSet, k,whether,rate)
    [m,n] = size(dataSet);%m是数据的行数，n是列数
    %初始化聚类中心
    centroids = randCent(dataSet, k);
    subCenter = zeros(m,2);%做一个m*2的矩阵，第一列存储类别，第二列存储距离
    change = 1;%判断是否改变
    while change == 1
        change = 0;
        %对每一组数据计算距离
        for i = 1:m
            minDist = inf;%inf表示无穷大
            minIndex = 0;
            for j = 1:k
                 dist= distence(dataSet(i,:), centroids(j,:));
                 if dist < minDist
                     minDist = dist;
                     minIndex = j;
                 end
            end
            if subCenter(i,1) ~= minIndex
                change = 1;
                subCenter(i,:)=[minIndex, minDist];
            end        
        end
        %对k类重新就算聚类中心
        
        for j = 1:k
            sum1 = zeros(1,n);
            r = 0;%数量
            for i = 1:m
                if subCenter(i,1) == j
                    sum1 = sum1 + dataSet(i,:);
                    r = r+1;
                end
            end
            centroids(j,:) = sum1./r;
        end
    end
 index1=find(subCenter(:,1)==1);%找出属于第一类的索引
 index2=find(subCenter(:,1)==2);%找出属于第二类的索引
 zheng=dataSet(index1,:);%找出属于第一类的样本
 fu=dataSet(index2,:);%找出属于第二类的样本
 lable1=whether(index1,:);%第一类的标签
 lable2=whether(index2,:);%第二类的标签
 lable1_number=size(lable1,1);%第一类的样本数目
 lable2_number=size(lable2,1);%第二类的样本数目
 %%

%求扰动步长
%一类扰动步长
        index11=find(lable1(:,1)==1);
        index12=find(lable1(:,1)==0);
        a1=size(index11,1); 
        b1=size(index12,1); 
        if a1>b1
        Distb1=b1/(a1+b1);%扰动步长；
        else
         Distb1=a1/(a1+b1);%扰动步长；
        end
 %二类扰动步长
       index21=find(lable2(:,1)==1);
       index22=find(lable2(:,1)==0);
        a2=size(index21,1); 
        b2=size(index22,1); 
        if a2>b2
        Distb2=b2/(a2+b2);%扰动步长；
        else
         Distb2=a2/(a2+b2);%扰动步长；
        end
   %扰动步长
        Distb=(Distb1+Distb2)/2;%扰动步长
%%
%求标签
if (lable1_number>lable2_number) 
        index11=find(lable1(:,1)==1);
        index12=find(lable1(:,1)==0);
        a1=size(index11,1); %一类中的正样本数
        b1=size(index12,1); %一类中的负样本数
         if a1>b1
     lable1=ones(lable1_number,1);
     lable2=zeros(lable2_number,1);
         else
     lable1=zeros(lable1_number,1);
     lable2=ones(lable2_number,1);
        end
else   %二类数目多

       index21=find(lable2(:,1)==1);
       index22=find(lable2(:,1)==0);
        a2=size(index21,1); %二类中的正样本数
        b2=size(index22,1); %二类中的负样本数
         if a2>b2
     lable1=zeros(lable1_number,1);
     lable2=ones(lable2_number,1);
         else
       lable1=ones(lable1_number,1);
       lable2=zeros(lable2_number,1);
        end
end
 %%

 %找出距离质心最近的样本。正负各选一半
 distance1=subCenter(index1,2);
 distance2=subCenter(index2,2);
 [~,index3]=sort(distance1);
 [~,index4]=sort(distance2);
 mm=ceil(m*rate/2);%每一类要选样本的数目， lable1_number， lable2_number
  if mm>lable1_number
      index33=index3;
      whether1=lable1;
  else
 index33=index3(1:mm,:);
 whether1=lable1(1:mm,:);
  end
  if mm>lable2_number
      index44=index4;
      whether2=lable2;
  else
 index44=index4(1:mm,:);
 whether2=lable2(1:mm,:);
  end
 %样本
 zheng1=zheng(index3,:);%对某一类样本按距离从小到大重新排序
 fu1=fu(index4,:);%
 dateset1=zheng1(index33,:);%对某一类样本选取用来训练
 dateset2=fu1(index44,:);
 %标签
% whether1=lable1(1:mm,:);
% whether2=lable2(1:mm,:);
datset=[dateset1;dateset2];
lable=[whether1;whether2];
end
