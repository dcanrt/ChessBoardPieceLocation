function sorted_points = sort_points(points)

sorted_points = []; 
sorted_x = sortrows(points); % bütün noktalarý satýra göre sýralarýz
temp1 = [];
s = 1;
while (s <= length(sorted_x))
    
    for j = s:s+8
        if (j >= length(sorted_x))  % uzunluðuna eþit olduðunda matrixin daha fazla elemaný olmadýðý için break yapýyoruz
            temp1 = [temp1; sorted_x(j, 1), sorted_x(j, 2)]; % break yapmadan önce son elemaný da alýyoruz
            break
        end
        distance = abs((sorted_x(j, 1)) - (sorted_x(j+1, 1))); % bir sonraki pointte ile aramýzdaki fark bulunur
        if(distance < 100) % fark küçükse ayný sütundadýrlar
            temp1 = [temp1; sorted_x(j, 1), sorted_x(j, 2)];
        else % fark küçük deðilse son adýma gelmiþizdir ve bundan sonrakiler artýk baþka sütun noktalarýdýr
            temp1 = [temp1; sorted_x(j, 1), sorted_x(j, 2)];
            break
        end  
    end
    if(isempty(temp1) == 1) % iþlem yapýlmamýþsa daha fazla nokta bulamamýþsa döngüden çýkýlýr
        break
    end
    temp2 = sortrows(temp1, 2); % sütunlar kendi içerisinde sýralanýr
    sorted_points = [sorted_points; temp2]; % noktalar bir araya getirilir
    temp1 = [];
    s = j + 1;
    
end

end