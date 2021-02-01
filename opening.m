function image = opening(source, mask, ecnt, dcnt)

    image = source;
    
    for i=1:ecnt
        image = erosion(image,mask);
    end
    
    for i=1:dcnt
        image = dilation(image,mask);
    end
    