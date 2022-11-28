function [kneepoint,distance,r,t,R] = F_kneepoint(functionvalue,frontvalue,maxfront,r,t,rate)
%��ǰ����ѡ��kneepoint
    R=[];%������Լ��ӵ�,��Ϊԭ���Ĵ����У�Rֻ�ڵ�һ���������һ��ֵ�ĵ��ʱ��Żᱻ��ֵ����˻ᵼ�³����������
    [N,M]=size(functionvalue);

    kneepoint=false(1,N);
    distance=zeros(1,N);
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
            %�������ط�Ҳ���ˣ�������ԭ���Ĵ���
%             if i==1
%                 R = maxjuli;
%             end
            
            if isempty(R)
                R = maxjuli;
            end
            %����Χѡ������ŵĸ�����Ϊ�ο���
            [~,rank]=sort(distance(temp),'descend');
            choose=zeros(1,length(rank));
            canchoose=ones(1,length(rank));
            for j=rank
                if canchoose(j)
                    for k=1:length(temp)     
                        if abs(functionvalue(temp(j),:)-functionvalue(temp(k),:))<=maxjuli
                            canchoose(k)=0;
                        end
                    end
                    choose(j)=1;
                end
            end
            t(i)=sum(choose)/length(temp);
            choose(rank(find(choose(rank)==1,1,'last')))=0;
            kneepoint(temp(choose==1))=1;
        end
    end
end

