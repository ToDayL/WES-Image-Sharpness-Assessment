%*****Image Sharpness Assessment Based on Wavelet Energy of Edge Area*****
%   File Name: LIVE2DMOS.m
%   Author: Jin Li
%   Organization: Image Center, Beihang University
%   Conference: ICGIP 2017 
%   Description: This is the script used to calculate the performance
%   in live database. The DMOS has been normalized to 1.
%   
%   Related Files: obvious.m
%
%*************************************************************************
clc;
clear all;
load('dmos_realigned.mat');
load('refnames_all.mat');
DMOS = dmos_new(635:635+144)'/100.0;
LIVEstd = dmos_std(635:635+144)'/100.0;
refnames_all = refnames_all(635:808);

% Change the Dataset Folder here, only images are needed
% Other parameters have been loaded.
DatasetPath = '..\\..\\Dataset\\databaserelease2\\databaserelease2\\gblur';

WEB = zeros(145,1);
tic;
for i=1:145
    path =[ DatasetPath,sprintf('\\img%d.bmp',i)];
    img = imread(path);
%     img = rgb2gray(img);
    WEB(i)=WaveletBlurAssessment(img);
%     WEB(i) = (webgr);
end
toc;
result = [WEB,DMOS];
figure;
scatter(WEB,DMOS,'+');
figure;
[r,rnonlinear, rspear, routlier,rmse,mae] = evaluate_metric_performance((WEB),1-DMOS,LIVEstd);
res=[rspear,rnonlinear,rmse,mae]';
box on;
