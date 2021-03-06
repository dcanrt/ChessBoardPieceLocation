function my_chessboard=draw_locations(PiecesLocation,chessboard)

figure, imshow(chessboard); title('visual chessboard');
hold on;
k=0;
for x=1:8
   for y=1:8
       if((y+8*k) > length(PiecesLocation)) 
           break;
       end
       if(PiecesLocation(y+8*k) == 1) 
            rectangle('Position',[x*100-100,y*100-100,50,50],'FaceColor','k');
       end
   end
   if((y+8*k) > length(PiecesLocation))
      break;
   end
   k=k+1;
end

end