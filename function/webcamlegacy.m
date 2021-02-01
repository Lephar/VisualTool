cam = videoinput('winvideo',1,'YUY2_640x480');
set(cam,'ReturnedColorSpace','rgb');
set(cam,'FramesPerTrigger',1);
set(cam,'TriggerRepeat',Inf);
triggerconfig(cam,'manual');
start(cam);

global key;
key = 0;
set(gcf, 'KeyPressFcn', @keypress)

while ~key
    img = getsnapshot(cam);
    %imagesc(rgbtogry(img));
    imagesc(mirror(img));
end

stop(cam);
close all;
