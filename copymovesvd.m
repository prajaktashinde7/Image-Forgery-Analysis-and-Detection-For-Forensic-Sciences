clear all
clc

%  forged_img = imread('kittens1.jpg');
%  Nn=15; Nf=128; Nd=100;
 
%  forged_img = imread('twins.jpg');
%  Nn=10; Nf=180; Nd=130;
 
%  forged_img = imread('arrows.jpg');
%  Nn=15; Nf=128; Nd=100;
 
%  forged_img = imread('crime_scene1.jpg');
%  Nn=15; Nf=128; Nd=100;

%  forged_img = imread('cars.jpg');
%  Nn=10; Nf=128; Nd=100;

 forged_img = imread('evi.jpg');
 Nn=20; Nf=110; Nd=110;

%  forged_img = imread('planes.jpg');
%  Nn=10; Nf=128; Nd=100;

figure;
imshow(forged_img);
a = rgb2gray(forged_img);
[row col] = size(a);
disp(row);
disp(col);
b=8;
i=1;

for x=1:1:(row-b)
    for y=1:1:(col-b)
        row1 = x;
		row2 = row1 + b - 1;
		col1 = y;
		col2 = col1 + b - 1;
        Block = svd(double(a(row1:row2, col1:col2)));        
        B(i) = Block(1);
        xycor(:,i) = [x y];
        i = i + 1;
    end;
end
disp(i);

for ii=1:1:length(B)
        newB(ii) = {num2str(B(ii))};
end

disp('sorting');
[SortBlock SortIndex] = sort(newB);
Sortxycor = xycor(:,SortIndex);
disp('sorting done');

clear Block B newB xycor SortIndex SortBlock ii ij i row1 row2 col1 col2 x y a

XYcorPair = getMatchedPairCor(Sortxycor , Nn ,Nf ,Nd );

clear Sortxycor Nn Nf Nd

copyPart = uint8(zeros(row, col, 3));
redblock = uint8(zeros(b,b,3));
for i= 1: b
    for j=1:b        
        redblock(i,j,:)=[255 0 0];
    end
end

[ XYcorPairRow XYcorPairCol ] = size(XYcorPair);
if (XYcorPairCol ~= 1)
    for i = 1 : 1: XYcorPairCol
%         copyPart(XYcorPair(1,i):(XYcorPair(1,i)+b-1) , XYcorPair(2,i):(XYcorPair(2,i)+b-1),:) = forged_img(XYcorPair(1,i):(XYcorPair(1,i)+b-1) , XYcorPair(2,i):(XYcorPair(2,i)+b-1),:);
%         copyPart(XYcorPair(3,i):(XYcorPair(3,i)+b-1) , XYcorPair(4,i):(XYcorPair(4,i)+b-1),:) = forged_img(XYcorPair(3,i):(XYcorPair(3,i)+b-1) , XYcorPair(4,i):(XYcorPair(4,i)+b-1),:);
        copyPart(XYcorPair(1,i):(XYcorPair(1,i)+b-1) , XYcorPair(2,i):(XYcorPair(2,i)+b-1),:) =redblock;
        copyPart(XYcorPair(3,i):(XYcorPair(3,i)+b-1) , XYcorPair(4,i):(XYcorPair(4,i)+b-1),:) =redblock;
    end
end
figure;
imshow(copyPart);

imwrite(copyPart,'eviresult.jpg','jpg');