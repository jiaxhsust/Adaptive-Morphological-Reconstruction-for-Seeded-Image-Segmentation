
function [fs2,center_p]=Label_image(f,L,lineWidth,color) 
%f_c2=Label_image_WT(g,f_c,1,[255,255,255]);
%fs is the result of segmentation, center_p is the center pixel of each
%areas
% f is the original image
% s2 is the segmented image using waterhsed transformation
f=double(f);
num_area=max(max(L)); %The number of segmented areas
if size(f,3)<2 
[M,N]=size(f);
s3=L;
fs=zeros(M,N);
center_p=zeros(num_area,1); 
for i=1:num_area
f2=f(s3==i);f_med=median(f2);fx=double((s3==i))*double(f_med);
fs=fs+fx;
center_p(i,:)=uint8(f_med);
end
%% add parameters to control the color and shape of segmented line
if lineWidth==1
    fs2=fs;
else
fs2=imerode(fs,strel('square',lineWidth));
end
%% end
fsr=fs;fsg=fs;fsb=fs;
fsr(fs2==0)=color(1);fsg(fs2==0)=color(2);fsb(fs2==0)=color(3);
fs2=cat(3,fsr,fsg,fsb);
fs2=uint8(fs2);
%% Color image
else  
[M,N]=size(f(:,:,1));
s3=L;
fs=zeros(M,N,3);
fr=f(:,:,1);fg=f(:,:,2);fb=f(:,:,3);
center_p=zeros(num_area,3); 
for i=1:num_area
fr2=fr(s3==i);r_med=median(fr2);r=(s3==i)*r_med;
fg2=fg(s3==i);g_med=median(fg2);g=(s3==i)*g_med;
fb2=fb(s3==i);b_med=median(fb2);b=(s3==i)*b_med;
fs=fs+cat(3,r,g,b);
center_p(i,:)=uint8([r_med g_med b_med]);
end
%% add parameters to control the color and shape of segmented line
if lineWidth==1
    fs2=fs;
else
fs2=imerode(fs,strel('square',lineWidth));
end
%% end
fs_r=fs2(:,:,1);fs_g=fs2(:,:,2);fs_b=fs2(:,:,3);
fs_r(fs_r==0)=color(1);fs_g(fs_g==0)=color(2);fs_b(fs_b==0)=color(3);
fs2=cat(3,fs_r,fs_g,fs_b);
fs2=uint8(fs2);
end
