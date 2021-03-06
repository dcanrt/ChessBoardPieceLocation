function sorted_points = sort_points(points)

sorted_points = []; 
sorted_x = sortrows(points); % b�t�n noktalar� sat�ra g�re s�ralar�z
temp1 = [];
s = 1;
while (s <= length(sorted_x))
    
    for j = s:s+8
        if (j >= length(sorted_x))  % uzunlu�una e�it oldu�unda matrixin daha fazla eleman� olmad��� i�in break yap�yoruz
            temp1 = [temp1; sorted_x(j, 1), sorted_x(j, 2)]; % break yapmadan �nce son eleman� da al�yoruz
            break
        end
        distance = abs((sorted_x(j, 1)) - (sorted_x(j+1, 1))); % bir sonraki pointte ile aram�zdaki fark bulunur
        if(distance < 100) % fark k���kse ayn� s�tundad�rlar
            temp1 = [temp1; sorted_x(j, 1), sorted_x(j, 2)];
        else % fark k���k de�ilse son ad�ma gelmi�izdir ve bundan sonrakiler art�k ba�ka s�tun noktalar�d�r
            temp1 = [temp1; sorted_x(j, 1), sorted_x(j, 2)];
            break
        end  
    end
    if(isempty(temp1) == 1) % i�lem yap�lmam��sa daha fazla nokta bulamam��sa d�ng�den ��k�l�r
        break
    end
    temp2 = sortrows(temp1, 2); % s�tunlar kendi i�erisinde s�ralan�r
    sorted_points = [sorted_points; temp2]; % noktalar bir araya getirilir
    temp1 = [];
    s = j + 1;
    
end

end