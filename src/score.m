function mu = score(W, W_prev, O, B, I, Theta)

W = rect;
O = Theta_features;
B = B_features;

%Filter features in Theta
% Filt_feats = filterNN(Theta, O, B);

%Compute appearance similarity
ap_sim = 0;
for i = 1 : size(Theta, 1)
    f = filterNN(Theta(i,:), O, B);
    if isemtpy(f)
        ap_sim = ap_sim - 1;
    else
        ap_sim = ap_sim + 1;
    end
end

mu = ap_sim - motionPenalty(W, W_prev);

function K = motionPenalty(W1, W2)
%%Compute penalty function K

gamma = 0.1;

%Centroids of windows W1, W2
O1 = [W1(1) + W1(3)/2, W1(2) + W1(4)/2];
O2 = [W2(1) + W2(3)/2, W2(2) + W2(4)/2];

h1 = W1(4);
h2 = W2(4);
w1 = W1(3);
w2 = W2(3);

s = max([abs(h1/w1-h2/w2),abs(w1/h1-w2/h2)]);

K = gamma*(norm(O1-O2) + abs(h1-h2) + abs(w1-w2)+s);
