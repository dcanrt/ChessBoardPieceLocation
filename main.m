close all; clear all; clc;

%taking image from Setler file
currentFolder = pwd;
dirNameSet = strcat(currentFolder,'\Setler');
img_name = ('test_zor4.pgm');

%reading original image
original_img = im2double(imread(sprintf('%s/%s', dirNameSet, img_name)));
m = size(original_img, 1);
n = size(original_img, 2);
figure, imshow(original_img); title('original image');

%average filtering
average = fspecial('average', [5, 5]); % smoothing mask
blur_img = imfilter(original_img, average, 'replicate');

%otsu thresholding
T_otsu1 = graythresh(blur_img);
blur_img(blur_img >= T_otsu1) = 255;
blur_img(blur_img < T_otsu1) = 0;
% figure, imshow(blur_img); title('original otsu  image');

%canny edge detection
BW = edge(blur_img.^0.5, 'canny',[0.05 0.2],1);
% figure, imshow(BW); title('canny image');

%dilate
se = strel('square',10); % structure element
dilatedI = imdilate(BW, se);
% figure;imshow(dilatedI);title('dilated canny image 2');

%hough transform and finding lines
%hough_lines(image,numPeaks,FillGap,MinLength)
lines = hough_lines(dilatedI,18,5000,100);

%intersections and coefficients to crop the picture
%intersections(lines,Ncols,Nrows,Draw,img)
%Draw = 1 yapılırsa çizdirilir
[points, max_x, min_x, max_y, min_y]=intersections(lines,m,n,0,dilatedI);

%%%%%%%%%%%%%%%%----------------%%%%%%%%%%%%%%%
%cropped image for better intersections and pieces localization
cropped_image = imcrop(original_img,[min_x-80 min_y-80 max_x-min_x+170 max_y-min_y+170]);
figure;imshow(cropped_image);title('cropped im');
m = size(cropped_image, 1);
n = size(cropped_image, 2);

%average filtering
blur_img = imfilter(cropped_image, average, 'replicate');

%otsu thresholding
T_otsu1 = graythresh(blur_img);
blur_img(blur_img >= T_otsu1) = 255;
blur_img(blur_img < T_otsu1) = 0;
figure, imshow(blur_img); title('otsu image after cropped');

%canny edge detection
BW = edge(blur_img.^0.5, 'canny',[0.05 0.2],1);
figure, imshow(BW); title('canny image after cropped');

%dilate
dilatedI = imdilate(BW, se);
figure, imshow(dilatedI); title('dilated image after cropped');

%connected component labeling
%con_comp_labeling(image)
my_board = con_comp_labeling(dilatedI);
figure; imshow(my_board); title('connected component label');

%hough transform and finding lines
lines = hough_lines(my_board,18,5000,100);

%intersections 
[points, max_x, min_x, max_y, min_y]=intersections(lines,m,n,1,my_board);

%sort points
%sort_points(points)
sorted_points = sort_points(points);

%showing sorted points to cropped image
figure;imshow(cropped_image); hold on;
for p = 1:length(sorted_points)
    plot(sorted_points(p, 1),sorted_points(p, 2), 'x', 'LineWidth', 5, 'Color','red');
end


%---------------------- clahe Contrast-limited adaptive histogram equalization --------------
%piece localicaziton
clahe_img = adapthisteq(cropped_image,'NBins',127);
figure; imshow(clahe_img); title('clahe image');

%blurring
blur_img2 = imfilter(clahe_img, average, 'replicate');
%canny edge detection
BW2 = edge(blur_img2.^0.5, 'canny',[0.05 0.2],1);
%dilation
se = strel('square',5);
dilatedI2 = imdilate(BW2, se);
%figure;imshow(dilatedI2);title('dilated canny image 2');

%closing
se2 = strel('square',100);
closeI = imclose(dilatedI2, se2);
figure;imshow(closeI);title('close image');

%piece_location(BW,sorted_points)
PiecesLocation=piece_location(closeI,sorted_points);
%create_chessboard()
chessboard=create_chessboard();
%draw_locations(PiecesLocation,chessboard)
draw_locations(PiecesLocation,chessboard);


