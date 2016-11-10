function Fl = filter_operator(Theta, Okm1, B)
%
% F = filter_operator(Theta, Okm1, B)
%
% Theta = Set of Sift features in a window of the current frame
% Okm1 = Object model in the previous frame
% B = Background model

lambda = 2/3;
j = 0;
for i = 1:length(Theta)
    if(norm(v - nn_in_set(Okm1)) < lambda*norm(v - nn_in_set(B)))
        Fl(:,j) = Theta(i).v;
    end
end
