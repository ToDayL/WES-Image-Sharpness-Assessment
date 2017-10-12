%*****Image Sharpness Assessment Based on Wavelet Energy of Edge Area*****
%   File Name: WESTest.m
%   Author: Jin Li
%   Organization: Image Center, Beihang University
%   Conference: ICGIP 2017 
%   Description: The sample of WaveletBlurAssessment function
%   
%   Related Files: obvious.m
%
%*************************************************************************

clc
clear

load('FileName.mat');
load('sigma.mat');

for i = 1 : 5
    img = imread(char(FileName(i)));
    WES(i) = WaveletBlurAssessment( img );
end

plot(sigma,WES,'-o');