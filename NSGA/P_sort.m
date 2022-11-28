function [frontvalue,maxfront] = P_sort(functionvalue,operation)
% ■P_sort 对种群进行非支配排序,返回排序结果
%          这里采用的是改进的deductive sort方法,较之fast non-dominated sort效率大幅提升
%          适用于对最小化问题的种群进行排序
%
% 输入:
%       ■functionvalue: 二维矩阵.待排序的种群的目标函数值,其中每一行对应一个个体,每一列对应一维函数值
%       ■operation:     字符串.指定种群中待排序的个体,含义如下:
%                        1.'all',排序所有的个体.若不输入参数operation,默认取此值
%                        2.'half',只排序前一半前沿面中的个体,为基于非支配排序的算法所常用.未排序的个体的前沿面编号均为inf
%                        3.'first',只排序第一个前沿面中的个体,用于找出非支配个体.未排序的个体的前沿面编号均为inf
% 输出:
%       ■frontvalue:    一维向量.排序后的个体所在的前沿面的编号(越小越好),其中每一位对应一个个体的前沿面编号
%       ■maxfront:      数值.排序后的最大前沿面编号(除inf)

    if nargin<2
        kinds=1;
    elseif strcmp(operation,'half')
        kinds=2;
    elseif strcmp(operation,'first')
        kinds=3;
    else
        kinds=1;
    end
	[popnum,funlength]=size(functionvalue);
    fnum=0;
    cz=zeros(1,popnum);
    frontvalue=zeros(1,popnum)+inf;
    [functionvalue,rank]=sortrows(functionvalue);
    while (kinds==1 && sum(cz)<popnum) || (kinds==2 && sum(cz)<popnum/2) || (kinds==3 && fnum<1)
        fnum=fnum+1;
        d=cz;
        for i=1:popnum
            if ~d(i)
                for j=i+1:popnum
                    if ~d(j)
                        k=1;
                        for m=2:funlength
                            if functionvalue(i,m)>functionvalue(j,m)%★★★★为了classification改动了
                                k=0;
                                break
                            end
                        end
                        if k==1
                            d(j)=1;
                        end
                    end
                end
                frontvalue(rank(i))=fnum;
                cz(i)=1;
            end
        end
    end
    maxfront=fnum;
end


