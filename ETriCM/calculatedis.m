function distance=calculatedis(dottemp,M)
[~,rank]=sort(dottemp,'descend');
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
hyperplane=dottemp(extreme,:)\ones(length(extreme),1);
%ȷ��ÿ����(����)����,���ƽ��ľ���ֵ(����Խ��Խ��)
distance=-(dottemp*hyperplane-1)./sqrt(sum(hyperplane.^2));
end