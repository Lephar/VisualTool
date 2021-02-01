function image = union(source1, source2)
    
    height = size(source1,1);
    width = size(source1,2);
     
    image = zeros(height, width, 'uint8');
    
    for i=1:height
        for j=1:width
            if source1(i,j) == 255 || source2(i,j) == 255
                image(i,j) = 255;
            end
        end
    end
    