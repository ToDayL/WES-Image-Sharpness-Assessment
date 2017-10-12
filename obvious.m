%*****Image Sharpness Assessment Based on Wavelet Energy of Edge Area*****
%   File Name: obvious.m
%   Author: Jin Li
%   Organization: Image Center, Beihang University
%   Conference: ICGIP 2017 
%   Description: This is the function used to calculate the
%   weight of image. mu is the average intensity of image and
%   sigma is the variance of neighbor pixels
%   
%   Related Files: N/A
%
%*************************************************************************
function [ mu,sigma] = obvious( img )
    img = double(img);
    window = fspecial('gaussian',11,1.5);
    window = window/(sum(sum(window)));
    mu = filter2(window,img,'same');
    sigma = abs(filter2(window,img.*img,'same')-mu.*mu);
end

