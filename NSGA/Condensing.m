function [X_NC,Grabbag1]=Condensing(X_NE,K)

% ѹ�����ڷ�
% ����--
% X_NE : �������������
% K    : ������
% ���--
% X_NC : ����ѹ��������

% step1: ���ô洢��Store��Grabbag
N=size(X_NE,1);
% �����ȡһ����������һ������������Store��
index1=find(X_NE(:,end)==0);%find��A�����ؾ���A�з���Ԫ������λ�ã�find��A>5�����ؾ���A�д���5��Ԫ������λ��
index2=find(X_NE(:,end)==1);
Store=[X_NE(index1(1),:);X_NE(index2(1),:)];
index1(1)=[];
index2(1)=[];
Grabbag=[X_NE(index1,:);X_NE(index2,:)];
Grabbag1=Grabbag;%
% step2: ѭ��
m_before=1;                 % ���ڴ洢����ѭ��ǰStore�е�����
m_after=2;                  % ���ڴ洢����ѭ����ɺ�Store�е�����
while m_after>m_before      % ��������������Store��ʱֹͣѭ��
    m_before=m_after;
    for i=1:N-2
        % ����Store��������Grabbag�е����ݽ���1-��k-����
        y_KNN=KNN(Grabbag(i,1:end-1),Store,K);
        % ������֣�����Store��
        if (y_KNN~=Grabbag(i,end))
            Store=[Store;Grabbag(i,:)];
            Grabbag1(i,:)=0;
            m_after=m_after+1;
        end
    end
end
Grabbag1(all(Grabbag1==0,2),:)=[];
    
X_NC=Store;


