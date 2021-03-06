function [points, max_x, min_x, max_y, min_y]=intersections(lines,Ncols,Nrows,Draw,img)

if(Draw == 1)
figure;imshow(img); hold on;
end
%intersections 
points = [];
max_x = 0; min_x = Ncols; max_y = 0; min_y = Nrows;
for h = 1:length(lines)
    for v = h+1:length(lines)
        x1 = [lines(h).point1(1,1), lines(h).point2(1,1)];
        y1 = [lines(h).point1(1,2), lines(h).point2(1,2)];
        x2 = [lines(v).point1(1,1), lines(v).point2(1,1)];
        y2 = [lines(v).point1(1,2), lines(v).point2(1,2)];   
             
        if (lines(h).theta < 180 / 4 && lines(h).theta > (-180 / 4)) % yatay olup olmadýðýna bakýlýr         
            y1(1,1) = y1(1,1) - 100;
            y1(1,2) = y1(1,2) + 100;
        else
            x1(1,1) = x1(1,1) - 100;
            x1(1,2) = x1(1,2) + 100;
        end
        
        if (lines(v).theta < 180 / 4 && lines(v).theta > (-180 / 4)) % dikey olup olmadýðýna bakýlýr
            y2(1,1) = y2(1,1) - 100;
            y2(1,2) = y2(1,2) + 100;

        else
            x2(1,1) = x2(1,1) - 100;
            x2(1,2) = x2(1,2) + 100;
        end
        
        P = InterX([x1; y1],[x2; y2]); % The function we use to find intersection points
        points = [points; P(1,:), P(2,:)] ;
        if(Draw == 1) % fonksiyonda input olarak 1 verilirse þekil çizdirilir
        plot(x1,y1,x2,y2,P(1,:),P(2,:),'ro','LineWidth',3,'Color','yellow');
        end
        %kesiþim noktalarýnýn maksimum ve minimum noktalarý bulunur
        if (max_x < P(1,:))
            max_x = P(1,:);
        end
        
        if (min_x > P(1,:))
            min_x = P(1,:);
        end
        
        if (max_y < P(2,:))
            max_y = P(2,:);
        end
        
        if (min_y > P(2,:))
            min_y = P(2,:);
        end
             
    end
end

end