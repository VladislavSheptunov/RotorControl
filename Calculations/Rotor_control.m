function varargout = Rotor_control(varargin)
%ROTOR();
%SETVALUE();
%SETLMI();
%LMI();
% ROTOR_CONTROL M-file for Rotor_control.fig
%      ROTOR_CONTROL, by itself, creates a new ROTOR_CONTROL or raises the existing
%      singleton*.
%
%      H = ROTOR_CONTROL returns the handle to a new ROTOR_CONTROL or the handle to
%      the existing singleton*.
%
%      ROTOR_CONTROL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTOR_CONTROL.M with the given input arguments.
%
%      ROTOR_CONTROL('Property','Value',...) creates a new ROTOR_CONTROL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Rotor_control_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Rotor_control_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Rotor_control

% Last Modified by GUIDE v2.5 09-Jun-2017 01:05:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Rotor_control_OpeningFcn, ...
                   'gui_OutputFcn',  @Rotor_control_OutputFcn, ...
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


% --- Executes just before Rotor_control is made visible.
function Rotor_control_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Rotor_control (see VARARGIN)

% Choose default command line output for Rotor_control
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Rotor_control wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Rotor_control_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close()

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[A B W] = getrotor();
T1 = [0 8];
alpha = -0.00049;
beta = 0.00039;
x = 0.0001;
y = -0.00025;
ksi0 = [alpha;beta;x;y;0;0;0;0];
[t,ksi] = ode45(@(t,ksi)valrot(t, ksi, A, B, W),T1,ksi0);
plot(t,ksi);


% --- Executes on button press in btn_animation.
function btn_animation_Callback(hObject, eventdata, handles)
%========================================================================%
%%%%%%%%%%%%%%%%%%%    ��� ���������� ������� ksi    %%%%%%%%%%%%%%%%%%%%%
alpha = str2num(get(handles.edt_alpha,'String'));
beta = str2num(get(handles.edt_beta,'String'));
x = str2num(get(handles.edt_x,'String'));
y = str2num(get(handles.edt_y,'String'));
m = str2num(get(handles.edt_m,'String'));   %����� ������
S0 = str2num(get(handles.edt_s0,'String')); %�����
It = str2num(get(handles.edt_it,'String')); %����������� �� ����
L0 = str2num(get(handles.edt_l0,'String')); %������������� ���
l1 = str2num(get(handles.edt_l1,'String')); %��������� �� �������� �� �� ������ ���� ������
l2 = str2num(get(handles.edt_l2,'String')); %��������� �� ������� �� �� ������ ���� ������
J = str2num(get(handles.edt_j,'String'));   %������ ������� ������������ ���� x � y
Jz = str2num(get(handles.edt_jz,'String')); %������ ������� ������������ ��� z 
w = str2num(get(handles.edt_w,'String'));   %�������� 

xv = x+beta*l1;
xl = x-beta*l2;
yv = y-alpha*l1;
yl = y+alpha*l2;

if (xv^2 + yv^2 <= S0^2) && (xl^2 + yl^2 <= S0^2) 
    
[A B W] = getrotor(m,S0,It,L0,l1,l2,J,Jz,w);
T1 = [0 10];

ksi0 = [alpha;beta;x;y;0;0;0;0];
[t,ksi] = ode45(@(t,ksi)valrot(t, ksi, A, B, W),T1,ksi0);
%========================================================================%



%========================================================================%
%%%%%%%%%%%%%%%%%%%           ��� ��������         %%%%%%%%%%%%%%%%%%%%%%%
open('Rotor_control_animation.fig');

%parametr = S0*2; 
%parametr = 1; 
%v = -parametr:0.0001:parametr;
%[x,y] = meshgrid(v);  % create a grid
%ksix = 1:length(ksi);
%ksiy = 1:length(ksi);
%for i = 1:length(ksi)
   % ksix(i) = ksi(i,3);
   % ksiy(i) = ksi(i,4);   
%end;
masxv = 1:length(ksi);
masyv = 1:length(ksi);
masxl = 1:length(ksi);
masyl = 1:length(ksi);

for i = 1:length(ksi)
    %ksix(i) = ksi(i,3);
   % ksiy(i) = ksi(i,4);   
    masxv(i) = ksi(i,3)+ksi(i,2)*l1;
    masyv(i) = ksi(i,4)-ksi(i,1)*l1;
    masxl(i) = ksi(i,3)-ksi(i,2)*l2;
    masyl(i) = ksi(i,4)+ksi(i,1)*l2;
end;
DELAY = 0.05;

 x0 = 0; 
 y0 = 0; 
 r = 4*S0; 
 x1=[]; 
 y1=[]; 

%xv = x+beta*l1;
%xl = x-beta*l2;
%yv = y-alpha*l1;
%yl = y+alpha*l2;
%for i = 1:3 
    for i = 1:length(ksi)
        clf;
       
       % axis off
        %ineq1 = (xv.^2 + yv.^2 <= S0.^2);
        %ineq1 = (x.^2 + y.^2 <= S0.^2);
        %ineq1 = (x.^2 + y.^2 <= 16*S0.^2);
        %ineq2 = (xl.^2 + yl.^2 <= S0.^2);
        %f1 = double(ineq1);
        %f2 = double(ineq2);
        %contour(x,y,f1); 
        %contour(x,y,f1,'Linecolor',[1 0.5 0]);   
       % hold on
        %contour(x,y,f2,'Linecolor',[0.7 0 0]);
       % hold on

        for j=0:360 
            x1=[x1 x0+r*cos(j/180*pi)]; 
            y1=[y1 y0+r*sin(j/180*pi)]; 
        end
        %subplot(1, 2, 1),plot(x1,y1,'k');
        plot(x1,y1,'k','LineWidth',8);
        %subplot(1, 2, 2),plot(x1,y1,'k');
        %plot(x1,y1,'k');
        axis equal
        axis ([-0.0027 0.0027 -0.0027 0.0027])
       % axis ([-0.0005 0.0005 -0.0005 0.0005])
        title('The inner ring of the upper EMP');
        hold on
        %legend('Inner ring of upper EMP',4);
       % hold on
        %plot(ksix(i),ksiy(i),'ko','MarkerSize',230,'MarkerFaceColor',[0.5 0.5 0.5]);
       % subplot(1, 2, 1),plot(masxv(i),masyv(i),'ko','MarkerSize',160,'MarkerFaceColor',[0.5 0.5 0.5]);
        plot(masxv(i),masyv(i),'ko','MarkerSize',255,'MarkerFaceColor',[0.5 0.5 0.5]);
        axis off
        %%%%%%%%%%%%%%%
     %   subplot(1, 2, 2),plot(x1,y1,'k');
        %plot(x1,y1,'k');
     %   axis equal
     %   axis ([-0.0027 0.0027 -0.0027 0.0027])
       % axis ([-0.0005 0.0005 -0.0005 0.0005])
        %hold on
     %   title('The inner ring of the lower EMP'); 
       % legend('Inner ring of upper EMP',4);
     %   hold on
        %plot(ksix(i),ksiy(i),'ko','MarkerSize',230,'MarkerFaceColor',[0.5 0.5 0.5]);
     %   subplot(1, 2, 2),plot(masxl(i),masyl(i),'ko','MarkerSize',160,'MarkerFaceColor',[0.5 0.5 0.5]);
     %   axis off
        %%%%%%%%%%%%%%%
        
        %plot(ksix(i),ksiy(i),'ko','MarkerSize',40,'MarkerFaceColor',[0.5 0.5 0.5]);
        pause(DELAY);
    end;
%end

else
    open('Exception.fig');
end
%========================================================================%


% --- Executes on button press in enter_ksi.
function enter_ksi_Callback(hObject, eventdata, handles)
% hObject    handle to enter_ksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2



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


% --- Executes on button press in btn_enter_alpha.
function btn_enter_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to btn_enter_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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

% --- Executes on button press in btn_clear.
function btn_clear_Callback(hObject, eventdata, handles)
% hObject    handle to btn_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset');

% --- Executes on button press in btn_entet.
function btn_entet_Callback(hObject, eventdata, handles)

alpha = str2num(get(handles.edt_alpha,'String'));
beta = str2num(get(handles.edt_beta,'String'));
x = str2num(get(handles.edt_x,'String'));
y = str2num(get(handles.edt_y,'String'));
m = str2num(get(handles.edt_m,'String'));   %����� ������
S0 = str2num(get(handles.edt_s0,'String')); %�����
It = str2num(get(handles.edt_it,'String')); %����������� �� ����
L0 = str2num(get(handles.edt_l0,'String')); %������������� ���
l1 = str2num(get(handles.edt_l1,'String')); %��������� �� �������� �� �� ������ ���� ������
l2 = str2num(get(handles.edt_l2,'String')); %��������� �� ������� �� �� ������ ���� ������
J = str2num(get(handles.edt_j,'String'));   %������ ������� ������������ ���� x � y
Jz = str2num(get(handles.edt_jz,'String')); %������ ������� ������������ ��� z 
w = str2num(get(handles.edt_w,'String'));   %�������� 

xv = x+beta*l1;
xl = x-beta*l2;
yv = y-alpha*l1;
yl = y+alpha*l2;

if (xv^2 + yv^2 <= S0^2) && (xl^2 + yl^2 <= S0^2) 
    
[A B W] = getrotor(m,S0,It,L0,l1,l2,J,Jz,w);
T1 = [0 10];

ksi0 = [alpha;beta;x;y;0;0;0;0];
[t,ksi] = ode45(@(t,ksi)valrot(t, ksi, A, B, W),T1,ksi0);
plot(t,ksi);
xlabel('Time') 
ylabel('Offset') 
legend('alpha','beta','x','y','alpha->','beta->','x->','y->',4);
else
    open('Exception.fig');
end

%cla;
%set(handles.btn_clear,'Visible','on');



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


% --- Executes on button press in btn_show_trajectory.
function btn_show_trajectory_Callback(hObject, eventdata, handles)
%========================================================================%
%%%%%%%%%%%%%%%%%%%    ��� ���������� ������� ksi    %%%%%%%%%%%%%%%%%%%%%
alpha = str2num(get(handles.edt_alpha,'String'));
beta = str2num(get(handles.edt_beta,'String'));
x = str2num(get(handles.edt_x,'String'));
y = str2num(get(handles.edt_y,'String'));
m = str2num(get(handles.edt_m,'String'));   %����� ������
S0 = str2num(get(handles.edt_s0,'String')); %�����
It = str2num(get(handles.edt_it,'String')); %����������� �� ����
L0 = str2num(get(handles.edt_l0,'String')); %������������� ���
l1 = str2num(get(handles.edt_l1,'String')); %��������� �� �������� �� �� ������ ���� ������
l2 = str2num(get(handles.edt_l2,'String')); %��������� �� ������� �� �� ������ ���� ������
J = str2num(get(handles.edt_j,'String'));   %������ ������� ������������ ���� x � y
Jz = str2num(get(handles.edt_jz,'String')); %������ ������� ������������ ��� z 
w = str2num(get(handles.edt_w,'String'));   %�������� 

xv = x+beta*l1;
xl = x-beta*l2;
yv = y-alpha*l1;
yl = y+alpha*l2;



if (xv^2 + yv^2 <= S0^2) && (xl^2 + yl^2 <= S0^2) 
    
[A B W] = getrotor(m,S0,It,L0,l1,l2,J,Jz,w);
T1 = [0 10];

ksi0 = [alpha;beta;x;y;0;0;0;0];
[t,ksi] = ode45(@(t,ksi)valrot(t, ksi, A, B, W),T1,ksi0);


%========================================================================%



%========================================================================%
%%%%%%%%%%%%%%%%%%%           ��� ��������         %%%%%%%%%%%%%%%%%%%%%%%
open('Show_trajectory.fig');

%parametr = S0*2; 
%parametr = 1; 
%v = -parametr:0.0001:parametr;
%[x,y] = meshgrid(v);  % create a grid
%ksix = 1:length(ksi);
%ksiy = 1:length(ksi);
masxv = 1:length(ksi);
masyv = 1:length(ksi);
masxl = 1:length(ksi);
masyl = 1:length(ksi);

for i = 1:length(ksi)
    %ksix(i) = ksi(i,3);
   % ksiy(i) = ksi(i,4);   
    masxv(i) = ksi(i,3)+ksi(i,2)*l1;
    masyv(i) = ksi(i,4)-ksi(i,1)*l1;
    masxl(i) = ksi(i,3)-ksi(i,2)*l2;
    masyl(i) = ksi(i,4)+ksi(i,1)*l2;
end;


DELAY = 0.00001;

 x0 = 0; 
 y0 = 0; 
 r = 4*S0; 
 x1=[]; 
 y1=[]; 

%xv = x+beta*l1;
%xl = x-beta*l2;
%yv = y-alpha*l1;
%yl = y+alpha*l2;

    %for i = 1:length(ksi)
        %clf;
       
       % axis off
        %ineq1 = (xv.^2 + yv.^2 <= S0.^2);
        %ineq1 = (x.^2 + y.^2 <= S0.^2);
        %ineq1 = (x.^2 + y.^2 <= 16*S0.^2);
        %ineq2 = (xl.^2 + yl.^2 <= S0.^2);
        %f1 = double(ineq1);
        %f2 = double(ineq2);
        %contour(x,y,f1); 
        %contour(x,y,f1,'Linecolor',[1 0.5 0]);   
       % hold on
        %contour(x,y,f2,'Linecolor',[0.7 0 0]);
       % hold on

        %for j=0:360 
         %   x1=[x1 x0+r*cos(j/180*pi)]; 
         %  y1=[y1 y0+r*sin(j/180*pi)]; 
      %  end
       % plot(x1,y1,'k');
        %axis equal
        %axis ([-0.0027 0.0027 -0.0027 0.0027])
        %axis ([-0.0006 0.0006 -0.0006 0.0006 ])
        %plot(ksix(1),ksiy(1),'ko','MarkerSize',10,'MarkerFaceColor',[1 0 0]);
        %subplot(1, 2, 1),plot(masxv(1),masyv(1),'ko','MarkerSize',10,'MarkerFaceColor',[1 0 0])
        plot(masxv(1),masyv(1),'ko','MarkerSize',10,'MarkerFaceColor',[1 0 0])
        hold on
        %plot(ksix(length(ksi)),ksiy(length(ksi)),'ko','MarkerSize',10,'MarkerFaceColor',[0 1 0]);
        %subplot(1, 2, 1),plot(masxv(length(ksi)),masyv(length(ksi)),'ko','MarkerSize',10,'MarkerFaceColor',[0 1 0]);
        plot(masxv(length(ksi)),masyv(length(ksi)),'ko','MarkerSize',10,'MarkerFaceColor',[0 1 0]);
        hold on
        %plot(ksix,ksiy);
        %subplot(1, 2, 1),plot(masxv,masyv);
        plot(masxv,masyv);
        hold on
        xlabel('Oxv') 
        ylabel('Oyv')
        legend('Start','Finish','Trajectory',4);
        title('Trajectory of motion in the upper EMP');
        hold off
        
        
       % subplot(1, 2, 2),plot(masxl(1),masyl(1),'ko','MarkerSize',10,'MarkerFaceColor',[1 0 0])
       % hold on
        %plot(ksix(length(ksi)),ksiy(length(ksi)),'ko','MarkerSize',10,'MarkerFaceColor',[0 1 0]);
       % subplot(1, 2, 2),plot(masxl(length(ksi)),masyl(length(ksi)),'ko','MarkerSize',10,'MarkerFaceColor',[0 1 0]);
       % hold on
        %plot(ksix,ksiy);
       % subplot(1, 2, 2),plot(masxl,masyl);
       % hold on
       % xlabel('Oxl') 
       % ylabel('Oyl') 
       % legend('Start','Finish','Trajectory',4);
       % title('Trajectory of motion in the lower EMP');
       % hold off
        %plot(ksix(i),ksiy(i),'ko','MarkerSize',5,'MarkerFaceColor',[0.5 0.5 0.5]);
        %axis off
        %plot(ksix(i),ksiy(i),'ko','MarkerSize',40,'MarkerFaceColor',[0.5 0.5 0.5]);
        %pause(DELAY);
   % end;

else
    open('Exception.fig');
end
%========================================================================%
