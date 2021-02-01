function result = transp(source)

    if size(source,3)<3
        source = torgb(source);
    end
    
    height = size(source,1);
    width = size(source,2);
    
    result = zeros(width, height, 3, 'uint8');
    
    for i=1:width
        result(i,:,:) = source(:,i,:);
    end
    