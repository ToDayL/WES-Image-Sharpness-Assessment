%*****Image Sharpness Assessment Based on Wavelet Energy of Edge Area*****
%   File Name: WaveletBlurAssessment.m
%   Author: Jin Li
%   Organization: Image Center, Beihang University
%   Conference: ICGIP 2017 
%   Description: This is the basic function of paper:
%   "Image Sharpness Assessment Based on Wavelet Energy of Edge Area"
%   
%   Related Files: obvious.m
%
%*************************************************************************
function [ score ] = WaveletBlurAssessment( img )
% For color image, convert to gray image
if size(img,3)==3
    img = rgb2gray(img);
end
sz = size(img);

% Down sample the image.
ori=imresize(img,0.5);

% mu and sigma are used to calculate w1
[mu,sigma] = obvious(ori);

% Edge detection using sobel kernel
edgeIMG=edge(ori,'sobel',0.04,'both');

% Haar wavelet transform
imgdbl=double(img);
[LL,LH,HL,HH]=dwt2(imgdbl,'haar');

% Calculate w2
EN = (HL.^2+LH.^2);

% Caculate w
Weight = mu.^2./(sigma+0.0001);

% Calculate the final weight
edgeIMG = edgeIMG.* (EN).^4.*Weight;

% Calculate the log energy of each bands and calculate final score
if sum(sum(edgeIMG))~=0
    LLE=log10(sum(sum(LL.*LL.*edgeIMG))/sum(sum(edgeIMG))+1);
    LHE=log10(sum(sum(LH.*LH.*edgeIMG))/sum(sum(edgeIMG))+1);
    HLE=log10(sum(sum(HL.*HL.*edgeIMG))/sum(sum(edgeIMG))+1);
    HHE=log10(sum(sum(HH.*HH.*edgeIMG))/sum(sum(edgeIMG))+1);

    LowPercent=1-(LLE/(LLE+LHE+HLE+HHE));
else
    LowPercent=0;
end

score = LowPercent;

end

