function result = togry(source)

    height = size(source,1);
    width = size(source,2);
    
    if size(source,3)<3
        result = source;
    else
        result = zeros(height, width, 'uint8');

        for i=1:height
            for j=1:width
                result(i,j) = uint8((uint16(source(i,j,1))+uint16(source(i,j,2))+uint16(source(i,j,3)))/3);
            end
        end
    end
    
    %result = torgb(result);