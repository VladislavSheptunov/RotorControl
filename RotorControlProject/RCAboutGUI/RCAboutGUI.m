function varargout = RCAboutGUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RCAboutGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @RCAboutGUI_OutputFcn, ...
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

function RCAboutGUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

function varargout = RCAboutGUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function RCAboutGUI_CreateFcn(hObject, eventdata, handles)
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');

handles = guihandles(hObject);

%PATH = strcat(fileparts(mfilename('fullpath')), '..\Resource\emp.jpg');

jFrame=get(handle(handles.RCAboutGUI), 'javaframe');
jicon=javax.swing.ImageIcon('D:\RotorControl\RotorControlProject\Resource\emp.jpg');
%jicon=javax.swing.ImageIcon(PATH);
jFrame.setFigureIcon(jicon);

handles = guihandles(hObject);

PATH = strcat(fileparts(mfilename('fullpath')), '\RotorControl.txt');

txt_fileAbout = fopen(PATH, 'rt');

if txt_fileAbout ~= 1
    txt_fileAbout = fscanf(txt_fileAbout, '%c');
    set(handles.text1, 'String', txt_fileAbout);
end

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
