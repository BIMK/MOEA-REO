function pareto=chra(position,dianshu,fanwei)
% ���ص���pareto��ĵ���position�е����
% clc
% clear all
% 
% dianshu=8;
% fanwei=10;
% 
% position=rand(dianshu,2)*fanwei;

% ConvexHull=JarvisAlgorithm(position,dianshu,fanwei);%͹���������

%ֱ�ӵ���matlab͹����������
if(size(position,1)<3)
    ConvexHull=position;
else
    try
        ConvexHull=convhull(position(:,1),position(:,2));
        ConvexHull=position(ConvexHull,:);
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
% figure(1)
% plot(position(:,1),position(:,2),'r*');
% hold on;
% plot(ConvexHull(:,1),ConvexHull(:,2),'b-');



if(length(ConvexHull)==1||length(ConvexHull)==2)
    pareto=ConvexHull;
    return;
end

positiontemp=ConvexHull;
% 
% figure(1)
% plot(position(:,1),position(:,2), 'r*');
% hold on;
% plot(positiontemp(:,1),positiontemp(:,2),'b-');
% axis([0 1 0 1]);

% ConvexHull(size(ConvexHull,1),:)=[];%��Ϊpareto�����ʼ�ͽ����ĵ�����ظ�����ˣ���Ҫ�����һ����ɾ��������ֹ��pareto��Ĳ������̲�������
% tempposition=position(ConvexHull,:);
ConvexHull(1,:)=[];
tempposition=ConvexHull;



[~,leftmost]=min(tempposition(:,1));%����ߵĵ�
% [~,downmost]=min(tempposition(:,2));%���±ߵĵ�
[~,upmost]=max(tempposition(:,2));%������ĵ�

%ȷ��һ�����Ƿ�ͬʱ��������µĵ�
[allleftmost,~]=find(tempposition(leftmost,1)==tempposition(:,1));%�ҳ����е�x��������С�ĵ�
% [alldownmost,~]=find(tempposition(downmost,2)==tempposition(:,2));%�ҳ����е�y��������С�ĵ�
[allupmost,~]=find(tempposition(upmost,2)==tempposition(:,2));%�ҳ����е�y���������ĵ�

allleftmost=tempposition(allleftmost,:);
% alldownmost=tempposition(alldownmost,:);
allupmost=tempposition(allupmost,:);

[~,leftmostup]=max(allleftmost(:,2));%�����ϱߵ�
% [~,downmostleft]=min(alldownmost(:,1));
[~,upmostleft]=min(allupmost(:,1));%���ϱߵĵ������ұߵ�

% leftmostup=allleftmost(leftmostup,:);
% downmostleft=alldownmost(downmostleft,:);

leftmostup=allleftmost(leftmostup,:);
upmostleft=allupmost(upmostleft,:);

leftmost=findindex(tempposition,leftmostup);
upmost=findindex(tempposition,upmostleft);

% [~,leftmost]=min(tempposition(alldownmost,1));%�ٴ�����������ĵ����ҳ�����ߵĵ�
% [~,downmost]=min(tempposition(alldownmost,1));%�ٴ���������ߵĵ����ҳ�������ĵ�




if(leftmost==upmost)
    pareto(1)=leftmost;
else
% [downmosty,downmost]=min(tempposition(:,2));
% 
% [leftmostx2,leftmost2]=min(position(:,1));
% [downmosty2,downmost2]=min(position(:,2));

%����pareto���ʱ���һ������������²�������ĵ�



uptemp=upmost;
% downtemp=downmost;

i=1;
pareto(i)=uptemp;
uptemp=mod(uptemp,size(tempposition,1))+1;
% while(lefttemp<upmost)
while(uptemp~=leftmost)
%     if(~(zhipei(leftmost,lefttemp)))
%         i=i+1;
%         pareto(i)=lefttemp;
%         leftmost=lefttemp;
%     end
    i=i+1;
    pareto(i)=uptemp;
    uptemp=mod(uptemp,size(tempposition,1))+1;
end
i=i+1;
pareto(i)=uptemp;
end
pareto=ConvexHull(pareto,:);%��tempposition�е�����ת��Ϊposition�е����
% figure(1)
% plot(position(:,1),position(:,2),'.k');
% hold on
% plot(position(ConvexHull,1),position(ConvexHull,2),'*-');
% set(gcf,'Name','��ʼ�㼯');
% title('��ʼ�㼯','fontsize',16);
% xlabel('X');
% ylabel('Y');
% axis([-1 fanwei+1 -1 fanwei+1]);

% figure(1)
% plot(position(:,1),position(:,2),'.k');
% set(gcf,'Name','��ʼ�㼯');
% title('��ʼ�㼯','fontsize',16);
% xlabel('X');
% ylabel('Y');
% axis([-1 10 -1 10]);
% 
% 
% figure(2)
% plot(position(ConvexHull,1),position(ConvexHull,2),'*-');
% set(gcf,'Name','͹��');
% title('͹��','fontsize',16);
% xlabel('X');
% ylabel('Y');
% axis([-1 10 -1 10]);
% 
% figure(2)
% plot(tempposition(pareto,1),tempposition(pareto,2),'*-');
% set(gcf,'Name','pareto��');
% title('pareto��','fontsize',16);
% xlabel('X');
% ylabel('Y');
% axis([-1 fanwei+1 -1 fanwei+1]);

% figure(2)
% plot(position(pareto,1),position(pareto,2),'*-');
% set(gcf,'Name','pareto��');
% title('pareto��','fontsize',16);
% xlabel('X');
% ylabel('Y');
% axis([-1 fanwei+1 -1 fanwei+1]);



