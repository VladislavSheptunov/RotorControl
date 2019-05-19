function varargout = RCBaseGUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RCBaseGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @RCBaseGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function RCBaseGUI_OpeningFcn(hObject, handles, varargin)
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
    
handles = guihandles(hObject);

jFrame=get(handle(handles.RCBaseGUI), 'javaframe');
jicon=javax.swing.ImageIcon('D:\RotorControl\RotorControlProject\Resource\emp_1.jpg');
jFrame.setFigureIcon(jicon);

[im, ~, alpha] = imread('D:\RotorControl\RotorControlProject\Resource\rotor.png');
panelAxis = imshow(im);
set(panelAxis, 'AlphaData', alpha);

set(handles.btn_modulation, 'Visible', 'off');

handles.output = hObject;

guidata(hObject, handles);

function varargout = RCBaseGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function btn_exit_Callback(hObject, eventdata, handles)
close();

function btn_clear_Callback(hObject, eventdata, handles)
handle = guihandles(hObject);

RCParameters = GetRCParameters();

RCParameters.SpecificModel.m  = 0.0;
RCParameters.SpecificModel.S0 = 0.0;
RCParameters.SpecificModel.It = 0.0;
RCParameters.SpecificModel.L0 = 0.0;
RCParameters.SpecificModel.l1 = 0.0;
RCParameters.SpecificModel.l2 = 0.0;
RCParameters.SpecificModel.J  = 0.0;
RCParameters.SpecificModel.Jz = 0.0;
RCParameters.SpecificModel.w  = 0.0;

SetRCParameters(RCParameters);

RCBaseGUIPushOfParameters(guihandles(hObject));

set(handle.btn_modulation, 'Visible', 'off');

function btn_default_Callback(hObject, eventdata, handles)
handle = guihandles(hObject);

RCParameters = GetRCParameters();

RCParameters.SpecificModel.m  = 13.5;
RCParameters.SpecificModel.S0 = 0.0006;
RCParameters.SpecificModel.It = 1.4;
RCParameters.SpecificModel.L0 = 0.007;
RCParameters.SpecificModel.l1 = 0.3;
RCParameters.SpecificModel.l2 = 0.3;
RCParameters.SpecificModel.J  = 0.756;
RCParameters.SpecificModel.Jz = 0.0269;
RCParameters.SpecificModel.w  = 523.6;

SetRCParameters(RCParameters);

RCBaseGUIPushOfParameters(guihandles(hObject));

set(handle.btn_modulation, 'Visible', 'off');

function btn_enter_Callback(hObject, eventdata, handles)
handle = guihandles(hObject);

RCParameters = RCBaseGUIPullOfParameters(guihandles(hObject));
SetRCParameters(RCParameters);

set(handle.btn_modulation, 'Visible', 'on');

function btn_modulation_Callback(hObject, eventdata, handles)
set(handles.btn_modulation, 'Visible', 'off');

open('RCModulationGUI.fig');

function btn_about_Callback(hObject, eventdata, handles)
open('RCAboutGUI.fig');

function edt_m_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edt_m_Callback(hObject, eventdata, handles)

function edt_s0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edt_s0_Callback(hObject, eventdata, handles)

function edt_it_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edt_it_Callback(hObject, eventdata, handles)

function edt_l0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edt_l0_Callback(hObject, eventdata, handles)

function edt_l1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edt_l1_Callback(hObject, eventdata, handles)

function edt_l2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edt_l2_Callback(hObject, eventdata, handles)

function edt_j_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edt_j_Callback(hObject, eventdata, handles)

function edt_jz_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edt_jz_Callback(hObject, eventdata, handles)

function edt_w_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edt_w_Callback(hObject, eventdata, handles)

function RCBaseGUI_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);

function RCBaseGUI_CreateFcn(hObject, eventdata, handles)

