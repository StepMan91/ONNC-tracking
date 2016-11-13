function [D, F] = split_set(O)

for i = 1:length(O)
    F(:,i) = O(i).x;
    if(~isempty(O(i).v))
        D(:,i) = O(i).v;
    end   
end