function image = mirror(source)

    [r,c,d]=size(source);
    image=zeros(r,c,d,'uint8');

    for j=1 : c 
        %sin(4*pi*i/r-pi/2)+1;
        val = round(j*(1+sin(2*pi*j/c)/2));
        for i=1:r
            for k=1 :d
                image(i,j,k)=source(i,val,k);
            end
        end
    end