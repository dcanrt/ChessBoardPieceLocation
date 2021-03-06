function my_board=con_comp_labeling(image)

max_area = 0;
LabeledI = bwlabel(image, 4); 
% figure; imagesc(LabeledI);
for i=1:max(max(LabeledI))
    
    selected_component = LabeledI;
    selected_component(selected_component < i) = 0;
    selected_component(selected_component > i) = 0;
    selected_component(selected_component > 1) = 1;
    
%     figure; imshow(selected_component);
    s2 = regionprops(selected_component, 'area'); % tek tek þekillerin alaný bulunur
       
     if (max_area < s2.Area && s2.Area > 2000) % maksimum area bulunur
         max_area = s2.Area;
         my_board = selected_component;
     end
    
end

% figure; imshow(my_board);



end