function varargout = RCAnimationGUI(varargin)
% ROTOR_CONTROL_ANIMATION M-file for Rotor_control_animation.fig
%      ROTOR_CONTROL_ANIMATION, by itself, creates a new ROTOR_CONTROL_ANIMATION or raises the existing
%      singleton*.
%
%      H = ROTOR_CONTROL_ANIMATION returns the handle to a new ROTOR_CONTROL_ANIMATION or the handle to
%      the existing singleton*.
%
%      ROTOR_CONTROL_ANIMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTOR_CONTROL_ANIMATION.M with the given input arguments.
%
%      ROTOR_CONTROL_ANIMATION('Property','Value',...) creates a new ROTOR_CONTROL_ANIMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Rotor_control_animation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Rotor_control_animation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Rotor_control_animation

% Last Modified by GUIDE v2.5 13-May-2019 20:59:51

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT

% --- Executes just before Rotor_control_animation is made visible.
function RCAnimationGUI_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for Rotor_control_animation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = RCAnimationGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function RCAnimationGUI_CreateFcn(hObject, eventdata, handles)
% https://www.mathworks.com/help/vision/ref/insertshape.html#btppvxj-1-shape

%handles = guihandles(hObject);

RCParameters = GetRCParameters();
RCStab = GetRCStabilisation();

ksi = RCStab.vecKSI;

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

for i = 1:length(ksi)

tmpX = centerX + masxv(i) * 10^4;
tmpY = centerY + masyv(i) * 10^4;

RGB = insertShape(Im, 'FilledCircle', [tmpX tmpY centerR], 'LineWidth', 15, 'Color', [0.5 0.5 0.5]);

imshow(RGB);

pause(DELAY);
end

% for i = 1:length(ksi)
%     clf;
%     
%     for j=0:360 
%         x1 = [x1 x0+r*cos(j/180*pi)]; 
%         y1 = [y1 y0+r*sin(j/180*pi)]; 
%     end
%     
%     plot(x1,y1,'k','LineWidth',8);
%     axis equal
%     axis ([-0.0027 0.0027 -0.0027 0.0027])
% 
%     title('The inner ring of the upper EMP');
%     hold on
% 
%     plot(masxv(i),masyv(i),'ko','MarkerSize',255,'MarkerFaceColor',[0.5 0.5 0.5]);
%     axis off
%         
%     pause(DELAY);
% end

% close(handles.rc_animation_gui);
