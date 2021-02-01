function result = flipy(source)

    if size(source,3)<3
        source = torgb(source);
    end
    
    height = size(source,1);
    width = size(source,2);
    
    result = zeros(height, width, 3, 'uint8');
    
    for i=1:width
        result(:,i,:) = source(:,width-i+1,:);
    end
    