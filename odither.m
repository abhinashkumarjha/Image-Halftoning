clc
clear all;
close all;
% Read images
I1 = imread('1.pgm');
I2 = imread('2.pgm');

% Apply dithering
T1 = orderedThreshold(I1, 1); 
T2 = orderedThreshold(uint8(T1), 1); 
% Show images
figure; imshow(T1); title('1.pgm - Ordered Threshold  ');
figure; imshow(T2); title('2.pgm - Ordered Threshold ');

