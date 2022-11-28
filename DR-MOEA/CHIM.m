function [pareto,A]=CHIM(position,range)
%输入的是position，返回的是第一层的pareto面上的点以及扩展出的点集A
% clc
% clear all;
% 
% beitanumber=11;%构造出的β的维数
% dimension=2;
% number=2;
% range=1;
% 
% position=rand(number,dimension);

beitanumber=11;%构造出的β的维数
A=[];%扩展之后的点集

%直接调用matlab凸包函数来做
if(size(position,1)<3)
    ConvexHull=position;
else
    try
        ConvexHull=convhull(position(:,1),position(:,2));
        ConvexHull=position(ConvexHull,:); 
        
        %         画出凸包图
        %         figure(1)
        %         plot(position(:,1),position(:,2),'.k');
        %         hold on;
        %         plot(ConvexHull(:,1),ConvexHull(:,2),'b-');
        
    catch
        %当所输入的点都是一条线上的点，convhull无法处理，跳转到catch中来处理
        if position(:,1)==zeros(size(position,1),1)%点集中在y轴上
            position=sortrows(position,2);%按y值大小进行排序，从小到大
        end
        if position(:,2)==zeros(size(position,1),1)
            position=sortrows(position,1);
        end
        pareto=position(size(position,1),:);
        return;
    end
end

positiontemp=position;

if(length(positiontemp(:,1))==1)
    dianji=positiontemp;
%     positiontemp=[];
    temp=positiontemp;
else
    temp=chra(positiontemp,length(positiontemp(:,1)),range);%temp中储存的是该层pareto前沿面中点的坐标
    
end

pareto=temp;
%对每一个pareto面求出其扩展点集
%使用前沿面作为扩展的集合
for i=1:size(temp,1)-1
    vl=temp(i,:);
    vr=temp(i+1,:);
    
    fbest=[min(vl(1),vr(1)),max(vl(2),vr(2))];%求出F*的坐标
    f1=vr;
    f2=vl;
    fai=[f1-fbest;f2-fbest];%f1和f2分别与fbest相减形成的矩阵Φ
    beita=constructbeita(beitanumber-1);
    
    minx=min(vl(1),vr(1));
    maxx=max(vl(1),vr(1));
    miny=min(vl(2),vr(2));
    maxy=max(vl(2),vr(2));
    %     site=find(maxx>position(:,1)>minx)
    s=position(find(position(:,1)>minx&position(:,1)<maxx),:);
    
    %     hello=find(maxx>position(:,1)>minx);
    %     [keyy,hello2]=find(maxy>position(:,2)>miny);
    
    s=s(find(s(:,2)>miny&s(:,2)<maxy),:);
    %下面是找出矩形区域作为s去参与计算
    
    %tempfai=fai*beita/norm(fai*beita',2)-(s-fbest)/norm((s-fbest),2);
    minifai=inf;
    beitamin=[];
    %
    sbeita=[];
    for dotnumber=1:size(s,1)
        minifai=inf;
        beitabest=0;
        
        %选出点s(dotnumber)对应的是fai最小的β
        for tempi=1:beitanumber
            
            tempbeita=fai(1,:)*beita(tempi,1)+fai(2,:)*beita(tempi,2);
            tempbeita=tempbeita/norm(tempbeita,2);
            tempsf=s(dotnumber,:)-fbest;
            tempsf=tempsf/norm(tempsf,2);
            tempbeita=tempbeita-tempsf;
            tempbeita=norm(tempbeita,2);
            
            if tempbeita<minifai
                minifai=tempbeita;
                beitabest=tempi;
            end
        end
        distancefordottoedge=abs(det([vr-vl;s(dotnumber,:)-vl]))/norm(vr-vl);
        sbeitatemp=[dotnumber,beitabest,distancefordottoedge];
        sbeita=[sbeita;sbeitatemp];
    end
    
    %找出sbeita中beitanumber相等的各行
    while(~isempty(sbeita))
        
        indextemp=find(sbeita(:,2)==sbeita(1,2));
        temptemp=sbeita(indextemp,:);
        sbeita(indextemp,:)=[];
        [~,indextemptemp]=min(temptemp(:,3));
        minidwithbeita=temptemp(indextemptemp,:);
        dottemp=[s(minidwithbeita(:,1),:),minidwithbeita(:,3)];
        A=[A;dottemp];
    end
    
end
end






