% function F = filterNN(A, B, C, lambda)

%For each feature in A find NN in B
%And find distance to respective NN
[idx_B, dist_B] = knnsearch(B, A);
[idx_C, dist_C] = knnsearch(C, A);

%From A, extract features satisfying the filtering condition
filtered_idx = dist_B < lambda * dist_C;
F = A(filtered_idx,:);