function pareto= flip_operator_one(Population,confidencelevel,whethertrain,datasettrain)

%重新计算分类结果
evaluation  =Population*datasettrain*10^(-3);
evaluation(find(evaluation>=confidencelevel))  =  1;
evaluation(find(evaluation<confidencelevel))  =  0;
A=[];%在Evaluation函数中，未使用变量A，只是不想修改函数文件，又想执行，随便定义一个变量传进去
[tpr,fpr]=Evaluation(evaluation,whethertrain,A ,datasettrain,confidencelevel);
pareto=[fpr tpr];
%计算凸包
CH=chraarea(pareto);
CH=sortrows(CH);

position=[];%存放凸包中的点在pareto之中的位置
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




%计算各点到凸包的距离
%若凸包有N个点，则有N-1个区间
dis=[];%存放距离，和区间，第一列是距离，第二列表示这个点在第几区间
for i=1:size(CH,1)-1
    %获得端点值
    y1=CH(i,2);
    x1=CH(i,1);
    y2=CH(i+1,2);
    x2=CH(i+1,1);
    %计算直线k和b
    k=(y2-y1)/(x2-x1);
    b=y1-k*x1;
    %保证每个点计算且只计算一次距离
    label=zeros(1,size(pareto,1));
    for j=1:size(pareto,1)
        if(pareto(j,1)>=x1 && pareto(j,1)<=x2&&label(j)~=1)
            d=abs(-k*pareto(j,1)+pareto(j,2)-b)/sqrt(k^2+1);%计算距离
            dis=[dis;d i];%存放
            label(j)=1;
        end
    end
end

%翻转
dis=sortrows(dis);%对距离排序
duan=dis(end,2);%获得距离最大的点所在的段号
%获得段端点值
fpr1=CH(duan,1);
tpr1=CH(duan,2);
fpr2=CH(duan+1,1);
tpr2=CH(duan+1,2);
for i=1:size(pareto,1)
    if(pareto(i,1)>=fpr1&&pareto(i,1)<=fpr2)
        for p=1:size(evaluation,2)%更改每一个标签的值
            if( evaluation(position(duan),p)==evaluation(position(duan+1),p) )%如果端点的结果相同,将区间内的点也改为相同结果
                evaluation(i,p)=evaluation(position(duan),p);
            elseif(evaluation(position(duan),p)==0&&evaluation(position(duan+1),p)==1)%若前一个结果为负类，后一个为正类，翻转区间内点的结果
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