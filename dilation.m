function image = dilation(source, mask)
    
    height = size(source,1);
    width = size(source,2);
    mheight = uint16(size(mask,1)/2)-1;
    mwidth = uint16(size(mask,1)/2)-1;
    
    image = zeros(height+mheight*2, width+mwidth*2, 'uint8');
    origin = zeros(height+mheight*2, width+mwidth*2, 'uint8');
    origin(mheight+1:height+mheight,mwidth+1:width+mwidth) = source(:,:,1);
    
    for i=mheight+1:height+mheight
        for j=mwidth+1:width+mwidth
            val = uint16(0);
            for k=-mheight:mheight
                for l=-mwidth:mwidth
                    if origin(i+k,j+l) == 255
                        if mask(k+mheight+1,l+mwidth+1) == 1
                            val = 1;
                        end
                    end
                end
            end
            if val == 1
                image(i,j) = 255;
            end
        end
    end
    
    image = image(mheight+1:height+mheight,mwidth+1:width+mwidth);
    