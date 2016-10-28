close all
clear all
clc

%% Loading images
imPath = '../sequence/car'; imExt = 'jpg';
ImSeq = loadImages(imPath, imExt);
[h, w, NumImages] = size(ImSeq);


%% Initializing BB
% [patch, rect] = imcrop(ImSeq(:,:,1)./255);
rect = [193.5100  119.5100   96.9800   52.9800];
rect = round(rect);
x1 = rect(1); x2 = x1 + rect(3);
y1 = rect(2); y2 = y1 + rect(4);
patch = mat2gray(ImSeq(y1:y2, x1:x2, 1));

%% Initializing SURF features
I = mat2gray(ImSeq(:,:,1));
points = detectSURFFeatures(I);
[AllFeatures, valid_points_all] = extractFeatures(I, points);

Th_points = points((points.Location(:,1) < x2) & (points.Location(:,1) > x1) & (points.Location(:,2) < y2) & (points.Location(:,2) > y1));
[Theta_features, valid_points_Theta] = extractFeatures(I, Th_points);

B_points = points((points.Location(:,1) > x2 | points.Location(:,1) < x1) | (points.Location(:,2) > y2 | points.Location(:,2) < y1));
[B_features, valid_points_B] = extractFeatures(I, B_points);

O_prev = Theta_features; %Initialize Object model
W_prev = rect;
% figure; 
% subplot(1,3,1); imshow(I, []); hold on;plot(valid_points_all,'showOrientation',true);
% subplot(1,3,2);imshow(I, []); hold on;plot(valid_points_Theta,'showOrientation',true);
% subplot(1,3,3); imshow(I, []); hold on;plot(valid_points_B,'showOrientation',true);
% hold on;
% plot([rect(1), rect(1) + rect(3)], [rect(2), rect(2)], 'r');
% plot([rect(1), rect(1)], [rect(2), rect(2)+rect(4)], 'r');
% plot([rect(1) + rect(3), rect(1) + rect(3)], [rect(2), rect(2)+rect(4)], 'r');
% plot([rect(1), rect(1) + rect(3)], [rect(2)+rect(4), rect(2)+rect(4)], 'r');
% hold off;

%%
for i = 2 : 2% NumImages
    I = ImSeq(:,:,i);
    
%     W = 
%     
%     %extract SURF features
%     points = detectSURFFeatures(I);
%     [features, valid_points] = extractFeatures(I, points);
%     
end
% figure; imshow(I); hold on;
% plot(valid_points.selectStrongest(10),'showOrientation',true);