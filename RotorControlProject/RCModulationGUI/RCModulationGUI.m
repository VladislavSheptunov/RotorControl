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
    
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = RCModulationGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function btn_cancel_Callback(hObject, eventdata, handles)
close()

function btn_clear_Callback(hObject, eventdata, handles)
RCParameters = GetRCParameters();

RCParameters.RotorPosition.alpha = 0.0;
RCParameters.RotorPosition.beta  = 0.0;
RCParameters.RotorPosition.x     = 0.0;
RCParameters.RotorPosition.y     = 0.0;

SetRCParameters(RCParameters);

RCModulationGUIPushOfParameters(guihandles(hObject));

function btn_enter_Callback(hObject, eventdata, handles)
handles = guihandles(hObject);

RCParameters = RCModulationGUIPullOfParameters(handles);

[t, ksi] = RCStabilisation(RCParameters);

showGraphRC(t, ksi);

%close()

% function edt_alpha_Callback(hObject, eventdata, handles)
% % hObject    handle to edt_alpha (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edt_alpha as text
% %        str2double(get(hObject,'String')) returns contents of edt_alpha as a double

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
% 
% function edt_beta_Callback(hObject, eventdata, handles)
% % hObject    handle to edt_beta (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edt_beta as text
% %        str2double(get(hObject,'String')) returns contents of edt_beta as a double

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
% 
% function edt_x_Callback(hObject, eventdata, handles)
% % hObject    handle to edt_x (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edt_x as text
% %        str2double(get(hObject,'String')) returns contents of edt_x as a double

% % --- Executes during object creation, after setting all properties.
function edt_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% 
% 
% function edt_y_Callback(hObject, eventdata, handles)
% % hObject    handle to edt_y (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edt_y as text
% %        str2double(get(hObject,'String')) returns contents of edt_y as a double
% 

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


function slider_alpha_Callback(hObject, eventdata, handles)
warning('off');

handles = guihandles(hObject);

RCParameters = RCModulationGUIPullOfParameters(handles);

%alpha = 0.00039;
%x = 0.0005;
%y = -0.0001;

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

t1 = solve(inequality1, A) * 1000.0;
t2 = solve(inequality2, A) * 1000.0;

alphaMin = radtodeg(double(min(solve(inequality1, A))) * 1000.0); %mDeg
alphaMax = radtodeg(double(max(solve(inequality2, A))) * 1000.0); %mDeg

RCParameters.RotorPosition.alpha = setSliderForLabel(handles.slider_alpha, handles.edt_alpha, alphaMin, alphaMax);
SetRCParameters(RCParameters);


function slider_beta_Callback(hObject, eventdata, handles)
warning('off');

handles = guihandles(hObject);

RCParameters = RCModulationGUIPullOfParameters(handles);

%alpha = -0.00049;
%x = 0.0005;
%y = -0.0001;

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







%RCParameters = GetRCParameters();

%alpha = RCParameters.RotorPosition.alpha;
%beta  = RCParameters.RotorPosition.beta;
%x     = RCParameters.RotorPosition.x;
%y     = RCParameters.RotorPosition.y;

%l1 = RCParameters.SpecificModel.l1;
%l2 = RCParameters.SpecificModel.l2;
%S0 = RCParameters.SpecificModel.S0;

%Yv = num2str((y - alpha*l1)^2, '%.10f');
%Yl = num2str((y + alpha*l2)^2, '%.10f');
%xv = x+beta*l1;
%xl = x-beta*l2;

%Yv = (y - alpha*l1);
%Yl = (y + alpha*l2);

%tmp1 = (S0^2 - (x^2 + Yv^2)) / l1;
%tmp2 = (S0^2 - (x^2 + Yl^2)) / l2;

%e_1 = strcat(num2str(l1, '%.10f'), '*b^2 + 2*b = ', num2str(tmp1, '%.10f'));
%e_2 = strcat(num2str(l2, '%.10f'), '*b^2 - 2*b = ', num2str(tmp2, '%.10f'));

%syms b;

%tmp1 = solve(e_1, b);
%tmp2 = solve(e_2, b);

%Xv = strcat('(', num2str(x, '%.10f'), '+b*', num2str(l1, '%.10f'), ')^2');
%Xl = strcat('(', num2str(x, '%.10f'), '-b*', num2str(l2, '%.10f'), ')^2');
    
%Xv = '(x + b*l1)^2';
%Xl = '(x - b*l2)^2';

%e1 = strcat(Xv, '+', Yv, '<=', num2str(S0^2, '%.10f')); 
%e2 = strcat(Xl, '+', Yl, '<=', num2str(S0^2, '%.10f'));

%e1 = strcat(Xv, '+', Yv, '<=S0^2');
%e2 = strcat(Xl, '+', Yl, '<=S0^2');
%e = strcat('[', e1, ',', e2, ']');




%maple('solve','{x+3*y>=1, x+y>0, x+3*y<=1, x-y>=2}, {x,y}')

%tmp = solve(e, b);


%tempBeta = 2*x^2 + 2*y^2 + 2*alpha*(l2-l1) + alpha^2*(l1^2+l2^2);

%tmpBeta = num2str(tempBeta, '%.10f');
%tmpll = num2str((l1-l2), '%.10f');
%tmpllSqr = num2str((l1^2+l2^2), '%.10f');

%equationForMin = strcat('2*X*', tmpll, '+', 'X^2*', tmpllSqr, '-', num2str(S0^2), '-', tmpBeta, '=0');
%equationForMax = strcat('2*X*', tmpll, '+', 'X^2*', tmpllSqr, '+', num2str(S0^2), '-', tmpBeta, '=0');

%syms X;

%xMin = solve(equationForMin, X);
%xMax = solve(equationForMax, X);

%betaMin = min(solve(equationForMin, X));
%betaMax = max(solve(equationForMax, X));

%handles = guihandles(hObject);
%setSliderForLabel(handles.slider_y, handles.edt_y, betaMin, betaMax);

%betaMin = solve('2*X*(l1-l2) + X^2*(l1^2-l2^2) + S0^2 + tempBeta = 0', X);
%betaMin = subs(betaMin, {'l1', 'l2', 'S0', 'tempBeta'}, {l1, l2, S0, tempBeta});

%syms beta;

%betaMin = solve(equation, X);

%betaMin = max(betaMin);
%betaMin = solve('2*X*(l1-l2) + X^2*(l1^2-l2^2) + S0^2 + tempBeta = 0', X);


%a = str2double(betaMin);

%yMin = -sqrt(S0^2 + tempY) * 1000.0; %mm
%yMax = sqrt(S0^2 - tempY) * 1000.0;  %mm

%handles = guihandles(hObject);

%setSliderForLabel(handles.slider_y, handles.edt_y, yMin, yMax);

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
% hObject    handle to RCBaseGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes during object creation, after setting all properties.
function RCModulationGUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RCBaseGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


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

% ==== DEBUG ====
RCParameters = GetRCParameters();
alpha = RCParameters.RotorPosition.alpha;
beta = RCParameters.RotorPosition.beta;

y = RCParameters.RotorPosition.y;
x = RCParameters.RotorPosition.x;

%handles = guihandles(hObject);

%x = str2double(get(handles.edt_x, 'String')) / 1000.0; %mm
%y = str2double(get(handles.edt_y, 'String')) / 1000.0; %mm



l1 = RCParameters.SpecificModel.l1;
l2 = RCParameters.SpecificModel.l2;
S0 = RCParameters.SpecificModel.S0;

xv = x+beta*l1;
xl = x-beta*l2;
yv = y-alpha*l1;
yl = y+alpha*l2;

%if (xv^2 + yv^2 > S0^2) && (xl^2 + yl^2 > S0^2) 
%    return;
%end
% ==== DEBUG ====


sliderValue = get(xSlider, 'Value');

set(xSlider, 'SliderStep', sliderStep);

set(xSlider, 'Min', xMin);
set(xSlider, 'Max', xMax);

valueLabel = sliderValue;

set(xLabel, 'String', num2str(valueLabel, '%.2f'));

valueLabel = valueLabel / 1000.0;


