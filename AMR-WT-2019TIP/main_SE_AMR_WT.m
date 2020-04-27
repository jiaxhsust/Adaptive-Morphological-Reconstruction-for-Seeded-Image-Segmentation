%Please cite the paper "Tao Lei, Xiaohong Jia,Tongliang Liu,Shigang Liu,Hongying Meng,and Asoke K. Nandi, 
%Adaptive Morphological Reconstruction for Seeded Image Segmentation,
%IEEE Transactions on Image Processing, vol.28, no.11, pp.5510-5523, Nov. 2019."

%The code was written by Tao Lei and Xiaohong Jia in 2018.

%%% Welcome to our Research Group website:https://aimv.sust.edu.cn/lwcg.htm
clear all
close all
addpath('.\code\');
f_ori=imread('.\Images\3063.jpg'); 
% Note that you can repeat the program for several times to obtain the best
% segmentation result for image '12003.jpg'
g=load('.\SE_grad\3063.mat');
tic
%% image segmentation using AMR-WT
r_g=w_recons_adaptive(g.E,3); % AMR
L=watershed(r_g);
toc
L_seg=Label_image_fast(f_ori,L,2,[255,0,0]);
figure,imshow(L_seg);