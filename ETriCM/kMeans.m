%% kMeans�ĺ��ĳ��򣬲��ϵ�������������
% function [ centroids ] = kMeans( dataSet, k,whether)
function [datset,lable,Distb] = kMeans( dataSet, k,whether,rate)
    [m,n] = size(dataSet);%m�����ݵ�������n������
    %��ʼ����������
    centroids = randCent(dataSet, k);
    subCenter = zeros(m,2);%��һ��m*2�ľ��󣬵�һ�д洢��𣬵ڶ��д洢����
    change = 1;%�ж��Ƿ�ı�
    while change == 1
        change = 0;
        %��ÿһ�����ݼ������
        for i = 1:m
            minDist = inf;%inf��ʾ�����
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
        %��k�����¾����������
        
        for j = 1:k
            sum1 = zeros(1,n);
            r = 0;%����
            for i = 1:m
                if subCenter(i,1) == j
                    sum1 = sum1 + dataSet(i,:);
                    r = r+1;
                end
            end
            centroids(j,:) = sum1./r;
        end
    end
 index1=find(subCenter(:,1)==1);%�ҳ����ڵ�һ�������
 index2=find(subCenter(:,1)==2);%�ҳ����ڵڶ��������
 zheng=dataSet(index1,:);%�ҳ����ڵ�һ�������
 fu=dataSet(index2,:);%�ҳ����ڵڶ��������
 lable1=whether(index1,:);%��һ��ı�ǩ
 lable2=whether(index2,:);%�ڶ���ı�ǩ
 lable1_number=size(lable1,1);%��һ���������Ŀ
 lable2_number=size(lable2,1);%�ڶ����������Ŀ
 %%

%���Ŷ�����
%һ���Ŷ�����
        index11=find(lable1(:,1)==1);
        index12=find(lable1(:,1)==0);
        a1=size(index11,1); 
        b1=size(index12,1); 
        if a1>b1
        Distb1=b1/(a1+b1);%�Ŷ�������
        else
         Distb1=a1/(a1+b1);%�Ŷ�������
        end
 %�����Ŷ�����
       index21=find(lable2(:,1)==1);
       index22=find(lable2(:,1)==0);
        a2=size(index21,1); 
        b2=size(index22,1); 
        if a2>b2
        Distb2=b2/(a2+b2);%�Ŷ�������
        else
         Distb2=a2/(a2+b2);%�Ŷ�������
        end
   %�Ŷ�����
        Distb=(Distb1+Distb2)/2;%�Ŷ�����
%%
%���ǩ
if (lable1_number>lable2_number) 
        index11=find(lable1(:,1)==1);
        index12=find(lable1(:,1)==0);
        a1=size(index11,1); %һ���е���������
        b1=size(index12,1); %һ���еĸ�������
         if a1>b1
     lable1=ones(lable1_number,1);
     lable2=zeros(lable2_number,1);
         else
     lable1=zeros(lable1_number,1);
     lable2=ones(lable2_number,1);
        end
else   %������Ŀ��

       index21=find(lable2(:,1)==1);
       index22=find(lable2(:,1)==0);
        a2=size(index21,1); %�����е���������
        b2=size(index22,1); %�����еĸ�������
         if a2>b2
     lable1=zeros(lable1_number,1);
     lable2=ones(lable2_number,1);
         else
       lable1=ones(lable1_number,1);
       lable2=zeros(lable2_number,1);
        end
end
 %%

 %�ҳ��������������������������ѡһ��
 distance1=subCenter(index1,2);
 distance2=subCenter(index2,2);
 [~,index3]=sort(distance1);
 [~,index4]=sort(distance2);
 mm=ceil(m*rate/2);%ÿһ��Ҫѡ��������Ŀ�� lable1_number�� lable2_number
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
 %����
 zheng1=zheng(index3,:);%��ĳһ�������������С������������
 fu1=fu(index4,:);%
 dateset1=zheng1(index33,:);%��ĳһ������ѡȡ����ѵ��
 dateset2=fu1(index44,:);
 %��ǩ
% whether1=lable1(1:mm,:);
% whether2=lable2(1:mm,:);
datset=[dateset1;dateset2];
lable=[whether1;whether2];
end
