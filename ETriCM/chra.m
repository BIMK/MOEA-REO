function pareto=chra(position)
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
if(length(ConvexHull)==1||length(ConvexHull)==2)
    pareto=ConvexHull;
    return;
end

positiontemp=ConvexHull;
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
pareto=ConvexHull(pareto,:);%��tempposition�е�����ת��Ϊposition�е����