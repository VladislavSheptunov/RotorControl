%SETVALUE();

  setlmis([]);
 % Y=lmivar(1,[8 1]);
 % Z=lmivar(2,[4 8]);
 % lambda=lmivar(1,[1 0]);
  
  [Y,m,sY] = lmivar(1,[8 1]);
  [Z,n,sZ] = lmivar(2,[4 8]);
  [lambda,q,slambda] = lmivar(1,[1 0]);
  
  lmiterm([1 1 1 Y],A,1,'s');                     % LMI #1: A*Y+Y*A'
  lmiterm([1 1 1 Y],.5*2*r,1,'s');                % LMI #1: 2*r*Y (NON SYMMETRIC?)
  lmiterm([1 1 1 Z],B,1,'s');                     % LMI #1: B*Z+Z'*B'

  lmiterm([-2 1 1 Y],1,1);                        % LMI #2: Y
  lmiterm([-2 2 1 Y],C1,1);                       % LMI #2: C1*Y
  lmiterm([-2 2 1 Z],D1,1);                       % LMI #2: D1*Z
  lmiterm([-2 2 2 0],I1);                         % LMI #2: I1

  lmiterm([-3 1 1 Y],1,1);                        % LMI #3: Y
  lmiterm([-3 2 1 Y],C2,1);                       % LMI #3: C2*Y
  lmiterm([-3 2 1 Z],D2,1);                       % LMI #3: D2*Z
  lmiterm([-3 2 2 0],I2);                         % LMI #3: I2

  lmiterm([-4 1 1 Y],1,1);                        % LMI #4: Y
  lmiterm([-4 2 1 Y],C3,1);                       % LMI #4: C3*Y
  lmiterm([-4 2 1 Z],D3,1);                       % LMI #4: D3*Z
  lmiterm([-4 2 2 0],I3);                         % LMI #4: I3

  lmiterm([-5 1 1 Y],1,1);                        % LMI #5: Y
  lmiterm([-5 2 1 Y],C4,1);                       % LMI #5: C4*Y
  lmiterm([-5 2 1 Z],D4,1);                       % LMI #5: D4*Z
  lmiterm([-5 2 2 0],I4);                         % LMI #5: I4

  lmiterm([-6 1 1 Y],1,1);                        % LMI #6: Y
  lmiterm([-6 2 1 Y],C5,1);                       % LMI #6: C5*Y
  lmiterm([-6 2 1 Z],D5,1);                       % LMI #6: D5*Z
  lmiterm([-6 2 2 0],I5);                         % LMI #6: I5

  lmiterm([-7 1 1 Y],1,1);                        % LMI #7: Y
  lmiterm([-7 2 1 Y],C6,1);                       % LMI #7: C6*Y
  lmiterm([-7 2 1 Z],D6,1);                       % LMI #7: D6*Z
  lmiterm([-7 2 2 0],I6);                         % LMI #7: I6

  lmiterm([-8 1 1 Y],1,1);                        % LMI #8: Y
  lmiterm([-8 2 1 0],J0);                         % LMI #8: J0
  lmiterm([-8 2 2 lambda],.5*1,I,'s');            % LMI #8: lambda*I (NON SYMMETRIC?)

  Rotor = getlmis;