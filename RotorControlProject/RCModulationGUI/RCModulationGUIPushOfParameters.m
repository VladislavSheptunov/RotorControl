function RCModulationGUIPushOfParameters(handles)

RCParameters = GetRCParameters();

alpha = radtodeg(RCParameters.RotorPosition.alpha * 1000.0); %mDeg
beta  = radtodeg(RCParameters.RotorPosition.beta  * 1000.0); %mDeg
x     = RCParameters.RotorPosition.x * 1000.0; %m
y     = RCParameters.RotorPosition.y * 1000.0; %m

set(handles.edt_alpha, 'String', num2str(alpha, '%.2f'));
set(handles.edt_beta,  'String', num2str(beta,  '%.2f'));
set(handles.edt_x,     'String', num2str(x,     '%.2f'));
set(handles.edt_y,     'String', num2str(y,     '%.2f'));

end
