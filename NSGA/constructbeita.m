function beita=constructbeita(number)
% number=10;
%��������£���������Ħµ�ά�����number��һά����Ϊ�У�0,1����һ���Ǻ�����ӵ�
    interval=1/number;
    beita1=[];
    beita2=[];
    source=0;
    for i=1:number+1
        beita1=[beita1;source];
        source=source+interval;
    end
    beita2=1-beita1;
    beita=[beita1,beita2];
    
end