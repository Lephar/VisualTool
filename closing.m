function image = closing(source, mask, dcnt, ecnt)

    image = source;
    
    for i=1:dcnt
        image = dilation(image,mask);
    end
    
    for i=1:ecnt
        image = erosion(image,mask);
    end
    