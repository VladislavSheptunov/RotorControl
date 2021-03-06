function [A B W ]=getrotor(m,S0,It,L0,l1,l2,J,Jz,w)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%������� ������������
r = 0.86;
%���������� ���������� 
%global A;

%���������
%m = 13.5;       %����� ������
%S0 = 0.0006;    %�����
%It = 1.4;       %����������� �� ����
%L0 = 0.007;     %������������� ���
%l1 = 0.3;       %��������� �� �������� �� �� ������ ���� ������
%l2 = 0.3;       %��������� �� ������� �� �� ������ ���� ������
%J = 0.756;      %������ ������� ������������ ���� x � y
%Jz = 0.0269;    %������ ������� ������������ ��� z 
%w = 523.6;      %�������� 

T = sqrt((8*m*(S0)^2)/(L0*(It)^2)); %����� 
l0 = (l1+l2)/2;                   %��������� ������� ��� �� ������ ���� ������
m1 = (m*l1*l0)/J;
m2 = (m*l2*l0)/J;
p0 = (Jz*T*w)/J;
s1 = l1/l0;
s2 = l2/l0;

%������� ������� A = [[0;0] [I;G]]
G = [[0;p0;0;0] [-p0;0;0;0] [0;0;0;0] [0;0;0;0]];
I = eye(4);
I1 = eye(4);
I2 = eye(4);
I3 = 1;
I4 = 1;
I5 = 1;
I6 = 1;
%I1 = 1;
A = [[zeros(4);zeros(4)] [I;G]];

%������� ������� B = [[0] [B1]]
B1 = [[-m1;0;0;1] [m2;0;0;1] [0;m1;1;0] [0;-m2;1;0]];
B = [zeros(4); B1];

%������� P1 and P2
P1 = [[s1^2;0;0;-s1] [0;s1^2;s1;0] [0;s1;1;0] [-s1;0;0;1]];
P2 = [[s2^2;0;0;s2] [0;s2^2;-s2;0] [0;-s2;1;0] [s2;0;0;1]];

%������� �i i = {1,2,3,4,5,6};
C1 = [sqrtm(P1) zeros(4)];
C2 = [sqrtm(P2) zeros(4)];
%C3 = 0;
%C4 = 0;
%C5 = 0;
%C6 = 0;
%C3 = zeros([4 8]);
%C4 = zeros([4 8]);
%C5 = zeros([4 8]);
%C6 = zeros([4 8]);
C3 = zeros([1 8]);
C4 = zeros([1 8]);
C5 = zeros([1 8]);
C6 = zeros([1 8]);

%������� Di i = {1,2,3,4,5,6};
D1 = zeros([4 4]);
D2 = zeros([4 4]);
%D1 = 0;
%D2 = 0;
D3 = [1 0 0 0];
D4 = [0 1 0 0];
D5 = [0 0 1 0];
D6 = [0 0 0 1];

%������� J0
J0 = [I zeros(4)];

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
  
  %c = []; ������ ����� ����������� 
%� = [] ��� ���� ����� ���������� 36+1+32
%c = zeros([1,69]);
%c(1,69) = 1;
c = mat2dec(Rotor,sY,sZ,slambda);

[copt,xopt] = mincx(Rotor,c);

Y = dec2mat(Rotor, xopt, 1);
Z = dec2mat(Rotor, xopt, 2);
lambda = dec2mat(Rotor, xopt, 3);

W = Z*Y^-1;

end

