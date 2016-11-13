function Fl = filter_operator(Theta, Okm1, B)
%
% F = filter_operator(Theta, Okm1, B)
%
% Theta = Set of Sift features in a window of the current frame
% Okm1 = Object model in the previous frame
% B = Background model

lambda = 2/3;
for i = 1:length(Theta)
    v = Theta(i).v;
    if(norm(double(v - nn_in_set(v, Okm1))) < lambda*norm(double(v - nn_in_set(v, B))))
        Fl(i).v = v;

    else
        Fl(i).v = [];
    end
    Fl(i).x = Theta(i).x;
end
