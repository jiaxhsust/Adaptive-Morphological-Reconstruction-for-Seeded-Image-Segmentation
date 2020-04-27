%feature extraction
function [c_mean,c_var]=feature_extract(f_ori,L)
%v_mean denotes the area mean value for color
%v_var denotes the area variance for color

%f_ori is the original image
%L is the lable image
if nargin~=2
    error('too many or few input parameters')
end
dim=length(size(f_ori));
f_ori=double(f_ori)+0.01;
len=max(L(:)); %the number of area
if dim>2 %COLOR
    fr=f_ori(:,:,1);fg=f_ori(:,:,2);fb=f_ori(:,:,3);
    v_mean=zeros(len,3);v_var=v_mean;
    %L2=imdilate(L,strel('square',2));
    for i=1:len
        Lr=(L==i).*fr;Lg=(L==i).*fg;Lb=(L==i).*fb;
        v_mean(i,:)=[mean2(Lr(Lr>0)-0.01) mean2(Lg(Lg>0)-0.01) mean2(Lb(Lb>0)-0.01)];
        v_var(i,:)=[std2(Lr(Lr>0)-0.01) std2(Lg(Lg>0)-0.01) std2(Lb(Lb>0)-0.01)];
    end
    cr=v_mean(:,1);cg=v_mean(:,2);cb=v_mean(:,3);
    c_mean=cat(3,cr,cg,cb);
    vr=v_var(:,1);vg=v_var(:,2);vb=v_var(:,3);
    c_var=cat(3,vr,vg,vb);
else  %grayscale
    v_mean=zeros(len,1);v_var=v_mean;
    for j=1:len
        L_ori=(L==j).*f_ori;
        v_mean(j)=mean2(L_ori(L_ori>0)-0.01);
        v_var(j)=std2(L_ori(L_ori>0)-0.01);
    end
    c_mean=v_mean;c_var=v_var;
end