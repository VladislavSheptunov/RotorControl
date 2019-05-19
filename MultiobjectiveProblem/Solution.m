SystemLMI();
%c = []; задать самим размерность 
%с = [] все нули кроме последнего 36+1+32
%c = zeros([1,69]);
%c(1,69) = 1;
%c = mat2dec(Rotor,sY,sZ,slambda);

%[copt,xopt] = mincx(Rotor,c);

%Y = dec2mat(Rotor, xopt, 1);
%Z = dec2mat(Rotor, xopt, 2);
%lambda = dec2mat(Rotor, xopt, 3);

%W = Z*Y^-1;


n = decnbr(MultiobjectiveProblem);
c = zeros(n,1);


