function varargout = RCBaseGUI(varargin)
% RCBASEGUI M-file for RCBaseGUI.fig
%      RCBASEGUI, by itself, creates a new RCBASEGUI or raises the existing
%      singleton*.
%
%      H = RCBASEGUI returns the handle to a new RCBASEGUI or the handle to
%      the existing singleton*.
%
%      RCBASEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RCBASEGUI.M with the given input arguments.
%
%      RCBASEGUI('Property','Value',...) creates a new RCBASEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RCBaseGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RCBaseGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RCBaseGUI

% Last Modified by GUIDE v2.5 22-Jan-2019 19:22:53

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT

function RCBaseGUI_OpeningFcn(hObject, handles, varargin)
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
    
handles = guihandles(hObject);

jFrame=get(handle(handles.RCBaseGUI), 'javaframe');
jicon=javax.swing.ImageIcon('D:\RotorControl\RotorControlProject\Resource\emp.jpg');
jFrame.setFigureIcon(jicon);

[im, ~, alpha] = imread('D:\RotorControl\RotorControlProject\Resource\rotor.png');
panelAxis = imshow(im);
set(panelAxis, 'AlphaData', alpha);

set(handles.btn_modulation, 'Visible', 'off');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = RCBaseGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function btn_exit_Callback(hObject, eventdata, handles)
close();

% --- Executes on button press in btn_clear.
function btn_clear_Callback(hObject, eventdata, handles)
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

function btn_default_Callback(hObject, eventdata, handles)
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

% --- Executes on button press in btn_enter.
function btn_enter_Callback(hObject, eventdata, handles)
handle = guihandles(hObject);

RCParameters = RCBaseGUIPullOfParameters(guihandles(hObject));
SetRCParameters(RCParameters);

set(handle.btn_modulation, 'Visible', 'on');

% --- Executes on button press in btn_show_trajectory.
function btn_modulation_Callback(hObject, eventdata, handles)
set(handles.btn_modulation, 'Visible', 'off');

open('RCModulationGUI.fig');

function btn_about_Callback(hObject, eventdata, handles)

close()

% --- Executes during object creation, after setting all properties.
function edt_m_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edt_s0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edt_it_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edt_l0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edt_l1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edt_l2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edt_j_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edt_jz_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edt_w_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when user attempts to close RCBaseGUI.
function RCBaseGUI_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);

% --- Executes during object creation, after setting all properties.
function RCBaseGUI_CreateFcn(hObject, eventdata, handles)

