function [ orientim] = orient( file_vid, frame )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%load image
s=load(['vars_DO_NOT_DELETE/',file_vid,'/image',num2str(frame),'.mat'],'imagei');
image=imcomplement(s.imagei);

% Identify ridge-like regions and normalise image
blksze = 4; thresh = 0.1;
[normim1, ~] = ridgesegment(image, blksze, thresh);

% Determine ridge orientations
[orientim, ~] = ridgeorient(normim1, 1, 5, 5);

% %translate to -90; 90
% orientim=orientim0;
% %0-90°:
% orientim(orientim>=0 & orientim<pi/2)=-orientim(orientim>=0 & orientim<pi/2);
% %90-180°
% orientim(orientim>=pi/2 & orientim<pi)=pi*ones(size(orientim(orientim>=pi/2 & orientim<pi)))-orientim(orientim>=pi/2 & orientim<pi);
% %180-270°
% orientim(orientim>=pi & orientim<3*pi/4)=orientim(orientim>=pi & orientim<3*pi/4)-pi*ones(size(orientim(orientim>=pi & orientim<3*pi/4)));
% %270-360°
% orientim(orientim>=3*pi/4 & orientim<=2*pi)=2*pi*ones(size(orientim(orientim>=3*pi/4 & orientim<=2*pi)))-orientim(orientim>=3*pi/4 & orientim<=2*pi);

end

