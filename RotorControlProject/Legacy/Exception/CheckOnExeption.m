function CheckOnExeption( RotorParameters )

alpha = RotorParameters.RotorPosition.alpha;
beta = RotorParameters.RotorPosition.beta;
x = RotorParameters.RotorPosition.x;
y = RotorParameters.RotorPosition.y;

l1 = RotorParameters.SpecificModel.l1;
l2 = RotorParameters.SpecificModel.l2;

S0 = RotorParameters.SpecificModel.S0;

xv = x+beta*l1;
xl = x-beta*l2;
yv = y-alpha*l1;
yl = y+alpha*l2;

if (xv^2 + yv^2 <= S0^2) && (xl^2 + yl^2 <= S0^2)
    open('Exception.fig');

end

