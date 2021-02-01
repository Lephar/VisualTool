function image = veil(source, mask)
    
    height = size(source,1);
    width = size(source,2);
    mheight = uint16(size(mask,1)/2)-1;
    mwidth = uint16(size(mask,1)/2)-1;
    threshold = 128;
    
    image = zeros(height+mheight*2, width+mwidth*2, 'uint8');
    origin = zeros(height+mheight*2, width+mwidth*2, 'uint8');
    origin(mheight+1:height+mheight,mwidth+1:width+mwidth) = source(:,:,1);
    
    for i=mheight+1:height+mheight
        for j=mwidth+1:width+mwidth
            val = int16(0);
            for k=-mheight:mheight
                for l=-mwidth:mwidth
                    val = val + int16(origin(i+k,j+l)) * mask(k+mheight+1,l+mwidth+1);
                end
            end
            image(i,j) = uint8(255 * (threshold < abs(val)));
        end
    end
    