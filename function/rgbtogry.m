function image = rgbtogry(source)

    height = size(source,1);
    width = size(source,2);
    
    image = zeros(height, width, 'uint8');
    
    for i=1:height
        for j=1:width
            image(i,j) = uint8((uint16(source(i,j,1))+uint16(source(i,j,2))+uint16(source(i,j,3)))/3);
        end
    end
            