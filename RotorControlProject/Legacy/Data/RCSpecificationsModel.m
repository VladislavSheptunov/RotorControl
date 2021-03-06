% SpecificModel.field:
% m     - ����� ������
% S0    - �����
% It    - ����������� �� ����
% L0    - ������������� ���
% l1    - ��������� �� �������� �� �� ������ ���� ������
% l2    - ��������� �� ������� �� �� ������ ���� ������
% J     - ������ ������� ������������ ���� x � y
% Jz    - ������ ������� ������������ ��� z 
% w     - �������� 

%SpecificModel.m = 1;
%SpecificModel.S0 = 1;
%SpecificModel.It = 1;
%SpecificModel.L0 = 1;
%SpecificModel.l1 = 1;
%SpecificModel.l2 = 1;
%SpecificModel.J = 1;
%SpecificModel.Jz = 1;
%SpecificModel.w = 1;

%RotorPosition.alpha = 1;
%RotorPosition.beta = 1;
%RotorPosition.x = 1;
%RotorPosition.y = 1;

%RotorParameters.RotorPosition;
%RotorParameters.SpecificModel;

SpecificModel = struct( 'm',    0, ...
                        'S0',   0, ...
                        'It',   0, ...
                        'L0',   0, ...
                        'l1',   0, ...
                        'l2',   0, ...
                        'J',    0, ...
                        'Jz',   0, ...
                        'w',    0');

% RotorPosition.field:
% alpha - ���� �������� ������ ������������ ��� x
% beta  - ���� �������� ������ ������������ ��� y
% x, y  - ���������� ������ ����
%RotorPosition = struct(alpha, 0, beta, 0, x, 0, y, 0);

%RotorParameters = struct(RotorPosition, 0, SpecificModel, 0);
