function [ XYpairCor ] = getMatchedPairCor( a ,Nn ,Nf ,Nd )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

count=0;
for i = 1 : 1 : (length(a)-Nn)
    for j = i+1 : 1 : i+Nn
        count = count + 1;
        list(:,count) = [a(1,i) a(2,i) a(1,j) a(2,j)];
        xoffset = abs((a(1,i)-a(1,j)));
        yoffset = abs((a(2,i)-a(2,j)));
        if(xoffset == 0)
            xoffset = max(max(a));
        end
        if(yoffset == 0)
            yoffset = max(max(a));
        end    
        offset(:,count) = [ xoffset yoffset ];
    end
end
disp(count);
offsetFreq = zeros(max(max(a)) ,max(max(a)) );
for i = 1 : 1 : length(offset)
    offsetFreq( offset(1,i) , offset(2,i) ) = offsetFreq( offset(1,i) , offset(2,i) ) + 1;
end

count = 0;
for i = 1 : 1 : length(offset)
    if( offsetFreq( offset(1,i) , offset(2,i) ) > Nf)
        count = count + 1;
        list1(:,count) = list(:,i);
    end
end
clear xoffset yoffset list offset offsetFreq 
disp(count);
count=0;

for i = 1 : 1 : length(list1)
    offsetMag= sqrt((list1(1,i)-list1(3,i))^2+(list1(2,i)-list1(4,i))^2);
    if( offsetMag > Nd)
        count = count + 1;
        XYpairCor(:,count) = list1(:,i);
    end
end
disp(count);
if (count==0)
    XYpairCor(:,1)=0;
end
 clear list1 count  offsetMag i
end