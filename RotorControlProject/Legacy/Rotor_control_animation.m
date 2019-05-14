function varargout = Rotor_control_animation(varargin)
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

% Last Modified by GUIDE v2.5 03-Jun-2017 15:48:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Rotor_control_animation_OpeningFcn, ...
                   'gui_OutputFcn',  @Rotor_control_animation_OutputFcn, ...
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
function Rotor_control_animation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Rotor_control_animation (see VARARGIN)

% Choose default command line output for Rotor_control_animation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Rotor_control_animation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Rotor_control_animation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
