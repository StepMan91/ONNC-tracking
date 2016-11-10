function [Theta, B] = sift_in_window(rect, set)
%
% function O = sift_in_window(rect, set)
%
% rect = [x y w h] features of the window
% set = set of features with coordinates and descriptors of the sift
% keypoints
% O = list of keypoints in the window

% Get the four corners of the window
x_min = rect(2);
x_max = rect(2) + rect(4);
y_min = rect(1);
y_max = rect(1) + rect(4);

% Check if keypoint in the window and keep it or not
j = 0;
n = 0;
for i = 1:length(set)
    if((set(i).x(2) > x_min) && (set(i).x(2)< x_max) && ...
       (set(i).x(1) > y_min) && (set(i).x(1) < y_max))
        j = j + 1;
        Theta(j).x = set(i).x;
        Theta(j).v = set(i).v;
    else
        n = n + 1;
        B(n).x = set(i).x;
        B(n).v = set(i).v;  
    end
end