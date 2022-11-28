function pareto=chra(position,dianshu,fanwei)
% 返回的是pareto层的点在position中的序号
% clc
% clear all
% 
% dianshu=8;
% fanwei=10;
% 
% position=rand(dianshu,2)*fanwei;

% ConvexHull=JarvisAlgorithm(position,dianshu,fanwei);%凸包点的坐标

%直接调用matlab凸包函数来做
if(size(position,1)<3)
    ConvexHull=position;
else
    try
        ConvexHull=convhull(position(:,1),position(:,2));
        ConvexHull=position(ConvexHull,:);
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

% ConvexHull(size(ConvexHull,1),:)=[];%因为pareto面中最开始和结束的点会有重复，因此，需要将最后一个点删除掉，防止对pareto面的产生过程产生干扰
% tempposition=position(ConvexHull,:);
ConvexHull(1,:)=[];
tempposition=ConvexHull;



[~,leftmost]=min(tempposition(:,1));%最左边的点
% [~,downmost]=min(tempposition(:,2));%最下边的点
[~,upmost]=max(tempposition(:,2));%最上面的点

%确定一个点是否同时最左和最下的点
[allleftmost,~]=find(tempposition(leftmost,1)==tempposition(:,1));%找出所有的x坐标是最小的点
% [alldownmost,~]=find(tempposition(downmost,2)==tempposition(:,2));%找出所有的y坐标是最小的点
[allupmost,~]=find(tempposition(upmost,2)==tempposition(:,2));%找出所有的y坐标是最大的点

allleftmost=tempposition(allleftmost,:);
% alldownmost=tempposition(alldownmost,:);
allupmost=tempposition(allupmost,:);

[~,leftmostup]=max(allleftmost(:,2));%最左上边的
% [~,downmostleft]=min(alldownmost(:,1));
[~,upmostleft]=min(allupmost(:,1));%最上边的点中最右边的

% leftmostup=allleftmost(leftmostup,:);
% downmostleft=alldownmost(downmostleft,:);

leftmostup=allleftmost(leftmostup,:);
upmostleft=allupmost(upmostleft,:);

leftmost=findindex(tempposition,leftmostup);
upmost=findindex(tempposition,upmostleft);

% [~,leftmost]=min(tempposition(alldownmost,1));%再从所有最下面的点中找出最左边的点
% [~,downmost]=min(tempposition(alldownmost,1));%再从所有最左边的点中找出最下面的点




if(leftmost==upmost)
    pareto(1)=leftmost;
else
% [downmosty,downmost]=min(tempposition(:,2));
% 
% [leftmostx2,leftmost2]=min(position(:,1));
% [downmosty2,downmost2]=min(position(:,2));

%生成pareto面的时候第一个点必须是最下并且最左的点



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
pareto=ConvexHull(pareto,:);%将tempposition中点的序号转换为position中的序号
% figure(1)
% plot(position(:,1),position(:,2),'.k');
% hold on
% plot(position(ConvexHull,1),position(ConvexHull,2),'*-');
% set(gcf,'Name','初始点集');
% title('初始点集','fontsize',16);
% xlabel('X');
% ylabel('Y');
% axis([-1 fanwei+1 -1 fanwei+1]);

% figure(1)
% plot(position(:,1),position(:,2),'.k');
% set(gcf,'Name','初始点集');
% title('初始点集','fontsize',16);
% xlabel('X');
% ylabel('Y');
% axis([-1 10 -1 10]);
% 
% 
% figure(2)
% plot(position(ConvexHull,1),position(ConvexHull,2),'*-');
% set(gcf,'Name','凸包');
% title('凸包','fontsize',16);
% xlabel('X');
% ylabel('Y');
% axis([-1 10 -1 10]);
% 
% figure(2)
% plot(tempposition(pareto,1),tempposition(pareto,2),'*-');
% set(gcf,'Name','pareto层');
% title('pareto层','fontsize',16);
% xlabel('X');
% ylabel('Y');
% axis([-1 fanwei+1 -1 fanwei+1]);

% figure(2)
% plot(position(pareto,1),position(pareto,2),'*-');
% set(gcf,'Name','pareto层');
% title('pareto层','fontsize',16);
% xlabel('X');
% ylabel('Y');
% axis([-1 fanwei+1 -1 fanwei+1]);



