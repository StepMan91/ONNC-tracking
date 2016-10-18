clear all; 
close all;
clc;

%% Online nearest neighbor
I = single(rgb2gray(imread('img009.bmp')));
imshow(I, []);

% Use functions from http://www.vlfeat.org/ toolbox
[F, D] = vl_sift(I);
vl_plotsiftdescriptor(D, F);