function k = motion_penalty(W1, W2)
%
% k = motion_penalty(Wk, Wkm1)
% 
% W = Current window [x, y, w, h]
% Wkm1 = detected window in previous frame [x, y, w, h]
% k = motion penalty (scalar)

% Compute centroids of windows
o1 = [W1(1) + W1(3)/2; W1(2) + W1(4)/2];
o2 = [W2(1) + W2(3)/2; W2(2) + W2(4)/2];

% Get height and width from the vectors
h1 = W1(4); h2 = W2(4);
w1 = W1(3); w2 = W2(3);

k = norm(o1 - o2) + abs(h1 - h2) + abs(w1 - w2) + ...
    max(abs(h1/w1 - h2/w2), abs(w1/h1 - w2/h2));