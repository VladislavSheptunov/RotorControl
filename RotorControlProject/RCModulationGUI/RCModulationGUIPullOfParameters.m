function [RCParameters] = RCModulationGUIPullOfParameters(handles)

RCParameters = GetRCParameters();

RCParameters.RotorPosition.alpha = degtorad(str2double(get(handles.edt_alpha, 'String')) / 1000.0); %rad
RCParameters.RotorPosition.beta  = degtorad(str2double(get(handles.edt_beta,  'String')) / 1000.0); %rad

RCParameters.RotorPosition.x     = str2double(get(handles.edt_x,     'String')) / 1000.0; %m
RCParameters.RotorPosition.y     = str2double(get(handles.edt_y,     'String')) / 1000.0; %m

%RCParameters.RotorPosition.alpha = str2double(get(handles.edt_alpha, 'String'));% / 1000.0; %mm
%RCParameters.RotorPosition.beta  = str2double(get(handles.edt_beta,  'String'));% / 1000.0; %mm

SetRCParameters(RCParameters);

end
