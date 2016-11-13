function mu = motion_score(W, Okm1, B, Wkm1, Vk)
%
% mu = motion_score(W, Okm1, B, Wkm1, Ik)
%
% W = current window [x, y, w, h]
% Okm1 = previous object model [struct with feature coordinates (x) and
% descriptors (v)]
% B = Background model
% Wkm1 = detected Window in the previous frame
% Vk = keypoints set in current frame
% 
% mu = score

% [F, D] = vl_sift(single(Ik));
% 
% %%Build set of keypoints
% for i = 1:size(F,2)
%     V(i).x = F(:,i);
%     V(i).v = D(:,i);
% end

%Select keypoints in the window 
[Theta, ~] = sift_in_window(W, Vk); 

% Compute the filter 
Fl = filter_operator(Theta, Okm1, B);

%Check if features pass the ratio test
sum_sign = 0;
for i = 1:size(Fl,2)
   if(isempty(Fl(i).v)) 
       sum_sign = sum_sign - 1;
   else
       sum_sign = sum_sign + 1;
   end
end

mu = sum_sign - motion_penalty(W, Wkm1);


