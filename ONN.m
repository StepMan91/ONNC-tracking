clear all; 
close all;
clc;

%% Load the images
imPath = 'Sequences/car'; imExt = 'jpg';

% check if directory and files exist
if isdir(imPath) == 0
    error('USER ERROR : The image directory does not exist');
end

filearray = dir([imPath filesep '*.' imExt]); % get all files in the directory
NumImages = size(filearray,1); % get the number of images
if NumImages < 0
    error('No image in the directory');
end

disp('Loading image files from the video sequence, please be patient...');
% Get image parameters
imgname = [imPath filesep filearray(1).name]; % get image name
I = imread(imgname);
VIDEO_WIDTH = size(I,2);
VIDEO_HEIGHT = size(I,1);

if(size(I,3)==3)
    ImSeq = zeros(VIDEO_HEIGHT, VIDEO_WIDTH, NumImages, 3);
else
    ImSeq = zeros(VIDEO_HEIGHT, VIDEO_WIDTH, NumImages);
end
for i=1:NumImages
    imgname = [imPath filesep filearray(i).name]; % get image name
    if(size(I,3)==3)
        ImSeq(:,:,i,:) = imread(imgname); % load image
    else
        ImSeq(:,:,i) = imread(imgname);
    end
end
disp(' ... OK!');

%% Read the image, and extract sift 
% I = single(rgb2gray(imread('img009.bmp')));
imshow(I, []);

% Use functions from http://www.vlfeat.org/ toolbox
[F, D] = vl_sift(single(I)); %Extract sift detectors and descriptors
vl_plotsiftdescriptor(D, F); %Plot descriptors in the image

%%Build set of keypoints
for i = 1:size(F,2)
    V(i).x = F(:,i);
    V(i).v = D(:,i);
end

%%Extract keypoints in a window
[~,win0] = imcrop; %Select a window
[Theta, B] = sift_in_window(win0, V); %Select keypoints in the window 
O_0 = Theta;
% Visualize keypoints in the window
figure;
imshow(I, []);
hold on;
rectangle('Position', win0, 'EdgeColor','r');
% [Dw, Fw] = split_set(Theta);
% vl_plotsiftdescriptor(Dw, Fw);

%% Step 1 : Find Motion Model (Wk)
mu_max = 0;
Wkm1 = win0;
Wk = Wkm1;
Okm1 = O_0;
for k = 2:NumImages 
    
    %Get Sift detector and descriptor in full image
    [F, D] = vl_sift(single(ImSeq(:,:,k)));

    %%Build set of keypoints
    for i = 1:size(F,2)
        Vk(i).x = F(:,i);
        Vk(i).v = D(:,i);
    end

    %Window search
    for i = -5:5
        disp(i);
        for j = -5:5
            win = [Wkm1(1)+i,Wkm1(2)+j,Wkm1(3),Wkm1(4)];
            mu = motion_score(win, Okm1, B, Wkm1, Vk);
            disp(mu);
            if(mu > mu_max)
               mu_max = mu;
               Wk = win;
            end
        end
    end
    Wkm1 = Wk;
    
    figure(3);
    imshow(ImSeq(:,:,k),[]);
    hold on;
    rectangle('Position', win0, 'EdgeColor','r');
    rectangle('Position', Wk, 'EdgeColor', 'b');

%% Step 2 : Apply Ratio Test to current Features
    
    [Theta, ~] = sift_in_window(Wk, Vk); 
    Fl = filter_operator(Theta, Okm1, B);

%% Step 3 : Find Appearance Object Model (Ok)
    
%     [v_Okm1, ~] = split_set(Okm1);
%     [v_Fl, ~] = split_set(Fl);
%     matches = vl_ubcmatch(v_Okm1, v_Fl);
    Ok = or_set(Okm1, Fl);
    pause;
    
end