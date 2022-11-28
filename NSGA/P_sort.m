function [frontvalue,maxfront] = P_sort(functionvalue,operation)
% ��P_sort ����Ⱥ���з�֧������,����������
%          ������õ��ǸĽ���deductive sort����,��֮fast non-dominated sortЧ�ʴ������
%          �����ڶ���С���������Ⱥ��������
%
% ����:
%       ��functionvalue: ��ά����.���������Ⱥ��Ŀ�꺯��ֵ,����ÿһ�ж�Ӧһ������,ÿһ�ж�Ӧһά����ֵ
%       ��operation:     �ַ���.ָ����Ⱥ�д�����ĸ���,��������:
%                        1.'all',�������еĸ���.�����������operation,Ĭ��ȡ��ֵ
%                        2.'half',ֻ����ǰһ��ǰ�����еĸ���,Ϊ���ڷ�֧��������㷨������.δ����ĸ����ǰ�����ž�Ϊinf
%                        3.'first',ֻ�����һ��ǰ�����еĸ���,�����ҳ���֧�����.δ����ĸ����ǰ�����ž�Ϊinf
% ���:
%       ��frontvalue:    һά����.�����ĸ������ڵ�ǰ����ı��(ԽСԽ��),����ÿһλ��Ӧһ�������ǰ������
%       ��maxfront:      ��ֵ.���������ǰ������(��inf)

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
                            if functionvalue(i,m)>functionvalue(j,m)%�����Ϊ��classification�Ķ���
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


