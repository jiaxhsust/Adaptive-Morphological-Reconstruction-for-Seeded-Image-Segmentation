%% Adaptive morphological reconstruction (AMR) for gradient images
% L_seg is lable image with line
% i is the maximal iterations
% diff is the difference between the previous result and current gradient
function f_g2=w_recons_adaptive(f,se_start, options)
% sto_con denotes end condition
%       OPTIONS(1): maximum number of iterations          (default: 30)
%       OPTIONS(3): minimum amount of improvement         (default: 1e-4)
if nargin ~= 2 & nargin ~= 3
    error('Too many or too few input arguments!');
end
% Change the following to set default options
default_options = [30;	% max. number of iteration
    1e-4];	% min. amount of improvement
if nargin == 2
    options = default_options;
    max_itr= default_options(1);
    min_impro= default_options(2);
else
    max_itr= options(1);
    min_impro=options(2);
end
%% multi-scale morphological gradient reconstruction
f_g=zeros(size(f,1),size(f,2));diff=zeros(max_itr,1);
for i=1:max_itr
    gx=w_recons_CO(f,strel('disk',i+se_start-1));
    f_g2=max(f_g,double(gx));
    f_g1=f_g;f_g=f_g2;
    diff(i)=max(max((abs(f_g1 - f_g2))));
    if diff(i) < min_impro, break; end
end