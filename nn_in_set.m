function u = nn_in_set(v, set)
%
% u = nn_in_set(v, set)
%
% v = descritor vector of a feature [d*1]
% set = Set of features [d*n]
% u = nearest neighbor of v in the set [d*1]

min = 1000;
for i = 1:length(set)
    diff = norm(double(set(i).v - v));
    if(diff < min)
        min = diff;
        u = set(i).v;
    end
end