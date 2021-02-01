function image = grytorgb(source)

    height = size(source,1);
    width = size(source,2);
    
    image = zeros(height, width, 3, uint8);
    
    for i=1:3
        image(:,:,i) = source(:,:);
    end