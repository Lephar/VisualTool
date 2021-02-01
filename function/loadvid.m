while 1
    video = VideoReader('data/bnw.mp4');
    while hasFrame(video)
        frame = readFrame(video);
        image(frame);
        drawnow;
    end
end