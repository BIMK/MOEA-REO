function [kneepoint,area,r,t,R]=two(functionvalue,frontvalue,maxfront,r,t,rate)
%��kmeans����Ӧ�õ�kneepoint�����У�������֮��������Ϊ���۵�����ȼ���׼����Ҫ����ROC����ά�Ƚ�
    [N,M]=size(functionvalue);
    R=[];
    kneepoint=false(1,N);
    area=zeros(1,N);
    %��ǰ���������ҳ������е�kneepoint
    for i=1:maxfront
        temp=find(frontvalue==i);                           %��ǰǰ����ĸ���
        if length(temp)<=M                                  %���㲻����ȫѡΪkneepoint
            kneepoint(temp)=1;
        else
            %�ҳ��߽��
            [~,rank]=sort(functionvalue(temp,:),'descend');
            extreme=zeros(1,M);                             %��������߽����,�߽�����Ŀ��Ŀ��ά����ͬ
            extreme(1)=rank(1,1);                           %��һάֵ���ĸ���
            for j=2:length(extreme)                         %�ֱ�Ѱ�Һ���ÿһάֵ���ĸ���
                k=1;
                extreme(j)=rank(k,j);
                while ismember(extreme(j),extreme(1:j-1))   %����ǰάֵ���ĸ�����֮ǰ��ѡ���ı߽����ͬ,��ȡ�δ�ֵ,ֱ����ͬ
                    k=k+1;
                    extreme(j)=rank(k,j);
                end
            end
            %�����ɱ߽�㹹�ɵ���,���ƽ���һ��ʽ���̵�ϵ��
            hyperplane=functionvalue(temp(extreme),:)\ones(length(extreme),1);
            %ȷ��ÿ����(����)����,���ƽ��ľ���ֵ(����Խ��Խ��)
            distance(temp)=-(functionvalue(temp,:)*hyperplane-1)./sqrt(sum(hyperplane.^2));
            %�����ھӷ�Χ
            fmax=max(functionvalue(temp,:),[],1);
            fmin=min(functionvalue(temp,:),[],1);
            if t(i)==-1
                r(i)=1;
            else
                r(i)=r(i)/exp((1-t(i)/rate)/M);
            end
            maxjuli=(fmax-fmin).*r(i);
            if i == 1
                R = maxjuli;
            end
            %����Χѡ������ŵĸ�����Ϊ�ο���
            sortnumber=ceil(1/r(i));
            if sortnumber>size(functionvalue(temp,:),1)
               sortnumber=size(functionvalue(temp,:),1);%��Ϊĳ�����⣬����sortnumber����functionvalue�ĸ���
            end
            rank=kmeans(functionvalue(temp,:),sortnumber,'MaxIter',1000);
            for sorti=1:sortnumber
                dotnumber=temp(find(rank==sorti));%��Ӧ��ĳһ����ĳһ������ĵ�ļ���
                [~,tempdot]=max(distance(dotnumber));
                tempdot=dotnumber(tempdot);
                kneepoint(tempdot)=1;
            end
            
            t(i)=sortnumber/length(temp);%kennpointռ�ܵĵ�ı���
        end
    end
end