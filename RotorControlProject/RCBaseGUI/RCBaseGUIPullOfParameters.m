function [RotorParameters] = RCBaseGUIPullOfParameters(handles)

RotorParameters.RotorPosition.alpha = str2double(get(handles.edt_alpha,'String'));
RotorParameters.RotorPosition.beta = str2double(get(handles.edt_beta,'String'));
RotorParameters.RotorPosition.x = str2double(get(handles.edt_x,'String'));
RotorParameters.RotorPosition.y = str2double(get(handles.edt_y,'String'));

RotorParameters.SpecificModel.m = str2double(get(handles.edt_m,'String'));
RotorParameters.SpecificModel.S0 = str2double(get(handles.edt_s0,'String'));
RotorParameters.SpecificModel.It = str2double(get(handles.edt_it,'String'));
RotorParameters.SpecificModel.L0 = str2double(get(handles.edt_l0,'String'));
RotorParameters.SpecificModel.l1 = str2double(get(handles.edt_l1,'String'));
RotorParameters.SpecificModel.l2 = str2double(get(handles.edt_l2,'String'));
RotorParameters.SpecificModel.J = str2double(get(handles.edt_j,'String'));
RotorParameters.SpecificModel.Jz = str2double(get(handles.edt_jz,'String'));
RotorParameters.SpecificModel.w = str2double(get(handles.edt_w,'String'));

end

