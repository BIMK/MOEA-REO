function pareto= flip_operator_all(Population,confidencelevel,whethertrain,datasettrain)
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
        mark=0;%有可能，有很多相同的点，设置一个标记，只取第一个点
        if(CH(i,1)==pareto(j,1)&&CH(i,2)==pareto(j,2))%相同，存放
            position=[position j];
            mark=1;
        end
        if(mark==1)
            break;
        end
    end
end



%翻转
%若凸包有N个点，则有N-1个区间
for i=1:size(CH,1)-1
%获得区间端点值
fpr1=CH(i,1);
tpr1=CH(i,2);
fpr2=CH(i+1,1);
tpr2=CH(i+1,2);
%若pareto上的点在区间内，则改变值,并且每个点，翻且仅翻一次
label=zeros(1,size(pareto,1));
for j=1:size(pareto,1)
    if(pareto(j,1)>=fpr1&&pareto(j,1)<=fpr2&&label(j)~=1)%若点在区间内，且未翻转过
        for p=1:size(evaluation,2)%更改每一个标签的值
            if( evaluation(position(i),p)==evaluation(position(i+1),p) )%如果端点的结果相同,将区间内的点也改为相同结果
                evaluation(j,p)=evaluation(position(i),p);
            elseif(evaluation(position(i),p)==0&&evaluation(position(i+1),p)==1)%若前一个结果为负类，后一个为正类，翻转区间内点的结果
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

[tpr,fpr]=Evaluation(evaluation,whethertrain,A ,datasettrain,confidencelevel);%对更改后的结果，计算tpr，fpr
pareto=[fpr tpr];


pareto=sortrows(pareto);

end