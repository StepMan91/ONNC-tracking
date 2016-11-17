function mu = motion_score(W, Okm1, B, Wkm1, Ik)
%
% mu = motion_score(W, Okm1, B, Wkm1, Ik)
%
% W = current window [x, y, w, h]
% Okm1 = previous object model [struct with feature coordinates (x) and
% descriptors (v)]
% B = Background model
% Wkm1 = detected Window in the previous frame
% Ik = current frame
% 
% mu = score

[F, D] = vl_sift(Ik);

%%Build set of keypoints
for i = 1:size(F,2)
    V(i).x = F(:,i);
    V(i).v = D(:,i);
end

%Select keypoints in the window 
[Theta, ~] = sift_in_window(win, V); 

% Compute the filter 
Fl = filter_operator(Theta, Okm1, B);

for i = 1:size(Fl,2)
   if(F(:,i) ~= 0)%Check sign of column of F (maybe sum)
       sum_sign = sum_sign + 1;
   else
       sum_sign = sum_sign - 1;
   end
end

mu = sum_sign - motion_penalty(W, Wkm1);


