function pareto= flip_operator_all(Population,confidencelevel,whethertrain,datasettrain)
%���¼��������
evaluation  =Population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))  =  1;
evaluation(find(evaluation<confidencelevel))  =  0;
A=[];%��Evaluation�����У�δʹ�ñ���A��ֻ�ǲ����޸ĺ����ļ�������ִ�У���㶨��һ����������ȥ
[tpr,fpr]=Evaluation(evaluation,whethertrain,A ,datasettrain,confidencelevel);
pareto=[fpr tpr];

%����͹��
CH=chraarea(pareto);
CH=sortrows(CH);


position=[];%���͹���еĵ���pareto֮�е�λ��
for i=1:size(CH,1)
    for j=1:size(pareto,1)
        mark=0;%�п��ܣ��кܶ���ͬ�ĵ㣬����һ����ǣ�ֻȡ��һ����
        if(CH(i,1)==pareto(j,1)&&CH(i,2)==pareto(j,2))%��ͬ�����
            position=[position j];
            mark=1;
        end
        if(mark==1)
            break;
        end
    end
end



%��ת
%��͹����N���㣬����N-1������
for i=1:size(CH,1)-1
%�������˵�ֵ
fpr1=CH(i,1);
tpr1=CH(i,2);
fpr2=CH(i+1,1);
tpr2=CH(i+1,2);
%��pareto�ϵĵ��������ڣ���ı�ֵ,����ÿ���㣬���ҽ���һ��
label=zeros(1,size(pareto,1));
for j=1:size(pareto,1)
    if(pareto(j,1)>=fpr1&&pareto(j,1)<=fpr2&&label(j)~=1)%�����������ڣ���δ��ת��
        for p=1:size(evaluation,2)%����ÿһ����ǩ��ֵ
            if( evaluation(position(i),p)==evaluation(position(i+1),p) )%����˵�Ľ����ͬ,�������ڵĵ�Ҳ��Ϊ��ͬ���
                evaluation(j,p)=evaluation(position(i),p);
            elseif(evaluation(position(i),p)==0&&evaluation(position(i+1),p)==1)%��ǰһ�����Ϊ���࣬��һ��Ϊ���࣬��ת�����ڵ�Ľ��
%                     if(evaluation(j,p)==1)
%                         evaluation(j,p)=0;
%                     else
%                         evaluation(j,p)=1;
%                     end
        pareto(j,1)=fpr1+fpr2-pareto(j,1);
        pareto(j,2)=tpr1+tpr2-pareto(j,2);
            end
%         pareto(j,1)=fpr1+fpr2-pareto(j,1);
%         pareto(j,2)=tpr1+tpr2-pareto(j,2);
        label(j)=1;
        end
    end
end
end

[tpr,fpr]=Evaluation(evaluation,whethertrain,A ,datasettrain,confidencelevel);%�Ը��ĺ�Ľ��������tpr��fpr
pareto=[fpr tpr];


pareto=sortrows(pareto);

end