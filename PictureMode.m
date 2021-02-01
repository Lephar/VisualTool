function varargout = PictureMode(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PictureMode_OpeningFcn, ...
                   'gui_OutputFcn',  @PictureMode_OutputFcn, ...
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

function PictureMode_OpeningFcn(hObject, eventdata, handles, varargin)
global mask;
global source;
global source2;
global recovery;
mask = zeros(3,3,'uint8');
mask(2,2) = 1;
source = ones(480,640,3,'uint8');
source2 = ones(480,640,3,'uint8');
recovery = ones(480,640,3,'uint8');
draw(source);
handles.output = hObject;
guidata(hObject, handles);

function varargout = PictureMode_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function loadimage1_Callback(hObject, eventdata, handles)
global source;
global recovery;
[filename,pathname]=uigetfile('*');
if ~isequal(0,filename)
    address = strcat(pathname,filename);
    recovery = source;
    source = imread(address);
    imshow(source);
end

function loadimage2_Callback(hObject, eventdata, handles)
global source2;
[filename,pathname]=uigetfile('*');
if ~isequal(0,filename)
    address = strcat(pathname,filename);
    source2 = imread(address);
end

function genmask_Callback(hObject, eventdata, handles)
GenerateMask;

function erosion_Callback(hObject, eventdata, handles)
global mask;
global source;
global recovery;
recovery = source;
source = erosion(source,mask);
imshow(source);

function union_Callback(hObject, eventdata, handles)
global source;
global source2;
global recovery;
recovery = source;
source = union(source,source2);
imshow(source);

function open_Callback(hObject, eventdata, handles)
global mask;
global source;
global recovery;
recovery = source;
param1 = str2num(get(handles.open1,'String'));
param2 = str2num(get(handles.open2,'String'));
source = opening(source,mask,param1,param2);
imshow(source);

function intersection_Callback(hObject, eventdata, handles)
global source;
global source2;
global recovery;
recovery = source;
source = intersection(source,source2);
imshow(source);

function dilation_Callback(hObject, eventdata, handles)
global mask;
global source;
global recovery;
recovery = source;
source = dilation(source,mask);
imshow(source);

function open1_Callback(hObject, eventdata, handles)

function open1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function open2_Callback(hObject, eventdata, handles)

function open2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function clos1_Callback(hObject, eventdata, handles)

function clos1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function clos2_Callback(hObject, eventdata, handles)

function clos2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function close_Callback(hObject, eventdata, handles)
global mask;
global source;
global recovery;
recovery = source;
param1 = str2num(get(handles.clos1,'String'));
param2 = str2num(get(handles.clos2,'String'));
source = closing(source,mask,param1,param2);
imshow(source);

function mirrorx_Callback(hObject, eventdata, handles)
global source;
global recovery;
recovery = source;
source = flipx(source);
imshow(source);

function mirrory_Callback(hObject, eventdata, handles)
global source;
global recovery;
recovery = source;
source = flipy(source);
imshow(source);

function trans_Callback(hObject, eventdata, handles)
global source;
global recovery;
recovery = source;
source = transp(source);
imshow(source);

function rotate_Callback(hObject, eventdata, handles)
global source;
global recovery;
recovery = source;
ang = str2num(get(handles.angl,'String'));
source = imrotate(source,ang);
imshow(source);

function angl_Callback(hObject, eventdata, handles)

function angl_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tobinary_Callback(hObject, eventdata, handles)
global source;
global source2;
global recovery;
recovery = source;
source = tobin(source);
source2 = tobin(source2);
imshow(source);

function togray_Callback(hObject, eventdata, handles)
global source;
global source2;
global recovery;
recovery = source;
source = togry(source);
source2 = togry(source2);
imshow(source);

function back_Callback(hObject, eventdata, handles)
VisualTool;
close PictureMode;

function save_Callback(hObject, eventdata, handles)
global source;
imwrite(source,'files/output.bmp');

function undo_Callback(hObject, eventdata, handles)
global source;
global recovery;
source = recovery;
imshow(source);

function mirror_Callback(hObject, eventdata, handles)
global source;
global recovery;
recovery = source;
source = mirror(source);
imshow(source);

function lap4_Callback(hObject, eventdata, handles)
global source;
global recovery;
recovery = source;
source = lap4(source);
imshow(source);

function sobel_Callback(hObject, eventdata, handles)
global source;
global recovery;
recovery = source;
source = sobel(source);
imshow(source);

function lap8_Callback(hObject, eventdata, handles)
global source;
global recovery;
recovery = source;
source = lap8(source);
imshow(source);


% --- Executes on button press in smooth.
function smooth_Callback(hObject, eventdata, handles)
global source;
global recovery;
recovery = source;
source = smooth(source);
imshow(source);