function s = sampling(R, n)
% ѡ�������RΪ��¼���ϣ�nΪ��ȡ��������
% �㷨�ο���D. E. Knuth, TAOCP, vol.2, pp142�����иĶ�

% ��д����ʱ�õĲ�������
if ~nargin
R = 1 : 8;
 n = 4;
end

N = length(R);
t = 0;% ������ļ�¼����
m = 0;% ��ѡ�õļ�¼��

while 1
 U= rand;
 if (N-t)*U < n-m
m = m + 1;
s(m) = R(t+1);
% ���ѳ�ȡ���㹻�ļ�¼�����㷨��ֹ
if m >= n, break, end
 end
 t = t + 1;
end