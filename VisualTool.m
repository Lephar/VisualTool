function varargout = VisualTool(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VisualTool_OpeningFcn, ...
                   'gui_OutputFcn',  @VisualTool_OutputFcn, ...
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

function VisualTool_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = VisualTool_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function picturemode_Callback(hObject, eventdata, handles)
PictureMode;
close VisualTool;

function videomode_Callback(hObject, eventdata, handles)
VideoMode;
close VisualTool;

function cameramode_Callback(hObject, eventdata, handles)
CameraMode;
close VisualTool;

function exitbutton_Callback(hObject, eventdata, handles)
close all;