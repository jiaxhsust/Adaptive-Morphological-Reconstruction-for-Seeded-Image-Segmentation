%Please cite the paper "Tao Lei, Xiaohong Jia,Tongliang Liu,Shigang Liu,Hongying Meng,and Asoke K. Nandi, 
%Adaptive Morphological Reconstruction for Seeded Image Segmentation,
%IEEE Transactions on Image Processing, vol.28, no.11, pp.5510-5523, Nov. 2019."

%The code was written by Tao Lei and Xiaohong Jia in 2018.

%%% Welcome to our Research Group website:https://aimv.sust.edu.cn/lwcg.htm
clear all
close all
addpath('.\code\');
f_ori=imread('.\Images\12003.jpg'); 
% Note that you can repeat the program for several times to obtain the best
% segmentation result for image '12003.jpg'
%% you can choose a simple filter, e.g., a gaussian filter.
%sigma=1.0;gausFilter=fspecial('gaussian',[5 5],sigma);g=imfilter(f_ori,gausFilter,'replicate');
%% compute gradient image
gg=rgb2lab(f_ori); 
tic
a1=sgrad_edge(normalized(gg(:,:,1))).^2;b1=sgrad_edge(abs(normalized(gg(:,:,2)))).^2;c1=sgrad_edge(normalized(gg(:,:,3))).^2;
ngrad_f1=sqrt(a1+b1+c1); 
%% image segmentation using AMR-WT
r_g=w_recons_adaptive(ngrad_f1,3); % AMR
L=watershed(r_g);
toc
L_seg=Label_image_fast(f_ori,L,2,[255,0,0]);
figure,imshow(L_seg);