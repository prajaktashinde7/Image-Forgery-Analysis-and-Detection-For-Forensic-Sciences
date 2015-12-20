I=imread('doc.jpg');
I=rgb2gray(I);
BW2 = edge(I,'canny');
imshow(BW2);

I=imread('doc2.jpg');
I=rgb2gray(I);
figure;
BW2 = edge(I,'canny');
imshow(BW2);