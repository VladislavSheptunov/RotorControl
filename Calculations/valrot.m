function xdot=valrot(t, x, A, B, W)
xdot = (A+B*W)*x;
end
