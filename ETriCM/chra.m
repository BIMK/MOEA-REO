function pareto=chra(position)
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
if(length(ConvexHull)==1||length(ConvexHull)==2)
    pareto=ConvexHull;
    return;
end

positiontemp=ConvexHull;
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

if(leftmost==upmost)
    pareto(1)=leftmost;
else

uptemp=upmost;
% downtemp=downmost;

i=1;
pareto(i)=uptemp;
uptemp=mod(uptemp,size(tempposition,1))+1;
% while(lefttemp<upmost)
while(uptemp~=leftmost)
    i=i+1;
    pareto(i)=uptemp;
    uptemp=mod(uptemp,size(tempposition,1))+1;
end
i=i+1;
pareto(i)=uptemp;
end
pareto=ConvexHull(pareto,:);%将tempposition中点的序号转换为position中的序号