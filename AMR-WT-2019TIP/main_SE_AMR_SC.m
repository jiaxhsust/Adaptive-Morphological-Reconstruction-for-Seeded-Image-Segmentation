%Please cite the paper "Tao Lei, Xiaohong Jia,Tongliang Liu,Shigang Liu,Hongying Meng,and Asoke K. Nandi, 
%Adaptive Morphological Reconstruction for Seeded Image Segmentation,
%IEEE Transactions on Image Processing, vol.28, no.11, pp.5510-5523, Nov. 2019."

%The code was written by Tao Lei and Xiaohong Jia in 2018.

%%% Welcome to our Research Group website:https://aimv.sust.edu.cn/lwcg.htm
clear all
close all
addpath('.\SC\');
f_ori=imread('.\Images\3063.jpg');
g=load('.\SE_grad\3063.mat');
%% step3 generate superpixels
r_g=w_recons_adaptive(g.E,3);
L=watershed(r_g);
L_seg=Label_image(f_ori,L,2,[255,0,0]);
figure,imshow(L_seg);
%%
c_mean=feature_extract(f_ori,L);
f_mean=rgb2lab(c_mean);
f_l=normalized(f_mean(:,:,1));f_a=normalized(f_mean(:,:,2));f_b=normalized(f_mean(:,:,3));
%%
cs4=[f_l';f_a';f_b']';
cluster_n=5;
IDX=Spectral_cluster_JW(cs4,cluster_n);
L2=imdilate(L,strel('square',2));
Lr2=zeros(size(L,1),size(L,2));
for i=1:max(L(:))
    Lr2=Lr2+(L2==i)*IDX(i);
end
xx=sgrad_edge(Lr2);LL=watershed(xx);
L_seg2=Label_image(f_ori,LL,2,[255,0,0]);
figure,imshow(L_seg2);