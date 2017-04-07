function Y = recursive_temp(Y)



%===================================================================
% SELECTIVE RECURSIVE TEMPORAL FILTER
%Author: Debasish Hazarika
%Place: Deptt. of ECE, Tezpur Central University,Assam, India

%This code takes an input of video frammes that are stored in an multi
%dimensional array. 
% For Input Use Your own frames Y
%OPTIMIZATION: Fix a value of a(e.g. a=0.5), then check for various
%thresholds T for maximum PSNR.Next, fix the optimized T and vary the
%values of 'a' for maximum PSNR. After few repeatations, you can use the
%optimized values of 'a' and 'T'

% For queries or questions contact: debasishjrt@gmail.com

%=======================================================================
T=input('enter threshold value for recursive temporal filtering');




a=0.32;  %Fix any value of a, then optimize T. Next Fix T, optimize a


[height,width,nframes] = size(Y);

h=double(zeros(height,width));


for f=2:nframes   % the first frames will be same.
    current=Y(:,:,f);
    previous=Y(:,:,f-1);
    k=current-previous;
    [row, col]=size(current);
   for i=1:row
       for j=1:col
           if abs(k(i,j))<T % motion estimation. For large motion(>T), there is less redundancy.
           h(i,j)=a*current(i,j)+(1-a)*previous(i,j);
           else
           h(i,j)=current(i,j);
           end
       end
       
   end
   Y(:,:,f)=h;
end

