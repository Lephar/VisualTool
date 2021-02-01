function varargout = VideoMode(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VideoMode_OpeningFcn, ...
                   'gui_OutputFcn',  @VideoMode_OutputFcn, ...
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

function VideoMode_OpeningFcn(hObject, eventdata, handles, varargin)
global rec;
global mask;
global status;
global source;

rec = 0;
status = 0;
mask = zeros(3,3,'uint8');
source = zeros(640, 480, 3, 'uint8');

handles.output = hObject;
guidata(hObject, handles);

function varargout = VideoMode_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function loadvid_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 1;

[filename,pathname]=uigetfile('*');
if ~isequal(0,filename)
    address = strcat(pathname,filename);
    video = VideoReader(address);
end

while hasFrame(video) && status == 1
    frame = readFrame(video);
    image(frame);
    drawnow;
end

function plane_CloseRequestFcn(hObject, eventdata, handles)
global status;
status = 0;
delete(hObject);

function genmask_Callback(hObject, eventdata, handles)
GenerateMask;

function tobinary_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 2;

while hasFrame(video) && status == 2;
    frame = readFrame(video);
    image(torgb(tobin(frame)));
    drawnow;
end

function togray_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 3;

while hasFrame(video) && status == 3;
    frame = readFrame(video);
    image(torgb(togry(frame)));
    drawnow;
end

function union_Callback(hObject, eventdata, handles)
global rec;
global video;
global source;
global status;

rec = status;
status = 4;

while hasFrame(video) && status == 4;
    frame = readFrame(video);
    image(torgb(union(tobin(frame),source)));
    drawnow;
end

function intersection_Callback(hObject, eventdata, handles)
global rec;
global video;
global source;
global status;

rec = status;
status = 5;

while hasFrame(video) && status == 5;
    frame = readFrame(video);
    image(torgb(intersection(tobin(frame),source)));
    drawnow;
end

function close_Callback(hObject, eventdata, handles)
global rec;
global video;
global mask;
global status;

rec = status;
status = 9;
param1 = str2num(get(handles.clos1,'String'));
param2 = str2num(get(handles.clos2,'String'));

while hasFrame(video) && status == 9;
    frame = readFrame(video);
    image(torgb(closing(tobin(frame),mask,param1,param2)));
    drawnow;
end

function open_Callback(hObject, eventdata, handles)
global rec;
global video;
global mask;
global status;

rec = status;
status = 8;
param1 = str2num(get(handles.open1,'String'));
param2 = str2num(get(handles.open2,'String'));

while hasFrame(video) && status == 8;
    frame = readFrame(video);
    image(torgb(opening(tobin(frame),mask,param1,param2)));
    drawnow;
end

function erosion_Callback(hObject, eventdata, handles)
global rec;
global video;
global mask;
global status;

rec = status;
status = 6;

while hasFrame(video) && status == 6;
    frame = readFrame(video);
    image(torgb(erosion(tobin(frame),mask)));
    drawnow;
end

function dilation_Callback(hObject, eventdata, handles)
global rec;
global video;
global mask;
global status;

rec = status;
status = 7;

while hasFrame(video) && status == 7;
    frame = readFrame(video);
    image(torgb(dilation(tobin(frame),mask)));
    drawnow;
end

function flipx_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 14;

while hasFrame(video) && status == 14;
    frame = readFrame(video);
    image(flipx(frame));
    drawnow;
end

function flipy_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 15;

while hasFrame(video) && status == 15;
    frame = readFrame(video);
    image(flipy(frame));
    drawnow;
end

function trans_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 16;

while hasFrame(video) && status == 16;
    frame = readFrame(video);
    image(transp(frame));
    drawnow;
end

function rotate_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 16;
ang = str2num(get(handles.angl,'String'));

while hasFrame(video) && status == 16;
    frame = readFrame(video);
    image(imrotate(frame,ang));
    drawnow;
end

function back_Callback(hObject, eventdata, handles)
global status;
status = 0;
VisualTool;
close VideoMode;

function save_Callback(hObject, eventdata, handles)
image = getframe(handles.axes1);
imwrite(frame2im(image),'files/vidsnapshot.png');

function undo_Callback(hObject, eventdata, handles)
global rec;
global status;
status = rec;

function mirror_Callback(hObject, eventdata, handles)
global video;
global rec;
global status;

rec = status;
status = 10;

while hasFrame(video) && status == 10;
    frame = readFrame(video);
    image(mirror(frame));
    drawnow;
end

function smooth_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 17;

while hasFrame(video) && status == 17;
    frame = readFrame(video);
    image(smooth(frame));
    drawnow;
end

function lap4_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 12;

while hasFrame(video) && status == 12;
    frame = readFrame(video);
    image(torgb(lap4(frame)));
    drawnow;
end

function sobel_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 11;

while hasFrame(video) && status == 11;
    frame = readFrame(video);
    image(torgb(sobel(frame)));
    drawnow;
end

function lap8_Callback(hObject, eventdata, handles)
global rec;
global video;
global status;

rec = status;
status = 13;

while hasFrame(video) && status == 13;
    frame = readFrame(video);
    image(torgb(lap8(frame)));
    drawnow;
end

function loadimage_Callback(hObject, eventdata, handles)
global source;
[filename,pathname]=uigetfile('*');
if ~isequal(0,filename)
    address = strcat(pathname,filename);
    source = imread(address);
end

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
function angl_Callback(hObject, eventdata, handles)
function angl_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function addr_Callback(hObject, eventdata, handles)
function addr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
