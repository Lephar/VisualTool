function image = lap4(source)

    height = size(source,1);
    width = size(source,2);
    threshold = 48;

    image = zeros(height+2, width+2, 'uint8');
    origin = zeros(height+2, width+2, 'uint8');
    origin(2:height+1,2:width+1) = source(:,:,1);

    mask = int16([0 -1 0; -1 4 -1; 0 -1 0]);
    
    for i=2:height+1
        for j=2:width+1
            val = int16(0);
            for k=-1:1
                for l=-1:1
                    val = val + mask(k+2,l+2) * int16(origin(i+k,j+l));
                end
            end
            image(i,j) = uint8(255 * (abs(val) > threshold));
        end
    end
    