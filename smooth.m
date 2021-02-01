function image = smooth(source)

height = size(source,1);
width = size(source,2);

image = zeros(height+2, width+2, 3, 'uint8');
origin = zeros(height+2, width+2, 3, 'uint8');
origin(2:height+1,2:width+1,:) = source(:,:,:);

mask = int16([1 1 1; 1 1 1; 1 1 1]);

for i=2:height+1
    for j=2:width+1
        val1 = int16(0);
        val2 = int16(0);
        val3 = int16(0);
        for k=-1:1
            for l=-1:1
                val1 = val1 + mask(k+2,l+2) * int16(origin(i+k,j+l,1));
                val2 = val2 + mask(k+2,l+2) * int16(origin(i+k,j+l,2));
                val3 = val3 + mask(k+2,l+2) * int16(origin(i+k,j+l,3));
            end
        end
        image(i,j,1) = uint8(val1/9);
        image(i,j,2) = uint8(val2/9);
        image(i,j,3) = uint8(val3/9);
    end
end
