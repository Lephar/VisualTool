function varargout = CameraMode(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CameraMode_OpeningFcn, ...
                   'gui_OutputFcn',  @CameraMode_OutputFcn, ...
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

function CameraMode_OpeningFcn(hObject, eventdata, handles, varargin)
global cam;
global rec;
global mode;
global mask;
global status;
global source;

rec = 0;
mode = 1;
status = 0;
cam = webcam;
mask = zeros(3,3,'uint8');
source = zeros(640, 480, 3, 'uint8');

handles.output = hObject;
guidata(hObject, handles);

function varargout = CameraMode_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function connect_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 1;
mode = 1;
addrs = get(handles.addr,'String');
if ~isequal(addrs,'10.0.0.1')
    mode = 0;
    url = strcat('http://',addrs);
    url = strcat(url,':8080/shot.jpg');
end

while status == 1
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(img);
    drawnow;
end

function plane_CloseRequestFcn(hObject, eventdata, handles)
global status;
status = 0;
delete(hObject);

function genmask_Callback(hObject, eventdata, handles)
GenerateMask;

function tobinary_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 2;

while status == 2;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(tobin(img)));
    drawnow;
end

function togray_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 3;

while status == 3;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(togry(img)));
    drawnow;
end

function union_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global source;
global status;

rec = status;
status = 4;

while status == 4;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(union(tobin(img),source)));
    drawnow;
end

function intersection_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global source;
global status;

rec = status;
status = 5;

while status == 5;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(intersection(tobin(img),source)));
    drawnow;
end

function close_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global mask;
global status;

rec = status;
status = 9;
param1 = str2num(get(handles.clos1,'String'));
param2 = str2num(get(handles.clos2,'String'));

while status == 9;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(closing(tobin(img),mask,param1,param2)));
    drawnow;
end

function open_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global mask;
global status;

rec = status;
status = 8;
param1 = str2num(get(handles.open1,'String'));
param2 = str2num(get(handles.open2,'String'));

while status == 8;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(opening(tobin(img),mask,param1,param2)));
    drawnow;
end

function erosion_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global mask;
global status;

rec = status;
status = 6;

while status == 6;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(erosion(tobin(img),mask)));
    drawnow;
end

function dilation_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global mask;
global status;

rec = status;
status = 7;

while status == 7;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(dilation(tobin(img),mask)));
    drawnow;
end

function flipx_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 14;

while status == 14;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(flipx(img));
    drawnow;
end

function flipy_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 15;

while status == 15;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(flipy(img));
    drawnow;
end

function trans_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 16;

while status == 16;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(transp(img));
    drawnow;
end

function rotate_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 16;
ang = str2num(get(handles.angl,'String'));

while status == 16;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(imrotate(img,ang));
    drawnow;
end

function back_Callback(hObject, eventdata, handles)
global status;
status = 0;
VisualTool;
close CameraMode;

function save_Callback(hObject, eventdata, handles)
image = getframe(handles.axes1);
imwrite(frame2im(image),'files/camsnapshot.png');

function undo_Callback(hObject, eventdata, handles)
global rec;
global status;
status = rec;

function mirror_Callback(hObject, eventdata, handles)
global cam;
global url;
global mode;
global rec;
global status;

rec = status;
status = 10;

while status == 10;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(mirror(img));
    drawnow;
end

function smooth_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 17;

while status == 17;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(smooth(img));
    drawnow;
end

function lap4_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 12;

while status == 12;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(lap4(img)));
    drawnow;
end

function sobel_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 11;

while status == 11;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(sobel(img)));
    drawnow;
end

function lap8_Callback(hObject, eventdata, handles)
global cam;
global rec;
global url;
global mode;
global status;

rec = status;
status = 13;

while status == 13;
    if mode
        img = snapshot(cam);
    else
        img = imread(url);
    end
    image(torgb(lap8(img)));
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
