function lines=hough_lines(image,numPeaks,FillGap,MinLength)

%hough transform
[H theta rho] = hough(image);

thresh = ceil(0.1 * max(H(:)));
P = houghpeaks(H, numPeaks, 'threshold', thresh);

lines = houghlines(image, theta, rho, P, 'FillGap', FillGap, 'MinLength', MinLength);

end