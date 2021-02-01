function result = tobin(source)

    if 1<size(source,3)
        source = togry(source);
    end
    
    height = size(source,1);
    width = size(source,2);
    
    val = double(0);
    result = zeros(height, width, 'uint8');
    for i=1:height
        for j=1:width
            val = val + double(source(i,j));
        end
    end
    
    val = val / (height*width);
    
    for i=1:height
        for j=1:width
            if val < source(i,j);
                result(i,j) = 255;
            end
        end
    end
    
    %result = torgb(result);
