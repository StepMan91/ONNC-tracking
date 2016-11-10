clear all; 
close all;
clc;

%% Read the image, and extract sift 
I = single(rgb2gray(imread('img009.bmp')));
imshow(I, []);

% Use functions from http://www.vlfeat.org/ toolbox
[F, D] = vl_sift(I); %Extract sift detectors and descriptors
vl_plotsiftdescriptor(D, F); %Plot descriptors in the image

%%Build set of keypoints
for i = 1:size(F,2)
    V(i).x = F(:,i);
    V(i).v = D(:,i);
end

%% Extract keypoints in a window
[~,win] = imcrop; %Select a window
[Theta, B] = sift_in_window(win, V); %Select keypoints in the window 
[Dw, Fw] = split_set(Theta);

% Visualize keypoints in the window
figure;
imshow(I, []);
vl_plotsiftdescriptor(Dw, Fw);
