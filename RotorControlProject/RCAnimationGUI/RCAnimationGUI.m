function varargout = RCAnimationGUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RCAnimationGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @RCAnimationGUI_OutputFcn, ...
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

function RCAnimationGUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

function varargout = RCAnimationGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function RCAnimationGUI_CreateFcn(hObject, eventdata, handles)
% https://www.mathworks.com/help/vision/ref/insertshape.html#btppvxj-1-shape

warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');

handles = guihandles(hObject);

%PATH = strcat(fileparts(mfilename('fullpath')), '..\Resource\emp.jpg');

jFrame=get(handle(handles.RCAnimationGUI), 'javaframe');
jicon=javax.swing.ImageIcon('D:\RotorControl\RotorControlProject\Resource\emp.jpg');
%jicon=javax.swing.ImageIcon(PATH);
jFrame.setFigureIcon(jicon);

RCParameters = GetRCParameters();
RCStab = GetRCStabilisation();
RCTimeStab = GetRCTimeStabilisation(RCStab);

if RCTimeStab.index > 0
ksi = RCStab.vecKSI(1:RCTimeStab.index, :);
else
ksi = RCStab.vecKSI;
end

masxv = 1:length(ksi);
masyv = 1:length(ksi);
masxl = 1:length(ksi);
masyl = 1:length(ksi);

for i = 1:length(ksi)
    masxv(i) = ksi(i,3) + ksi(i,2) * RCParameters.SpecificModel.l1;
    masyv(i) = ksi(i,4) - ksi(i,1) * RCParameters.SpecificModel.l1;
    masxl(i) = ksi(i,3) - ksi(i,2) * RCParameters.SpecificModel.l2;
    masyl(i) = ksi(i,4) + ksi(i,1) * RCParameters.SpecificModel.l2;
end

[Im, ~, ~] = imread('D:\RotorControl\RotorControlProject\Resource\empF.png');

centerX = 324;
centerY = 316;
centerR = 170;

DELAY = 0.005;
st = 10^4.3;

for i = 1:length(ksi)

tmpX = centerX + masxv(i) * st;
tmpY = centerY + masyv(i) * st;

RGB = insertShape(Im, 'FilledCircle', [tmpX tmpY centerR], 'LineWidth', 15, 'Color', [0.5 0.5 0.5]);

imshow(RGB);

pause(DELAY);
end
