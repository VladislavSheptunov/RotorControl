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

% --- Executes just before RCBaseGUI is made visible.
function RCBaseGUI_OpeningFcn(hObject, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RCBaseGUI (see VARARGIN)

% Choose default command line output for RCBaseGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

handle = guihandles(hObject);


image = imread('ber.jpg');

%a = handle.btn_exit.InnerPosition;

%w = a[3];
imresize(image, 1);

%h = uicontrol;
set(handle.btn_exit,'cdata',image);

%set(handle.btn_exit, 'CData', image);
%set(handle.btn_show_trajectory, 'Visible', 'off');

% --- Outputs from this function are returned to the command line.
function varargout = RCBaseGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function btn_exit_Callback(hObject, eventdata, handles)
close()

% --- Executes on button press in btn_animation.
function btn_animation_Callback(hObject, eventdata, handles)
handles = guihandles(hObject);

set(handles.btn_clear, 'Visible', 'off');
close();

% --- Executes on button press in btn_clear.
function btn_clear_Callback(hObject, eventdata, handles)
% hObject    handle to btn_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close()

% --- Executes on button press in btn_enter.
function btn_enter_Callback(hObject, eventdata, handles)
global g_stabilisation;
handles = guihandles(hObject);

RCParameters = RCBaseGUIPullOfParameters(guihandles(hObject));

[t, ksi] = RCStabilisation(RCParameters);

g_stabilisation.vecT = t;
g_stabilisation.vecKSI = ksi;

set(handles.btn_show_trajectory, 'Visible', 'on');

% --- Executes on button press in btn_show_trajectory.
function btn_show_trajectory_Callback(hObject, eventdata, handles)
global g_stabilisation;

showGraphRC(g_stabilisation.vecT, g_stabilisation.vecKSI);

function edt_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to edt_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_alpha as text
%        str2double(get(hObject,'String')) returns contents of edt_alpha as a double


% --- Executes during object creation, after setting all properties.
function edt_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edt_beta_Callback(hObject, eventdata, handles)
% hObject    handle to edt_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_beta as text
%        str2double(get(hObject,'String')) returns contents of edt_beta as a double


% --- Executes during object creation, after setting all properties.
function edt_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edt_x_Callback(hObject, eventdata, handles)
% hObject    handle to edt_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_x as text
%        str2double(get(hObject,'String')) returns contents of edt_x as a double


% --- Executes during object creation, after setting all properties.
function edt_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edt_y_Callback(hObject, eventdata, handles)
% hObject    handle to edt_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_y as text
%        str2double(get(hObject,'String')) returns contents of edt_y as a double


% --- Executes during object creation, after setting all properties.
function edt_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edt_m_Callback(hObject, eventdata, handles)
% hObject    handle to edt_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_m as text
%        str2double(get(hObject,'String')) returns contents of edt_m as a double


% --- Executes during object creation, after setting all properties.
function edt_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_s0_Callback(hObject, eventdata, handles)
% hObject    handle to edt_s0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_s0 as text
%        str2double(get(hObject,'String')) returns contents of edt_s0 as a double


% --- Executes during object creation, after setting all properties.
function edt_s0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_s0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_it_Callback(hObject, eventdata, handles)
% hObject    handle to edt_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_it as text
%        str2double(get(hObject,'String')) returns contents of edt_it as a double


% --- Executes during object creation, after setting all properties.
function edt_it_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_l0_Callback(hObject, eventdata, handles)
% hObject    handle to edt_l0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_l0 as text
%        str2double(get(hObject,'String')) returns contents of edt_l0 as a double


% --- Executes during object creation, after setting all properties.
function edt_l0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_l0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_l1_Callback(hObject, eventdata, handles)
% hObject    handle to edt_l1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_l1 as text
%        str2double(get(hObject,'String')) returns contents of edt_l1 as a double


% --- Executes during object creation, after setting all properties.
function edt_l1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_l1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_l2_Callback(hObject, eventdata, handles)
% hObject    handle to edt_l2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_l2 as text
%        str2double(get(hObject,'String')) returns contents of edt_l2 as a double


% --- Executes during object creation, after setting all properties.
function edt_l2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_l2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_j_Callback(hObject, eventdata, handles)
% hObject    handle to edt_j (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_j as text
%        str2double(get(hObject,'String')) returns contents of edt_j as a double


% --- Executes during object creation, after setting all properties.
function edt_j_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_j (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_jz_Callback(hObject, eventdata, handles)
% hObject    handle to edt_jz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_jz as text
%        str2double(get(hObject,'String')) returns contents of edt_jz as a double


% --- Executes during object creation, after setting all properties.
function edt_jz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_jz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_w_Callback(hObject, eventdata, handles)
% hObject    handle to edt_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_w as text
%        str2double(get(hObject,'String')) returns contents of edt_w as a double


% --- Executes during object creation, after setting all properties.
function edt_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close RCBaseGUI.
function RCBaseGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to RCBaseGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes during object creation, after setting all properties.
function RCBaseGUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RCBaseGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
