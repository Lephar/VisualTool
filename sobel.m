function image = sobel(source)

    threshold = 128;
    height = size(source,1);
    width = size(source,2);

    sobvert = zeros(height+2, width+2, 'uint8');
    sobhorz = zeros(height+2, width+2, 'uint8');
    image = zeros(height+2, width+2, 'uint8');
    origin = zeros(height+2, width+2, 'uint8');
    origin(2:height+1,2:width+1) = source(:,:,1);

    mvert = [-1 0 1; -2 0 2; -1 0 1];
    mhorz = [-1 -2 -1; 0 0 0; 1 2 1];

    for i=2:height+1
        for j=2:width+1
            val1 = int16(0);
            val2 = int16(0);
            for k=-1:1
                for l=-1:1
                    val1 = val1 + mvert(k+2,l+2) * int16(origin(i+k,j+l));
                    val2 = val2 + mhorz(k+2,l+2) * int16(origin(i+k,j+l));
                end
            end
            sobvert(i,j) = uint8(255 * (threshold < abs(val1)));
            sobhorz(i,j) = uint8(255 * (threshold < abs(val2)));
            image(i,j) = uint8(sobvert(i,j) + sobhorz(i,j));
        end
    end
    