function image = grytobin(source)
    
    if 1<size(source,3)
        source = rgbtogry(source);
    end
    
    height = size(source,1);
    width = size(source,2);
    
    val = double(0);
    image = zeros(height, width, 'uint8');
    for i=1:height
        for j=1:width
            val = val + source(i,j);
        end
    end
    
    val = val / (height*width);
    
    for i=1:height
        for j=1:width
            if val < source(i,j);
                image(i,j) = 255;
            end
        end
    end
    