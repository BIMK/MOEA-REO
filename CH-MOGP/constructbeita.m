function beita=constructbeita(number)
% number=10;
%用来构造β，构造出来的β的维数会比number多一维，因为有（0,1）这一对是后面添加的
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