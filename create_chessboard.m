function my_chessboard=create_chessboard()


my_chessboard = 130*ones(800,800,'uint8');
my_chessboard(1:100, 101:200) = 180*ones(100,100,'uint8');
my_chessboard(1:100, 201:400) = my_chessboard(1:100, 1:200);
my_chessboard(1:100, 401:800) = my_chessboard(1:100, 1:400);
my_chessboard(101:200, 1:700) = my_chessboard(1:100, 101:800);

my_chessboard(201:400,:) = my_chessboard(1:200,:);
my_chessboard(401:800,:) = my_chessboard(1:400,:);

% figure, imshow(my_chessboard); title('output sobel');
% hold on;


end