function index=findindex(a,b)
    for i=1:size(a,1)
        if(a(i,:)==b)
        index=i;
        return;
        end
    end
end