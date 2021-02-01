function result = torgb(source)

    height = size(source,1);
    width = size(source,2);
    
    result = zeros(height, width, 3, 'uint8');
    
    for i=1:3
        result(:,:,i) = source(:,:);
    end