function varargout = RCModulationGUI(varargin)
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
                   'gui_OpeningFcn', @RCModulationGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @RCModulationGUI_OutputFcn, ...
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

function RCModulationGUI_OpeningFcn(hObject, handles, varargin)
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
    
handles = guihandles(hObject);

jFrame=get(handle(handles.RCBaseGUI), 'javaframe');
jicon=javax.swing.ImageIcon('D:\RotorControl\RotorControlProject\Resource\emp.jpg');
jFrame.setFigureIcon(jicon);

setDefaultSliders(guihandles(hObject));
set(handles.btn_animation, 'Visible', 'off');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = RCModulationGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function btn_cancel_Callback(hObject, eventdata, handles)
close()

function btn_clear_Callback(hObject, eventdata, handles)
handle = guihandles(hObject);
RCParameters = GetRCParameters();

RCParameters.RotorPosition.alpha = 0.0;
RCParameters.RotorPosition.beta  = 0.0;
RCParameters.RotorPosition.x     = 0.0;
RCParameters.RotorPosition.y     = 0.0;

SetRCParameters(RCParameters);

setDefaultSliders(handle);

RCModulationGUIPushOfParameters(guihandles(hObject));

set(handle.btn_animation, 'Visible', 'off');

function btn_enter_Callback(hObject, eventdata, handles)
handles = guihandles(hObject);

RCStab = GetRCStabilisation();
RCParameters = RCModulationGUIPullOfParameters(handles);

[t, ksi] = RCStabilisation(RCParameters);

RCStab.vecT   = t;
RCStab.vecKSI = ksi;

showGraphRC(RCStab.vecT, RCStab.vecKSI);

SetRCStabilisation(RCStab);

set(handles.btn_animation, 'Visible', 'on');

function btn_animation_Callback(hObject, eventdata, handles)
open('RCAnimationGUI.fig');

function slider_alpha_Callback(hObject, eventdata, handles)
warning('off');

handles = guihandles(hObject);

RCParameters = RCModulationGUIPullOfParameters(handles);

beta  = RCParameters.RotorPosition.beta;
y     = RCParameters.RotorPosition.y;
x     = RCParameters.RotorPosition.x;

l1    = RCParameters.SpecificModel.l1;
l2    = RCParameters.SpecificModel.l2;
S0    = RCParameters.SpecificModel.S0;

partRight1 = (S0^2 - (y^2 + (x + beta*l1)^2)) / l1;
partRight2 = (S0^2 - (y^2 + (x - beta*l2)^2)) / l2;

syms A;
inequality1 = strcat(num2str(l1, '%.10f'), '*A^2 - 2*A = ', num2str(partRight1, '%.10f'));
inequality2 = strcat(num2str(l2, '%.10f'), '*A^2 + 2*A = ', num2str(partRight2, '%.10f'));

alphaMin = radtodeg(double(min(solve(inequality1, A))) * 1000.0); %mDeg
alphaMax = radtodeg(double(max(solve(inequality2, A))) * 1000.0); %mDeg

RCParameters.RotorPosition.alpha = setSliderForLabel(handles.slider_alpha, handles.edt_alpha, alphaMin, alphaMax);
SetRCParameters(RCParameters);


function slider_beta_Callback(hObject, eventdata, handles)
warning('off');

handles = guihandles(hObject);

RCParameters = RCModulationGUIPullOfParameters(handles);

alpha = RCParameters.RotorPosition.alpha;
y     = RCParameters.RotorPosition.y;
x     = RCParameters.RotorPosition.x;

l1    = RCParameters.SpecificModel.l1;
l2    = RCParameters.SpecificModel.l2;
S0    = RCParameters.SpecificModel.S0;

partRight1 = (S0^2 - (x^2 + (y - alpha*l1)^2)) / l1;
partRight2 = (S0^2 - (x^2 + (y + alpha*l2)^2)) / l2;

syms B;
inequality1 = strcat(num2str(l1, '%.10f'), '*B^2 + 2*B = ', num2str(partRight1, '%.10f'));
inequality2 = strcat(num2str(l2, '%.10f'), '*B^2 - 2*B = ', num2str(partRight2, '%.10f'));

betaMin = radtodeg(double(min(solve(inequality2, B))) * 1000.0); %mDeg
betaMax = radtodeg(double(max(solve(inequality1, B))) * 1000.0); %mDeg

RCParameters.RotorPosition.beta = setSliderForLabel(handles.slider_beta, handles.edt_beta, betaMin, betaMax);
SetRCParameters(RCParameters);

function slider_x_Callback(hObject, eventdata, handles)
warning('off');

handles = guihandles(hObject);

RCParameters = RCModulationGUIPullOfParameters(handles);

alpha   = RCParameters.RotorPosition.alpha;
beta    = RCParameters.RotorPosition.beta;
y       = RCParameters.RotorPosition.y;

l1 = RCParameters.SpecificModel.l1;
l2 = RCParameters.SpecificModel.l2;
S0 = RCParameters.SpecificModel.S0;

partRight1 = S0^2 - (y - alpha*l1)^2 - beta*l1*(beta*l1 + 2);
partRight2 = S0^2 - (y + alpha*l2)^2 - beta*l2*(beta*l2 - 2);

syms X;
inequality1 = strcat('X^2 == ', num2str(abs(partRight1), '%.10f'));
inequality2 = strcat('X^2 == ', num2str(abs(partRight2), '%.10f'));

xMin = double(min(solve(inequality1, X))) * 1000.0; %mm
xMax = double(max(solve(inequality2, X))) * 1000.0; %mm

RCParameters.RotorPosition.x = setSliderForLabel(handles.slider_x, handles.edt_x, xMin, xMax);
SetRCParameters(RCParameters);

function slider_y_Callback(hObject, eventdata, handles)
warning('off');

handles = guihandles(hObject);

RCParameters = RCModulationGUIPullOfParameters(handles);

alpha = RCParameters.RotorPosition.alpha;
beta = RCParameters.RotorPosition.beta;
x = RCParameters.RotorPosition.x;

l1 = RCParameters.SpecificModel.l1;
l2 = RCParameters.SpecificModel.l2;
S0 = RCParameters.SpecificModel.S0;

partRight1 = S0^2 - (x + beta*l1)^2 - alpha*l1*(alpha*l1 - 2);
partRight2 = S0^2 - (x - beta*l2)^2 - alpha*l2*(alpha*l2 + 2);

syms Y;
inequality1 = strcat('Y^2 == ', num2str(abs(partRight1), '%.10f'));
inequality2 = strcat('Y^2 == ', num2str(abs(partRight2), '%.10f'));

yMin = double(min(solve(inequality1, Y))) * 1000.0; %mm
yMax = double(max(solve(inequality2, Y))) * 1000.0; %mm

RCParameters.RotorPosition.y = setSliderForLabel(handles.slider_y, handles.edt_y, yMin, yMax);
SetRCParameters(RCParameters);

% --- Executes when user attempts to close RCBaseGUI.
function RCModulationGUI_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);


% --- Executes during object creation, after setting all properties.
function RCModulationGUI_CreateFcn(hObject, eventdata, handles)

function [valueLabel] = setSliderForLabel(xSlider, xLabel, xMin, xMax)
sliderValue = get(xSlider, 'Value');
valueLabel = sliderValue;

if (xMin == xMax)
    return;
end

st = 1 * 10^-2;
sliderStep = [(st / (xMax - xMin)), (st / (xMax - xMin))]; 

if (sliderValue < xMin || sliderValue > xMax)
    sliderValue = 0;
    set(xSlider, 'Value', sliderValue);
end

set(xSlider, 'SliderStep', sliderStep);

set(xSlider, 'Min', xMin);
set(xSlider, 'Max', xMax);

valueLabel = sliderValue;

set(xLabel, 'String', num2str(valueLabel, '%.2f'));

valueLabel = valueLabel / 1000.0;

function setDefaultSliders(handle)
set(handle.slider_alpha, 'Value', 0);
set(handle.slider_beta,  'Value', 0);
set(handle.slider_x,     'Value', 0);
set(handle.slider_y,     'Value', 0);


% --- Executes during object creation, after setting all properties.
function edt_alpha_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edt_beta_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% % --- Executes during object creation, after setting all properties.
function edt_x_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edt_y_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
