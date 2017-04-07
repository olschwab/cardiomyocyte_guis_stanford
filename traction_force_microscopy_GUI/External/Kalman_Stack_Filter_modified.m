function Kalman_Stack_Filter_modified(folder,N,gain,percentvar)
% function imageStack=Kalman_Stack_Filter(imageStack,percentvar,gain)
%
% Purpose
% Implements a predictive Kalman-like filter in the time domain of the image
% stack. Algorithm taken from Java code by C.P. Mauer.
% http://rsb.info.nih.gov/ij/plugins/kalman.html
%
% Inputs
% imageStack - a 3d matrix comprising of a noisy image sequence. Time is
%              the 3rd dimension.
% gain - the strength of the filter [0 to 1]. Larger gain values means more
%        aggressive filtering in time so a smoother function with a lower
%        peak. Gain values above 0.5 will weight the predicted value of the
%        pixel higher than the observed value.
% percentvar - the initial estimate for the noise [0 to 1]. Doesn't have
%              much of an effect on the algorithm.
%
% Output
% imageStack - the filtered image stack
%
% Note:
% The time series will look noisy at first then become smoother as the
% filter accumulates evidence.
%
% Rob Campbell, August 2009
%
% modified Nov 2014 Olivier Schwab for lazy lading



% Process input arguments
if nargin<2, gain=0.5;          end
if nargin<3, percentvar = 0.05; end


if gain>1.0||gain<0.0
    gain = 0.8;
end

if percentvar>1.0 || percentvar<0.0
    percentvar = 0.05;
end

%load first images
s=load([folder,'/image',num2str(1),'.mat'],'imagei');
predicted=double(s.imagei);

%Set up variables
width = size(predicted,1);
height = size(predicted,2);

tmp=ones(width,height);

%Set up priors
predictedvar = tmp*percentvar;
noisevar=predictedvar;



%Now conduct the Kalman-like filtering on the image stack
for i=2:N
    s=load([folder,'/image',num2str(i),'.mat'],'imagei');
    observed=double(s.imagei);
    
    Kalman = predictedvar ./ (predictedvar+noisevar);
    corrected = gain*predicted + (1.0-gain)*observed + Kalman.*(observed-predicted);
    correctedvar = predictedvar.*(tmp - Kalman);
    
    predictedvar = correctedvar;
    predicted = corrected;
    imagei=corrected;
    
    %save shortened stack
    if i>10
        save([folder,'/image',num2str(i-10),'.mat'],'imagei','-v7.3')
    end
end

%delete the old image files (N-10:N)
for i=N-9:N
   delete([folder,'/image',num2str(i),'.mat']) 
end

