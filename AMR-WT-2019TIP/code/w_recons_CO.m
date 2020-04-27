%分水岭变换过程函数，从形态学梯度重构开始
function fobrcbr=w_recons_CO(f,se)
fe=imerode(f,se);
fobr=imreconstruct(fe,f); 
fobrc=imcomplement(fobr);
fobrce=imerode(fobrc,se);
fobrcbr=imcomplement(imreconstruct(fobrce,fobrc));

