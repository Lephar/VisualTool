function varargout = GenerateMask(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GenerateMask_OpeningFcn, ...
                   'gui_OutputFcn',  @GenerateMask_OutputFcn, ...
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

function GenerateMask_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = GenerateMask_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function height_Callback(hObject, eventdata, handles)

function height_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function width_Callback(hObject, eventdata, handles)

function width_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function inittable_Callback(hObject, eventdata, handles)

function cancel_Callback(hObject, eventdata, handles)
close;

function generate_Callback(hObject, eventdata, handles)
height = str2num(get(handles.height,'String'));
width = str2num(get(handles.width,'String'));
InitializeMask(height,width);
close GenerateMask;
