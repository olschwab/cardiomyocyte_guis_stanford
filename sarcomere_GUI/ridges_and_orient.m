function [ BW ,orientim] = ridges_and_orient( file_vid, frame, minS, maxS )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%load image
s=load(['vars_DO_NOT_DELETE/',file_vid,'/image',num2str(frame),'.mat'],'imagei');
image=imcomplement(s.imagei);

% Identify ridge-like regions and normalise image
blksze = 4; thresh = 0.1;
[normim1, mask1] = ridgesegment(image, blksze, thresh);

% Determine ridge orientations
[orientim, ~] = ridgeorient(normim1, 1, 5, 5);

%%1.
%rotate by pi/2
orientim2=orientim+ones(size(orientim))*pi/2;
orientim2(orientim2>pi)=orientim2(orientim2>pi)-pi*ones(size(orientim2(orientim2>pi)));

% Determine ridge frequency values across the image
blksze = 30;
[~, medfreq] = ridgefreq(normim1, mask1, orientim2, blksze, 5,minS,maxS);

% Actually I find the median frequency value used across the whole
% fingerprint gives a more satisfactory result...
freq = medfreq.*mask1;

% Now apply filters to enhance the ridge pattern
newim = ridgefilter(normim1, orientim2, freq, .6,.6, 1);
binim = newim > 0;

%BW = bwmorph(skeleton(binim)>5,'skel',Inf).*masku;
BW=bwmorph(binim,'thin',Inf);

end

