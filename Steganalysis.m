clear all
clc
stg = imread('img.png');
imshow(stg);
figure;
stg=double(stg);
img=stg;
[row col]=size(stg);
for z=1:1:8
    for x=1:1:row
        for y=1:1:col
            c=dec2bin(stg(x,y),8);
            d=c(z);
            img(x,y)=double(d);
            if img(x,y)==49
                img(x,y)=255;
            else
                img(x,y)=0;
            end
        end
    end
subplot(3,3,z);
imshow(uint8(img));
end
