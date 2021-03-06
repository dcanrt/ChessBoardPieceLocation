function PiecesLocation=piece_location(BW,sorted_points)

corner_points = zeros(4,2);

Imask = zeros(120,120);
PtsMask = [1 1;
    120 1;
    120 120;
    1 120];

PiecesLocation = [];
x=1;
figure;
while(x<length(sorted_points)) %kesiþim noktalarýna göre kareler kontrol edilir
for i=x:x+7
    dump = i+1;
    if(dump + 9 >= length(sorted_points))
        break
    end
    corner_points(1,:)  = sorted_points(i,:);
    corner_points(2,:)  = sorted_points(dump,:);
    corner_points(3,:)  = sorted_points(dump+9,:); 
    corner_points(4,:)  = sorted_points(i+9,:);
   
% Cropped image
  Tmask1 = fitgeotrans(corner_points,PtsMask , 'similarity');
  cropped_img = imwarp(BW, Tmask1, 'Outputview',imref2d(size(Imask), [1 size(Imask,2)], [1 size(Imask,1)]));
  imshow(cropped_img)
  
%  Histogram equ for Piece detection 
  [counts,binLocations] = imhist(cropped_img);
   b = counts(1,1);
   w = counts(2,1);
%    disp(w)
%    disp(b)
   if (w>b)
       PiecesLocation(:,end+1)=1;
   else if(b>w)
       PiecesLocation(:,end+1)=0;
   end
   end
   
end
x=x+9;
end
end



