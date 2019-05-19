%SETVALUE();
Parameters();

   setlmis([]);
  %Y=lmivar(1,[8 1]);
  %Z=lmivar(2,[4 8]);
  %gamma=lmivar(1,[1 0]);
  
  [Y,m,sY] = lmivar(1,[8 1]);
  [Z,n,sZ] = lmivar(2,[4 8]);
  [gamma,q,sgamma] = lmivar(1,[1 0]);
  
  lmiterm([1 1 1 Y],A,1,'s');                     % LMI #1: A*Y+Y*A'
  lmiterm([1 1 1 Z],Bu,1,'s');                    % LMI #1: Bu*Z+Z'*Bu'
  lmiterm([1 2 1 0],Bv);                          % LMI #1: Bv
  lmiterm([1 2 2 0],-I);                          % LMI #1: -I

  lmiterm([-2 1 1 Y],1,1);                        % LMI #2: Y
  lmiterm([-2 2 1 Y],C1',1);                      % LMI #2: C1'*Y
  lmiterm([-2 2 1 -Z],D1',1);                     % LMI #2: D1'*Z'
  lmiterm([-2 2 2 0],gamma^2*alpha1^2*I);         % LMI #2: gamma^2*alpha1^2*I

  lmiterm([-3 1 1 Y],1,1);                        % LMI #3: Y
  lmiterm([-3 2 1 Y],C2',1);                      % LMI #3: C2'*Y
  lmiterm([-3 2 1 -Z],D2',1);                     % LMI #3: D2'*Z'
  lmiterm([-3 2 2 0],gamma^2*alpha2^2*I);         % LMI #3: gamma^2*alpha2^2*I

  MultiobjectiveProblem=getlmis;