function image = mirror(source)

    [r,c,d]=size(source);
    image=zeros(r,c,d,'uint8');
    
    for i=1 : r
        val = sin(4*pi*i/r-pi/2)+1;
        display(val);
        for j=1 :c
            for k=1 :d
                image(i,j,k)=source(uint16(val),j,k);
            end
        end
    end