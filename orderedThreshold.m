function O = orderedThreshold(I, type)
% O = orderedThreshold(I, type)
% Ordered threshold method for image dithering.
% I: The input image
% type: 1,2,3,4 depending upon the dot profile required.
%

if (type == 1)
	% Dither matrix - 8 X 8 diamond dot profile
	S = [61 53 41 33 37 52 60 64;
		 57 45 25 13 17 32 48 56;
		 49 29 21 05 09 24 28 44;
		 39 19 11 01 03 08 16 36; 
		 35 15 07 04 02 12 20 40;
		 43 27 23 10 06 22 30 50;
         55 47 31 18 14 26 46 56;
         63 59 51 38 34 42 54 62];
 
elseif (type == 2)
	% Dither matrix - 8 X 8 line dot profile

	S = [1 2 3 4 5 6 7 8;
		 1 2 3 4 5 6 7 8; 
         1 2 3 4 5 6 7 8;
         1 2 3 4 5 6 7 8;
		 1 2 3 4 5 6 7 8; 
         1 2 3 4 5 6 7 8;
         1 2 3 4 5 6 7 8;
         1 2 3 4 5 6 7 8];
         

elseif (type == 3)	
	% Dither matrix - Bryngdahl's 5 X 5 dot profile
	
	S = [9 1 12 10 7;
		 3 23 21 14 24;
		 13 17 4 6 18;
		 11 19 8 2 16;
		 5 25 15 20 22];
  
elseif (type == 4)
	% Dither matrix - 4 X 4 Grating dot profile
	
	S = [1, 9, 3, 11;
         13 5 15 7;
         4 12 2 10;
         16 8 14 6];
	
else
	fprintf('Error. Type should be one of the following:\n');
	fprintf('1 for Dither matrix with 8 X 8 diamond dot profile\n');
	fprintf('2 for Dither matrix with 8 X 8 line dot profile\n');
	fprintf('3 for Dither matrix with Bryngdahl 5 X 5 dot profile\n');
	fprintf('4 for Dither matrix with 4 X 4 Grating dot profile\n');
	O = zeros(1,1);
	return;
end



% Size of image and S
si = size(I);
ss = size(S);

% Create an image with the same size as I, 
% which has the matrix S replicated. Replicate it using the ceiling
% of their size ratio and then discard the last extra elements (if any).
ts = ceil(si ./ ss);
SImg = repmat(S, ts);
SImg = SImg(1:si(1), 1:si(2));

% Shift the values by 0.5 so that we can compare without floor.
SImg = SImg + 0.5;

% Number of levels N
N = max(S(:)) - min(S(:)) + 2;
% Quantization step and quantized image (with values in 0,1,2,...,N-1)
D = 255 ./ (N-1);
Q = double(I) ./ D;

% Threshold image 
% Pixels with value greater than that of S (at the same position) become 1,
% the rest 0
O = Q > SImg;

end
