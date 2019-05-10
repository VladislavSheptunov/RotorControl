function RCBaseGUIPushOfParameters(handles)

RCParameters = GetRCParameters();

set(handles.edt_m,  'String', num2str(RCParameters.SpecificModel.m));
set(handles.edt_it, 'String', num2str(RCParameters.SpecificModel.It));
set(handles.edt_l0, 'String', num2str(RCParameters.SpecificModel.L0));

set(handles.edt_s0, 'String', num2str(RCParameters.SpecificModel.S0)); %mm
set(handles.edt_l1, 'String', num2str(RCParameters.SpecificModel.l1));
set(handles.edt_l2, 'String', num2str(RCParameters.SpecificModel.l2));

set(handles.edt_j,  'String', num2str(RCParameters.SpecificModel.J));
set(handles.edt_jz, 'String', num2str(RCParameters.SpecificModel.Jz));
set(handles.edt_w,  'String', num2str(RCParameters.SpecificModel.w));

end
