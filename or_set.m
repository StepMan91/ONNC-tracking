function set_m = or_set(set1, set2)
%
% set_m = or_set(set1, set2)
% Apply or operator on two different set

% set1, set2 = set of keypoints with coordinates x and descriptors v
% set_m = Result of the or operator on the sets

    % get the descriptors outside the structure
    [v_set1, ~] = split_set(set1);
    [v_set2, ~] = split_set(set2);
    % get the matched descriptors in order to not have no dublicates
    matches = vl_ubcmatch(v_set1, v_set2);

    % Add all descriptors of the first set if they are not empty
    j = 0;
    for i = 1:length(set1)
        if(~isempty(set1(i).v))
            j = j + 1;
            set_m(j).x = set1(i).x;
            set_m(j).v = set1(i).v;
        end
    end
    
    % Add all descriptors of the second set except the matched descriptors
    for i = 1:length(set2)
        if((~isempty(set2(i).v)) && (isempty(find(matches(2,:)==i, 1))))%Not inside matches)
            j = j + 1;
            set_m(j).x = set2(i).x;
            set_m(j).v = set2(i).v;
            disp(i);
        end
    end