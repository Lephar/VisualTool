function varargout = InitializeMask(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InitializeMask_OpeningFcn, ...
                   'gui_OutputFcn',  @InitializeMask_OutputFcn, ...
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

function InitializeMask_OpeningFcn(hObject, eventdata, handles, varargin)

global maskh;
global maskw;
maskh = varargin{1};
maskw = varargin{2};
global mask;
maskrec = mask;
mask = zeros(maskh, maskw, 'uint8');

handles.output = hObject;

guidata(hObject, handles);

function varargout = InitializeMask_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function rownum_Callback(hObject, eventdata, handles)

function rownum_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function colnum_Callback(hObject, eventdata, handles)

function colnum_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function value_Callback(hObject, eventdata, handles)

function value_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function update_Callback(hObject, eventdata, handles)
global mask;
global maskh;
global maskw;
rown = str2num(get(handles.rownum,'String'));
coln = str2num(get(handles.colnum,'String'));
val = str2num(get(handles.value,'String'));
mask(rown,coln) = val;
coln = coln + 1;
if coln == maskw + 1
    coln = 1;
    rown = rown + 1;
end
if rown == maskh + 1
    rown = 1;
end
set(handles.colnum,'String',coln)
set(handles.rownum,'String',rown)
set(handles.value,'String',0)
    
function cancel_Callback(hObject, eventdata, handles)
global mask;
mask = maskrec;
close;

function complete_Callback(hObject, eventdata, handles)
global mask;
display(mask);
close;