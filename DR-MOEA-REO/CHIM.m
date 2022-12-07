function [pareto,A]=CHIM(position,range)
%�������position�����ص��ǵ�һ���pareto���ϵĵ��Լ���չ���ĵ㼯A
% clc
% clear all;
% 
% beitanumber=11;%������Ħµ�ά��
% dimension=2;
% number=2;
% range=1;
% 
% position=rand(number,dimension);

beitanumber=11;%������Ħµ�ά��
A=[];%��չ֮��ĵ㼯

%ֱ�ӵ���matlab͹����������
if(size(position,1)<3)
    ConvexHull=position;
else
    try
        ConvexHull=convhull(position(:,1),position(:,2));
        ConvexHull=position(ConvexHull,:); 
        
        %         ����͹��ͼ
        %         figure(1)
        %         plot(position(:,1),position(:,2),'.k');
        %         hold on;
        %         plot(ConvexHull(:,1),ConvexHull(:,2),'b-');
        
    catch
        %��������ĵ㶼��һ�����ϵĵ㣬convhull�޷�������ת��catch��������
        if position(:,1)==zeros(size(position,1),1)%�㼯����y����
            position=sortrows(position,2);%��yֵ��С�������򣬴�С����
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
    temp=chra(positiontemp,length(positiontemp(:,1)),range);%temp�д�����Ǹò�paretoǰ�����е������
    
end

pareto=temp;
%��ÿһ��pareto���������չ�㼯
%ʹ��ǰ������Ϊ��չ�ļ���
for i=1:size(temp,1)-1
    vl=temp(i,:);
    vr=temp(i+1,:);
    
    fbest=[min(vl(1),vr(1)),max(vl(2),vr(2))];%���F*������
    f1=vr;
    f2=vl;
    fai=[f1-fbest;f2-fbest];%f1��f2�ֱ���fbest����γɵľ���
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
    %�������ҳ�����������Ϊsȥ�������
    
    %tempfai=fai*beita/norm(fai*beita',2)-(s-fbest)/norm((s-fbest),2);
    minifai=inf;
    beitamin=[];
    %
    sbeita=[];
    for dotnumber=1:size(s,1)
        minifai=inf;
        beitabest=0;
        
        %ѡ����s(dotnumber)��Ӧ����fai��С�Ħ�
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
    
    %�ҳ�sbeita��beitanumber��ȵĸ���
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






