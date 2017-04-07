%% Clear
clear; clc;

%% Read images
ref = ncorr_class_img;
ref.set_img('lazy',struct('name','ohtcfrp_00.tif','path',''));

cur = ncorr_class_img.empty;
for i = 8:11
    cur(end+1) = ncorr_class_img;
    cur(end).set_img('lazy',struct('name',['ohtcfrp_' sprintf('%2.2d',i) '.tif'],'path',''));
end

%% Set ROI
mask = false([ref.height ref.width]);
boundary = 50;
mask(boundary+1:end-boundary,boundary+1:end-boundary) = true;
mask(484:600,132:252) = false;

roi = ncorr_class_roi;
roi.set_roi('load',struct('mask',mask,'cutoff',0));

roi.formatted

%% Get seeds
% Set Parameters
num_region = 0; % Assume only 1 region exists in ROI
radius_rgdic = 20;
spacing_rgdic = 6;
cutoff_diffnorm = 1e-6;
cutoff_iteration = 20;
enabled_stepanalysis = false;
subsettrunc = false;

% Position must with respect to the reduced coordinates and then scaled to
% regular coordinates
pos_seed_reduced = [30 50];
pos_seed = pos_seed_reduced*(spacing_rgdic+1);

for i = 1:length(cur)
     ref.formatted()
                cur(i).formatted()
                roi.formatted
                int32(num_region)
                int32(pos_seed)
                int32(radius_rgdic)
                cutoff_diffnorm
                int32(cutoff_iteration)
                enabled_stepanalysis
                subsettrunc
    [seedinfo(i), convergeinfo, success_seeds] = ncorr_alg_calcseeds(ref.formatted(), ... 
                                                                     cur(i).formatted(), ...
                                                                     roi.formatted, ...
                                                                     int32(num_region), ...
                                                                     int32(pos_seed), ...
                                                                     int32(radius_rgdic), ...
                                                                     cutoff_diffnorm, ...
                                                                     int32(cutoff_iteration), ...
                                                                     enabled_stepanalysis, ... 
                                                                     subsettrunc); 
end
   
%% You may need to place a check here to make sure seed placement is
%% correct (i.e. checking correlation coefficient)

%% DIC analysis
roi_reduced = roi.reduce(spacing_rgdic);
threaddiagram = -ones(size(roi_reduced.mask));
threaddiagram(roi_reduced.mask) = seedinfo.num_thread; % Assigns thread to seed - used for multithreading but for this example on single thread is used

for i = 1:length(cur)
    % Format seedinfo
    seedinfo(i).num_region = int32(seedinfo(i).num_region);
    seedinfo(i).num_thread = int32(seedinfo(i).num_thread);
    seedinfo(i).computepoints = int32(sum(roi_reduced.mask(:))); % Used for waitbar
    
    [dicinfo(i), success_dic] = ncorr_alg_rgdic(ref.formatted(), ...
                                                cur(i).formatted(), ...
                                                roi.formatted(), ...
                                                seedinfo(i), ...
                                                int32(threaddiagram), ...
                                                int32(radius_rgdic), ...
                                                int32(spacing_rgdic), ...
                                                cutoff_diffnorm, ...
                                                int32(cutoff_iteration), ...
                                                subsettrunc, ...
                                                int32(i-1), ...
                                                int32(length(cur)));
end

%% Plots
% Show location of reduced seed and full seeds
figure(1); 
subplot(1,2+length(cur),1);
gs_ref_reduced = ref.reduce(spacing_rgdic).get_gs();
gs_ref_reduced(roi_reduced.mask) = gs_ref_reduced(roi_reduced.mask)+0.5;
imshow(gs_ref_reduced,[]);
hold on;
plot(pos_seed_reduced(1,1), pos_seed_reduced(1,2),'ro');
hold off;
title('reduced seed placement');

subplot(1,2+length(cur),2);
gs_ref = ref.get_gs();
gs_ref(roi.mask) = gs_ref(roi.mask)+0.5;
imshow(gs_ref,[]);
hold on;
plot(pos_seed(1,1), pos_seed(1,2), 'ro');
hold off;
title('full seed placement');

for i = 1:length(cur)
    subplot(1,2+length(cur),2+i);
    imshow(dicinfo(i).plot_u, [-1.5 0.0]);
    title(['V-displacement: ' num2str(i)]);
end

