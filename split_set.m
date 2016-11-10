function [D, F] = split_set(O)

for i = 1:length(O)
    D(:,i) = O(i).v;
    F(:,i) = O(i).x;
end