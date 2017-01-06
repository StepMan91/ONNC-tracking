function u = nn_in_set(v, set, method)
%
% u = nn_in_set(v, set)
%
% v = descritor vector of a feature [d*1]
% set = Set of features [d*n]
% u = nearest neighbor of v in the set [d*1]

% Brut force method
if(strcmp(method,'brut'))
    min = 1000;
    for i = 1:length(set)
        diff = norm(double(set(i).v - v));
        if(diff < min)
            min = diff;
            u = set(i).v;
        end
    end
% Kd_tree method
elseif(strcmp(method,'kd'))
    [v_set, ~] = split_set(set);
    kdtree = vl_kdtreebuild(double(v_set));
    [index, ~] = vl_kdtreequery(kdtree, double(v_set), double(v));
    u = v_set(:,index);  
end