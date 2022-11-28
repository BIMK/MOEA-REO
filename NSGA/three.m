function [kneepoint,distance,r,t,R]=three(functionvalue,frontvalue,maxfront,r,t,rate)
%��kmeans����Ӧ�õ�kneepoint�����У�ÿһ�������ж���������distance
[N,M]=size(functionvalue);
R=[];
kneepoint=false(1,N);
distance=zeros(1,N);
%��ǰ���������ҳ������е�kneepoint
for i=1:maxfront
    temp=find(frontvalue==i);                           %��ǰǰ����ĸ���
    if length(temp)<=M                                  %���㲻����ȫѡΪkneepoint
        kneepoint(temp)=1;
    else
        if t(i)==-1
            r(i)=1;
        else
            r(i)=r(i)/exp((1-t(i)/rate)/M);
        end
        sortnumber = 5;%ʵ��ֻ�۳�һ�����ʱ���㷨�Ľ��
%         sortnumber=ceil(1/r(i));
        if sortnumber>size(functionvalue(temp,:),1)
            sortnumber=size(functionvalue(temp,:),1);%��Ϊĳ�����⣬����sortnumber����functionvalue�ĸ���
        end
        if sortnumber<=0
            sortnumber=1;
        end
        %���ȶԸò��еĵ���о���
        %������ĳһ������
        try
            rand=kmeans(functionvalue(temp,:),sortnumber,'MaxIter',1000);
        catch
            rand(1:end)=1;
        end
        %�Ըò��е�ÿһ��������н���ѡȡkneePoint
        for sorti=1:sortnumber
            dotnumber=temp(find(rand==sorti));%��Ӧ��ĳһ����ĳһ������ĵ�ļ���
            dottemp=functionvalue(dotnumber,:);%�����������ȡ����
            if size(dottemp,1)==1
               distance(dotnumber)==0; 
            else
            distancetemp=calculatedis(dottemp,M);
            %��distance��ֵ����Ӧ��distance��
            for disi=1:size(distancetemp,1)
                distance(dotnumber(disi))=distancetemp(disi);
            end
            [~,tempdot]=max(distance(dotnumber));
            tempdot=dotnumber(tempdot);
            end
            kneepoint(dotnumber)=1;
        end
        t(i)=sortnumber/length(temp);%kennpointռ�ܵĵ�ı���
    end
end
end