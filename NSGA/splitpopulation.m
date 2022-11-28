function [U,R]=splitpopulation(Q)
U=Q;
redundancy=[];%´¢´æÈßÓàµãµÄÐòºÅ
unredundancy=[];%´¢´æ·ÇÈßÓàµãµÄÐòºÅ
for i=1:size(Q,1)
    for j=i+1:size(Q,1)
        if(Q(i,:)==Q(j,:))
            redundancy=[redundancy;j];
        end
        
    end
end
redundancy=unique(redundancy,'rows');

R=Q(redundancy,:);
U(redundancy,:)=[];
end