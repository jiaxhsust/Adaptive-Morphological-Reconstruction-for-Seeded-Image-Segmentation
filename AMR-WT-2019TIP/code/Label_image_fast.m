function [fs3,TT,center_lab]=Label_image_fast(f,L,lineWidth,color)
%fs is the result of segmentation, center_p is the center pixel of each
%areas
% f is the original image
% s2 is the segmented image using waterhsed transformation
Ori_L=L;
L=imdilate(L,strel('square',2));
while min(unique(L(:)))==0
    Local_Z=find(L==0);
    for i=1:size(Local_Z,1)
        [x,y]=ind2sub(size(L),Local_Z(i)); 
        Sub_Z=L(x-1:x+1,y-1:y+1);
        Sub_I=imdilate(Sub_Z,strel('square',2));
        L(Local_Z(i))=Sub_I(5);
    end
end
f=double(f);
num_area=max(max(L)); %The number of segmented areas
Num_p=zeros(num_area,1);
Alab = f;
fs=f;
pixel_idx = label2idx(L);
center_p=zeros(num_area,1);
N=size(unique(L(:)),1);
Ln = numel(L);
for k = 1:N
    idx = pixel_idx{k}; 
    center_p(k,1) = mean(Alab(idx));
    center_p(k,2) = mean(Alab(idx+Ln)); 
    center_p(k,3)= mean(Alab(idx+2*Ln)); 
    
    fs(idx) = mean(Alab(idx)); 
    fs(idx+Ln) = mean(Alab(idx+Ln)); 
    fs(idx+2*Ln) = mean(Alab(idx+2*Ln)); 
    Num_p(k)=size(idx,1);
end
fs=uint8(fs);
TT=center_p;
center_lab=rgb2lab(TT);

%% add parameters to control the color and shape of segmented line
fs2=imerode(Ori_L,strel('square',lineWidth));
fs_r=fs(:,:,1);fs_g=fs(:,:,2);fs_b=fs(:,:,3);
fs_r(fs2==0)=color(1);fs_g(fs2==0)=color(2);fs_b(fs2==0)=color(3);
fs3=cat(3,fs_r,fs_g,fs_b);
fs3=uint8(fs3);