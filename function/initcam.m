cam = webcam;
while 1
    img = snapshot(cam);
    image(img);
    drawnow;
end