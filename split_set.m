function [D, F] = split_set(O)
%
% [D, F] = split_set(O)
%
% O = structure with .v the list of descriptors and .x the list of
%     keypoints coordinates
% D = Array of descriptors
% F = Array of points coordinates

for i = 1:length(O)
    F(:,i) = O(i).x;
    if(~isempty(O(i).v))
        D(:,i) = O(i).v;
    end   
end