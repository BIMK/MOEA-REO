function pareto= flip_operator_one(Population,confidencelevel,whethertrain,datasettrain)

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
        mark=0;
        if(CH(i,1)==pareto(j,1)&&CH(i,2)==pareto(j,2))
            position=[position j];
            mark=1;
        end
        if(mark==1)
            break;
        end
    end
end




%������㵽͹���ľ���
%��͹����N���㣬����N-1������
dis=[];%��ž��룬�����䣬��һ���Ǿ��룬�ڶ��б�ʾ������ڵڼ�����
for i=1:size(CH,1)-1
    %��ö˵�ֵ
    y1=CH(i,2);
    x1=CH(i,1);
    y2=CH(i+1,2);
    x2=CH(i+1,1);
    %����ֱ��k��b
    k=(y2-y1)/(x2-x1);
    b=y1-k*x1;
    %��֤ÿ���������ֻ����һ�ξ���
    label=zeros(1,size(pareto,1));
    for j=1:size(pareto,1)
        if(pareto(j,1)>=x1 && pareto(j,1)<=x2&&label(j)~=1)
            d=abs(-k*pareto(j,1)+pareto(j,2)-b)/sqrt(k^2+1);%�������
            dis=[dis;d i];%���
            label(j)=1;
        end
    end
end

%��ת
dis=sortrows(dis);%�Ծ�������
duan=dis(end,2);%��þ������ĵ����ڵĶκ�
%��öζ˵�ֵ
fpr1=CH(duan,1);
tpr1=CH(duan,2);
fpr2=CH(duan+1,1);
tpr2=CH(duan+1,2);
for i=1:size(pareto,1)
    if(pareto(i,1)>=fpr1&&pareto(i,1)<=fpr2)
        for p=1:size(evaluation,2)%����ÿһ����ǩ��ֵ
            if( evaluation(position(duan),p)==evaluation(position(duan+1),p) )%����˵�Ľ����ͬ,�������ڵĵ�Ҳ��Ϊ��ͬ���
                evaluation(i,p)=evaluation(position(duan),p);
            elseif(evaluation(position(duan),p)==0&&evaluation(position(duan+1),p)==1)%��ǰһ�����Ϊ���࣬��һ��Ϊ���࣬��ת�����ڵ�Ľ��
%                     if(evaluation(i,p)==1)
%                         evaluation(i,p)=0;
%                     else
%                         evaluation(i,p)=1;
%                     end
        pareto(i,1)=fpr1+fpr2-pareto(i,1);
        pareto(i,2)=tpr1+tpr2-pareto(i,2);
            end
        end
%         pareto(i,1)=fpr1+fpr2-pareto(i,1);
%         pareto(i,2)=tpr1+tpr2-pareto(i,2);
    end
end

[tpr,fpr]=Evaluation(evaluation,whethertrain,A ,datasettrain,confidencelevel);
pareto=[fpr tpr];




pareto=sortrows(pareto);
end