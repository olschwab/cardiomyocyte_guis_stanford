%beads_piv.m ; part of the beads GUI: execute beads_main.m
%version 2.0.1
%written by O. Schwab (oschwab@stanford.edu)
%last change: 01/04/15

function beads_piv(h_main)
%main function for the displacement window of beads gui

%create new window for displacement
%fig size
figsize=[450,800];
%get screen size
screensize = get(0,'ScreenSize');
%position fig on center of screen
xpos = ceil((screensize(3)-figsize(2))/2);
ypos = ceil((screensize(4)-figsize(1))/2);
%create fig; invisible at first
h_piv(1).fig=figure(...
    'position',[xpos, ypos, figsize(2), figsize(1)],...
    'units','pixels',...
    'renderer','OpenGL',...
    'MenuBar','none',...
    'PaperPositionMode','auto',...
    'Name','Beads Displacements',...
    'NumberTitle','off',...
    'Resize','off',...
    'Color',[.94,.94,.94],...
    'visible','off');

%create uipanel for ncorr
%uipanel:
h_piv(1).panel_ncorr = uipanel('Parent',h_piv(1).fig,'Title','Ncorr','units','pixels','Position',[20,140,760,300]);
%axes:
h_piv(1).axes_ncorr = axes('Parent',h_piv(1).panel_ncorr,'Units', 'pixels','Position',[250,5,500,280]);
%uipanel: analysis settings
h_piv(1).panel_analysis = uipanel('Parent',h_piv(1).panel_ncorr,'Title','Analysis Settings','units','pixels','Position',[5,170,240,115]);
%analysis settings: text: radius
h_piv(1).text_analysis_radius = uicontrol('Parent',h_piv(1).panel_analysis,'style','text','position',[5,80,100,15],'string','subset radius','HorizontalAlignment','left');
%analysis settings: text: spacing
h_piv(1).text_analysis_spacing = uicontrol('Parent',h_piv(1).panel_analysis,'style','text','position',[5,55,100,15],'string','spacing coefficient','HorizontalAlignment','left');
%analysis settings: text: norm
h_piv(1).text_analysis_cutnorm = uicontrol('Parent',h_piv(1).panel_analysis,'style','text','position',[5,30,100,15],'string','cutoff norm','HorizontalAlignment','left');
%analysis settings: text: iter
h_piv(1).text_analysis_cutiter = uicontrol('Parent',h_piv(1).panel_analysis,'style','text','position',[5,5,100,15],'string','cutoff iteration','HorizontalAlignment','left');
%analysis settings: edit: radius
h_piv(1).edit_analysis_radius = uicontrol('Parent',h_piv(1).panel_analysis,'style','edit','position',[120,80,110,15],'string','30','HorizontalAlignment','center');
%analysis settings: edit: spacing
h_piv(1).edit_analysis_spacing = uicontrol('Parent',h_piv(1).panel_analysis,'style','edit','position',[120,55,110,15],'string','10','HorizontalAlignment','center');
%analysis settings: edit: norm
h_piv(1).edit_analysis_cutnorm = uicontrol('Parent',h_piv(1).panel_analysis,'style','edit','position',[120,30,110,15],'string','1e-6','HorizontalAlignment','center');
%analysis settings: edit: iter
h_piv(1).edit_analysis_cutiter = uicontrol('Parent',h_piv(1).panel_analysis,'style','edit','position',[120,5,110,15],'string','20','HorizontalAlignment','center');
%checkbox: post processing
h_piv(1).checkbox = uicontrol('Parent',h_piv(1).panel_ncorr,'style','checkbox','position',[5,150,160,15],'string','Post-processing','HorizontalAlignment','left');
%uipanel: post settings
h_piv(1).panel_post = uipanel('Parent',h_piv(1).panel_ncorr,'Title','Post Settings','units','pixels','Position',[5,40,240,105]);
%post settings: text umin
h_piv(1).text_post_umin = uicontrol('Parent',h_piv(1).panel_post,'style','text','position',[5,70,30,15],'string','umin','HorizontalAlignment','left');
%post settings: text vmin
h_piv(1).text_post_vmin = uicontrol('Parent',h_piv(1).panel_post,'style','text','position',[5,55,30,15],'string','vmin','HorizontalAlignment','left');
%post settings: text umax
h_piv(1).text_post_umin = uicontrol('Parent',h_piv(1).panel_post,'style','text','position',[125,70,30,15],'string','umax','HorizontalAlignment','left');
%post settings: text vmax
h_piv(1).text_post_vmin = uicontrol('Parent',h_piv(1).panel_post,'style','text','position',[125,55,30,15],'string','vmax','HorizontalAlignment','left');
%post settings: text std
h_piv(1).text_post_std = uicontrol('Parent',h_piv(1).panel_post,'style','text','position',[5,35,200,15],'string','std threshold','HorizontalAlignment','left');
%post settings: text median eps
h_piv(1).text_post_eps = uicontrol('Parent',h_piv(1).panel_post,'style','text','position',[5,20,200,15],'string','normalized median epsilon','HorizontalAlignment','left');
%post settings: text median thresh
h_piv(1).text_post_thresh = uicontrol('Parent',h_piv(1).panel_post,'style','text','position',[5,5,200,15],'string','normalized median threshold','HorizontalAlignment','left');
%post settings: edit: umin
h_piv(1).edit_post_umin = uicontrol('Parent',h_piv(1).panel_post,'style','edit','position',[45,70,50,15],'string','-10','HorizontalAlignment','center');
%post settings: edit: vmin
h_piv(1).edit_post_vmin = uicontrol('Parent',h_piv(1).panel_post,'style','edit','position',[45,55,50,15],'string','-10','HorizontalAlignment','center');
%post settings: edit: umax
h_piv(1).edit_post_umax = uicontrol('Parent',h_piv(1).panel_post,'style','edit','position',[170,70,50,15],'string','10','HorizontalAlignment','center');
%post settings: edit: vmax
h_piv(1).edit_post_vmax = uicontrol('Parent',h_piv(1).panel_post,'style','edit','position',[170,55,50,15],'string','10','HorizontalAlignment','center');
%post settings: edit: std
h_piv(1).edit_post_std = uicontrol('Parent',h_piv(1).panel_post,'style','edit','position',[170,35,50,15],'string','6','HorizontalAlignment','center');
%post settings: edit: eps
h_piv(1).edit_post_eps = uicontrol('Parent',h_piv(1).panel_post,'style','edit','position',[170,20,50,15],'string','0.15','HorizontalAlignment','center');
%post settings: edit: thresh
h_piv(1).edit_post_thresh = uicontrol('Parent',h_piv(1).panel_post,'style','edit','position',[170,5,50,15],'string','3','HorizontalAlignment','center');
%button: calculate all
h_piv(1).button_calcncorr = uicontrol('Parent',h_piv(1).panel_ncorr,'style','pushbutton','position',[5,5,240,30],'string','Calculate all');

%create uipanel for smartguess
%uipanel
h_piv(1).panel_guess = uipanel('Parent',h_piv(1).fig,'Title','Determine reference frame','units','pixels','Position',[550,85,150,50]);
%button
h_piv(1).button_guess = uicontrol('Parent',h_piv(1).panel_guess,'style','pushbutton','position',[5,5,137,25],'string','Guess all');

%create uipanel for reference shift
%uipanel
h_piv(1).panel_ref = uipanel('Parent',h_piv(1).fig,'Title','Reference shift','units','pixels','Position',[20,30,525,105]);
%text: reference
h_piv(1).text_ref_ref = uicontrol('Parent',h_piv(1).panel_ref,'style','text','position',[5,65,60,15],'string','Relaxed','HorizontalAlignment','left');
%text: contracted
h_piv(1).text_ref_contr = uicontrol('Parent',h_piv(1).panel_ref,'style','text','position',[5,45,60,15],'string','Contracted','HorizontalAlignment','left');
%edit: reference
h_piv(1).edit_ref_ref = uicontrol('Parent',h_piv(1).panel_ref,'style','edit','position',[75,65,40,15],'HorizontalAlignment','center');
%edit: contracted
h_piv(1).edit_ref_contr = uicontrol('Parent',h_piv(1).panel_ref,'style','edit','position',[75,45,40,15],'HorizontalAlignment','center');
%button: pick relaxed
h_piv(1).button_pickref = uicontrol('Parent',h_piv(1).panel_ref,'style','pushbutton','position',[120,64,40,18],'string','Pick');
%button: pick contr
h_piv(1).button_pickcontr = uicontrol('Parent',h_piv(1).panel_ref,'style','pushbutton','position',[120,43,40,18],'string','Pick');
%button: update
h_piv(1).button_update = uicontrol('Parent',h_piv(1).panel_ref,'style','pushbutton','position',[5,5,155,25],'string','Update preview');
%axes:
h_piv(1).axes_ref = axes('Parent',h_piv(1).panel_ref,'Units', 'pixels','Position',[165,5,200,85]);
%button: calculate all
h_piv(1).button_calcref = uicontrol('Parent',h_piv(1).panel_ref,'style','pushbutton','position',[370,5,147,25],'string','Calculate all');
%button: forwards
h_piv(1).button_forwards = uicontrol('Parent',h_piv(1).panel_ref,'style','pushbutton','position',[395,67,25,25],'string','>');
%button: backwards
h_piv(1).button_backwards = uicontrol('Parent',h_piv(1).panel_ref,'style','pushbutton','position',[370,67,25,25],'string','<');
%text: show which video (i/n)
h_piv(1).text_whichvid = uicontrol('Parent',h_piv(1).panel_ref,'style','text','position',[425,75,25,15],'string','(1/1)','HorizontalAlignment','left');
%text: show which video (name)
h_piv(1).text_whichvidname = uicontrol('Parent',h_piv(1).panel_ref,'style','text','position',[370,50,100,15],'string','Experiment','HorizontalAlignment','left');

%create ok button
h_piv(1).button_ok = uicontrol('Parent',h_piv(1).fig,'style','pushbutton','position',[735,30,45,20],'string','OK','visible','on');
%create matrix save checkbox
h_piv(1).checkbox_matrix = uicontrol('Parent',h_piv(1).fig,'style','checkbox','position',[550,30,160,15],'string','Save displacement matrices','HorizontalAlignment','left');
%create heatmaps save checkbox
h_piv(1).checkbox_heatmaps = uicontrol('Parent',h_piv(1).fig,'style','checkbox','position',[550,50,160,15],'string','Save heatmaps','HorizontalAlignment','left');

%callbacks for buttons and checkbox
set(h_piv(1).button_calcncorr,'callback',{@piv_push_calcncorr,h_piv})
set(h_piv(1).button_guess,'callback',{@piv_push_guess,h_piv})
set(h_piv(1).button_pickref,'callback',{@piv_push_pickref,h_piv})
set(h_piv(1).button_pickcontr,'callback',{@piv_push_pickcontr,h_piv})
set(h_piv(1).button_update,'callback',{@piv_push_update,h_piv})
set(h_piv(1).button_calcref,'callback',{@piv_push_calcref,h_piv})
set(h_piv(1).button_backwards,'callback',{@piv_push_backwards,h_piv})
set(h_piv(1).button_forwards,'callback',{@piv_push_forwards,h_piv})
set(h_piv(1).button_ok,'callback',{@piv_push_ok,h_piv,h_main})
set(h_piv(1).checkbox,'callback',{@piv_checkbox,h_piv})

%populate figure on launch
%error catch loop (http://www.matlabtips.com/display-errors/)
try    
    %turn off panels
    set(h_piv(1).panel_ncorr,'Visible','on');
    set(h_piv(1).panel_post,'Visible','off');
    set(h_piv(1).panel_ref,'Visible','off');
    set(h_piv(1).panel_guess,'Visible','off');
    set(h_piv(1).button_ok,'Visible','off');
    set(h_piv(1).checkbox_matrix,'Visible','off')
    set(h_piv(1).checkbox_heatmaps,'Visible','off')
    
    %load vars
    tfm_init_user_preview_frame1=getappdata(0,'tfm_init_user_preview_frame1');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    
    %display 1st frame of 1st vid in axes
    reset(h_piv(1).axes_ncorr)
    axes(h_piv(1).axes_ncorr)
    imshow(tfm_init_user_preview_frame1{1});hold on;
    
    %initiate counter (which video)
    tfm_piv_user_counter=1;
    
    %initialize relax/contr/dis
    tfm_piv_user_contr=cell(1,tfm_init_user_Nfiles);
    tfm_piv_user_relax=cell(1,tfm_init_user_Nfiles);
    tfm_piv_user_d=cell(1,tfm_init_user_Nfiles);
    
    %store everything for shared use
    setappdata(0,'tfm_piv_user_counter',tfm_piv_user_counter)
    setappdata(0,'tfm_piv_user_contr',tfm_piv_user_contr);
    setappdata(0,'tfm_piv_user_relax',tfm_piv_user_relax);
    setappdata(0,'tfm_piv_user_d',tfm_piv_user_d);
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

%make fig visible
set(h_piv(1).fig,'visible','on');

%move main window to the side
movegui(h_main(1).fig,'west')

function piv_push_calcncorr(hObject, eventdata, h_piv)
%disable figure during calculation
enableDisableFig(h_piv(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_piv(1).fig,1));


try
    %load what shared para we need
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_init_user_Nframes=getappdata(0,'tfm_init_user_Nframes');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_init_user_pathnamestack=getappdata(0,'tfm_init_user_pathnamestack');
    tfm_init_user_preview_frame1=getappdata(0,'tfm_init_user_preview_frame1');

    
%     %ncorr settings
    num_region = 0; % Assume only 1 region exists in ROI
    radius_rgdic = str2double(get(h_piv(1).edit_analysis_radius,'String'));
    spacing_rgdic = str2double(get(h_piv(1).edit_analysis_spacing,'String'));
    cutoff_diffnorm = str2double(get(h_piv(1).edit_analysis_cutnorm,'String'));
    cutoff_iteration = str2double(get(h_piv(1).edit_analysis_cutiter,'String'));
    enabled_stepanalysis = false;
    subsettrunc = false;
    
    %filter/post settings
    umin = str2double(get(h_piv(1).edit_post_umin,'String')); % minimum allowed u velocity
    umax = str2double(get(h_piv(1).edit_post_umax,'String')); % maximum allowed u velocity
    vmin = str2double(get(h_piv(1).edit_post_vmin,'String')); % minimum allowed v velocity
    vmax = str2double(get(h_piv(1).edit_post_vmax,'String')); % maximum allowed v velocity
    stdthresh=str2double(get(h_piv(1).edit_post_std,'String')); % threshold for standard deviation check
    epsilon=str2double(get(h_piv(1).edit_post_eps,'String')); % epsilon for normalized median test
    thresh=str2double(get(h_piv(1).edit_post_thresh,'String')); % threshold for normalized median test
    
    %first save images as png for lazy loading...
    witer=0;
    %loop over videos
    for ivid=1:tfm_init_user_Nfiles
        %heatmap save folder
        if ~isequal(exist([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots'], 'dir'),7)
                mkdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots'])
        end
        if ~isequal(exist([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Displacement Heatmaps'], 'dir'),7)
                mkdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Displacement Heatmaps'])
        end
        
        %loop over frames
        for ifr=1:tfm_init_user_Nframes{ivid}
            %estimate waiting time
            witer=witer+1;
            sb=statusbar(h_piv(1).fig,['Tweaking images... ',num2str(floor(100*(witer-1)/sum([tfm_init_user_Nframes{:}]))), '%% done']);
            sb.getComponent(0).setForeground(java.awt.Color.red);
            
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/image',num2str(ifr),'.mat'],'imagei');
            im=im2uint16(normalise(s.imagei));
            imwrite(im,['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/image',num2str(ifr),'.png']);
        end
    end
    %statusbar
    sb=statusbar(h_piv(1).fig,'Tweaking - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    %
    
    %loop over videos
    for ivid=1:tfm_init_user_Nfiles
        sb=statusbar(h_piv(1).fig,['Calculating... ',num2str(floor(100*(ivid-1)/tfm_init_user_Nfiles)), '%% done']);
        sb.getComponent(0).setForeground(java.awt.Color.red);
        
        %create folder to save disp.
        mkdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots'])
        mkdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Displacement Heatmaps'])
        
              
        %set reference
        ref = ncorr_class_img;
        ref.set_img('lazy',struct('name','image1.png','path',['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid}]));
        
        %set current
        cur = ncorr_class_img.empty;
        for ifr=1:tfm_init_user_Nframes{ivid}
            cur(end+1) = ncorr_class_img;
            cur(end).set_img('lazy',struct('name',['image',num2str(ifr),'.png'],'path',['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid}]));
        end
        
        %set roi
        mask = true([ref.height ref.width]);
        roi = ncorr_class_roi;
        roi.set_roi('load',struct('mask',mask,'cutoff',0));
        
        %center of mass of mask
        props = regionprops( double( mask ), 'Centroid'); 
        Centroid=props.Centroid;
        xc=Centroid(1,1);
        yc=Centroid(1,2);
        %position seeds at center
        pos_seed=[xc,yc];

        for i = 1:length(cur)
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
        
        %% DIC analysis
        roi_reduced = roi.reduce(spacing_rgdic);
        threaddiagram = -ones(size(roi_reduced.mask));
        threaddiagram(roi_reduced.mask) = seedinfo.num_thread; % Assigns thread to seed - used for multithreading but for this example on single thread is used
        
        for frame = 1:length(cur)
            % Format seedinfo
            seedinfo(frame).num_region = int32(seedinfo(frame).num_region);
            seedinfo(frame).num_thread = int32(seedinfo(frame).num_thread);
            seedinfo(frame).computepoints = int32(sum(roi_reduced.mask(:))); % Used for waitbar
            
            [dicinfo(frame), success_dic] = ncorr_alg_rgdic(ref.formatted(), ...
                cur(frame).formatted(), ...
                roi.formatted(), ...
                seedinfo(frame), ...
                int32(threaddiagram), ...
                int32(radius_rgdic), ...
                int32(spacing_rgdic), ...
                cutoff_diffnorm, ...
                int32(cutoff_iteration), ...
                subsettrunc, ...
                int32(frame-1), ...
                int32(length(cur)));
            
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/image',num2str(1),'.mat'],'imagei');
            im_ref=s.imagei;
            
            %save displ.
            spacing=spacing_rgdic;
            
            u=dicinfo(frame).plot_u;
            v=dicinfo(frame).plot_v;
            
            %format: filter out everything under correlation coeff
            %threshold
%             coeff=dicinfo(frame).plot_corrcoef;
%             coeffmask=double(coeff<2.5);
%             figure(5), imagesc(double(coeff));
%             colorbar;
%             coeffmask(coeffmask==0)=NaN;
%             u=u.*coeffmask;
%             v=v.*coeffmask;
%             u=inpaint_nans(u,4);
%             v=inpaint_nans(v,4);
            
            %save displaced cell roi
            %dicinfo(frame)
            %(frame).roi_dic;
            %save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/deformed_mask_',num2str(frame),'.mat'],'defmask','-v7.3')
            
            %cal. x, y
            rows=size(im_ref,1);
            cols=size(im_ref,2);
            x_vec=1:1+spacing:cols;
            y_vec=1:1+spacing:rows;
            
            %make matrices
            x_matr=zeros(length(y_vec),length(x_vec));
            y_matr=zeros(length(y_vec),length(x_vec));
            for i=1:length(y_vec)
                x_matr(i,:)=x_vec;
            end
            for i=1:length(x_vec)
                y_matr(:,i)=y_vec';
            end
            
            %exclude last row, there is always a prob with it.
            x=x_matr(1:end-1,:);
            y=y_matr(1:end-1,:);
            u_filtered=u(1:end-1,:);
            v_filtered=v(1:end-1,:);
            
            %check if user wants filter
            if get(h_piv(1).checkbox,'Value')
                %vellimit check
                u_filtered(u_filtered<umin)=NaN;
                u_filtered(u_filtered>umax)=NaN;
                v_filtered(v_filtered<vmin)=NaN;
                v_filtered(v_filtered>vmax)=NaN;
                % stddev check
                meanu=nanmean(u_filtered(:));
                meanv=nanmean(v_filtered(:));
                std2u=nanstd(reshape(u_filtered,size(u_filtered,1)*size(u_filtered,2),1));
                std2v=nanstd(reshape(v_filtered,size(v_filtered,1)*size(v_filtered,2),1));
                minvalu=meanu-stdthresh*std2u;
                maxvalu=meanu+stdthresh*std2u;
                minvalv=meanv-stdthresh*std2v;
                maxvalv=meanv+stdthresh*std2v;
                u_filtered(u_filtered<minvalu)=NaN;
                u_filtered(u_filtered>maxvalu)=NaN;
                v_filtered(v_filtered<minvalv)=NaN;
                v_filtered(v_filtered>maxvalv)=NaN;
                % normalized median check
                %Westerweel & Scarano (2005): Universal Outlier detection for PIV data
                [J,I]=size(u_filtered);
                normfluct=zeros(J,I,2);
                b=1;
                for c=1:2
                    if c==1; velcomp=u_filtered;else;velcomp=v_filtered;end %#ok<*NOSEM>
                    for i=1+b:I-b
                        for j=1+b:J-b
                            neigh=velcomp(j-b:j+b,i-b:i+b);
                            neighcol=neigh(:);
                            neighcol2=[neighcol(1:(2*b+1)*b+b);neighcol((2*b+1)*b+b+2:end)];
                            med=median(neighcol2);
                            fluct=velcomp(j,i)-med;
                            res=neighcol2-med;
                            medianres=median(abs(res));
                            normfluct(j,i,c)=abs(fluct/(medianres+epsilon));
                        end
                    end
                end
                info1=(sqrt(normfluct(:,:,1).^2+normfluct(:,:,2).^2)>thresh);
                u_filtered(info1==1)=NaN;
                v_filtered(info1==1)=NaN;
                
                %Interpolate missing data
                u_filtered=inpaint_nans(u_filtered,4);
                v_filtered=inpaint_nans(v_filtered,4);
            end
            
            fu=u_filtered;
            fv=v_filtered;
            
            %save to mat
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_x_',num2str(frame),'.mat'],'x','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_y_',num2str(frame),'.mat'],'y','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_u_',num2str(frame),'.mat'],'fu','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_v_',num2str(frame),'.mat'],'fv','-v7.3')
            %sb=statusbar(h_piv(1).fig,['Calculating... ',num2str(floor(100*(witer-1)/sum([tfm_init_user_Nframes{:}]))), '%% done']);
            %sb.getComponent(0).setForeground(java.awt.Color.red);
            %current image
            
            %plot skip factor
            sp=ceil(20/(spacing+1));
            
            %interpolate for display
            [Xqu,Yqu]=meshgrid(x(1):x(end),y(1):y(end));
            V = interp2(x,y,sqrt(fu.^2+fv.^2),Xqu,Yqu,'linear');
            
            %plot in axes
            cla(h_piv(1).axes_ncorr);
            axes(h_piv(1).axes_ncorr);
            imagesc(V);colormap('jet');
            caxis([0,10]);
            hold on
            quiver(x(1:sp:end,1:sp:end),y(1:sp:end,1:sp:end),5*fu(1:sp:end,1:sp:end),5*fv(1:sp:end,1:sp:end),0,'r');
            %gtitle(filenames{i},'interpreter','none')
            set(gca,'xtick',[],'ytick',[])
            set(gca,'linewidth',2);
            axis image;
            
            p=figure('visible','off');
            imagesc(V);colormap('jet');
            caxis([0,10]);
            hold on
            quiver(x(1:sp:end,1:sp:end),y(1:sp:end,1:sp:end),5*fu(1:sp:end,1:sp:end),5*fv(1:sp:end,1:sp:end),0,'r');
            %gtitle(filenames{i},'interpreter','none')
            set(gca,'xtick',[],'ytick',[])
            set(gca,'linewidth',2);
            axis image;
            export_fig([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Displacement Heatmaps/heatmap',int2str(frame)],'-png','-m2',p);
            close(p)
            %save data in text files
            %save([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/displacements/dis', int2str(ifr),'.mat'],'x','y','u_filt','v_filt');
        end
        
    end
    %statusbar
    sb=statusbar(h_piv(1).fig,'Calculation - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %enable ok button; cancel grey out
    set(h_piv(1).panel_guess,'Visible','on');
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function piv_push_guess(hObject, eventdata, h_piv)
%disable figure during calculation
enableDisableFig(h_piv(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_piv(1).fig,1));


try
    %load shared needed para
    tfm_init_user_conversion=getappdata(0,'tfm_init_user_conversion');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_init_user_Nframes=getappdata(0,'tfm_init_user_Nframes');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_piv_user_contr=getappdata(0,'tfm_piv_user_contr');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_piv_user_d=getappdata(0,'tfm_piv_user_d');
    tfm_piv_user_counter=getappdata(0,'tfm_piv_user_counter');
    tfm_init_user_binary1=getappdata(0,'tfm_init_user_binary1');
    
    
    for current_vid=1:tfm_init_user_Nfiles
        %waitbar
        sb=statusbar(h_piv(1).fig,['Calculating... ',num2str(floor(100*(current_vid-1)/tfm_init_user_Nfiles)), '%% done']);
        sb.getComponent(0).setForeground(java.awt.Color.red);
        
        %get displacmenets from calc. before
        Num=tfm_init_user_Nframes{current_vid};
        tfm_piv_user_xs=cell(1,Num);
        tfm_piv_user_ys=cell(1,Num);
        tfm_piv_user_us=cell(1,Num);
        tfm_piv_user_vs=cell(1,Num);
        
        for ifr=1:Num
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_x_',num2str(ifr),'.mat'],'x');
            tfm_piv_user_xs{ifr}=s.x;
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_y_',num2str(ifr),'.mat'],'y');
            tfm_piv_user_ys{ifr}=s.y;
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_u_',num2str(ifr),'.mat'],'fu');
            tfm_piv_user_us{ifr}=s.fu;
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_v_',num2str(ifr),'.mat'],'fv');
            tfm_piv_user_vs{ifr}=s.fv;
        end
        
        %mask: translate to correct spacing 
        dismask=tfm_init_user_binary1{current_vid}(tfm_piv_user_ys{1}(:,1) ,tfm_piv_user_xs{1}(1,:));
              
        %smartguess reference
        [relax,contr] = smartguess_reference(Num,tfm_piv_user_us,tfm_piv_user_vs,dismask);
        %for later use
        tfm_piv_user_contr{current_vid}=contr;
        tfm_piv_user_relax{current_vid}=relax;
        
        %transform mask, st 0s become Nans
        mask=double(dismask);
        mask(mask==0)=NaN;
        
        %calculate preview displacement plots
        u1ref=tfm_piv_user_us{relax};
        v1ref=tfm_piv_user_vs{relax};
        d=zeros(1,Num);
        for ktest=1:Num
            deltaU=mask.*(tfm_piv_user_us{ktest}-u1ref);
            deltaV=mask.*(tfm_piv_user_vs{ktest}-v1ref);
            usn=(tfm_piv_user_us{ktest}-u1ref)-nanmean(deltaU(:)).*ones(size(u1ref,1),size(u1ref,2));
            vsn=(tfm_piv_user_vs{ktest}-v1ref)-nanmean(deltaV(:)).*ones(size(v1ref,1),size(v1ref,2));
            dsn=mask.*sqrt(usn.^2+vsn.^2);
            d(ktest)=nanmean(dsn(:));
        end
        d(relax)=NaN;
        %for later use
        tfm_piv_user_d{current_vid}=d*tfm_init_user_conversion{current_vid}*1e-6;
    end
    %statusbar
    sb=statusbar(h_piv(1).fig,'Calculation - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %set the counter back to 1 
    tfm_piv_user_counter=1;
    
    %make second panel visible
    set(h_piv(1).panel_ref,'Visible','on');
    
    %%now display this info for 1st video.
    set(h_piv(1).edit_ref_ref,'String',num2str(tfm_piv_user_relax{tfm_piv_user_counter}));
    set(h_piv(1).edit_ref_contr,'String',num2str(tfm_piv_user_contr{tfm_piv_user_counter}));
    
    %display displacement plot
    reset(h_piv(1).axes_ref)
    axes(h_piv(1).axes_ref)
    plot((1:length(tfm_piv_user_d{tfm_piv_user_counter})),tfm_piv_user_d{tfm_piv_user_counter}*1e6)
    %1e6: otherwise it will not plot in axes, not sure whzy...
    set(h_piv(1).axes_ref, 'XTick', []);
    set(h_piv(1).axes_ref, 'YTick', []);
    
    %buttons
    %set(h_piv(1).button_ok,'Visible','on');
    if tfm_piv_user_counter>1
        set(h_piv(1).button_backwards,'Enable','on');
    else
        set(h_piv(1).button_backwards,'Enable','off');
    end
    if tfm_piv_user_counter==tfm_init_user_Nfiles
        set(h_piv(1).button_forwards,'Enable','off');
    else
        set(h_piv(1).button_forwards,'Enable','on');
    end
      
    %set texts to 1st vid
    set(h_piv(1).text_whichvidname,'String',tfm_init_user_filenamestack{1,tfm_piv_user_counter});
    set(h_piv(1).text_whichvid,'String',[num2str(tfm_piv_user_counter),'/',num2str(tfm_init_user_Nfiles)]);
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end


%store everything for shared use
setappdata(0,'tfm_piv_user_contr',tfm_piv_user_contr);
setappdata(0,'tfm_piv_user_relax',tfm_piv_user_relax);
setappdata(0,'tfm_piv_user_d',tfm_piv_user_d);
setappdata(0,'tfm_piv_user_counter',tfm_piv_user_counter);

function piv_push_pickref(hObject, eventdata, h_piv)
%disable figure during calculation
enableDisableFig(h_piv(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_piv(1).fig,1));


try
    %load shared needed para
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_piv_user_d=getappdata(0,'tfm_piv_user_d');
    tfm_piv_user_counter=getappdata(0,'tfm_piv_user_counter');
    
    %open figure
    hf=figure;
    plot((1:length(tfm_piv_user_d{tfm_piv_user_counter})),tfm_piv_user_d{tfm_piv_user_counter})
    hold on;
    title('Pick relaxed')
    [~,x,~] = selectdata('SelectionMode','closest');
    close(hf)
    
    %save as new reference
    tfm_piv_user_relax{tfm_piv_user_counter}=x;
    
    %set in boxes and save
    set(h_piv(1).edit_ref_ref,'String',num2str(tfm_piv_user_relax{tfm_piv_user_counter}));
    
catch 
end


%store everything for shared use
setappdata(0,'tfm_piv_user_relax',tfm_piv_user_relax);

function piv_push_pickcontr(hObject, eventdata, h_piv)
%disable figure during calculation
enableDisableFig(h_piv(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_piv(1).fig,1));


try
    %load shared needed para
    tfm_piv_user_contr=getappdata(0,'tfm_piv_user_contr');
    tfm_piv_user_d=getappdata(0,'tfm_piv_user_d');
    tfm_piv_user_counter=getappdata(0,'tfm_piv_user_counter');
    
    %open figure
    hf=figure;
    plot((1:length(tfm_piv_user_d{tfm_piv_user_counter})),tfm_piv_user_d{tfm_piv_user_counter})
    hold on;
    title('Pick contracted')
    [~,x,~] = selectdata('SelectionMode','closest');
    close(hf)
    
    %save as new reference
    tfm_piv_user_contr{tfm_piv_user_counter}=x;
    
    %set in boxes and save
    set(h_piv(1).edit_ref_contr,'String',num2str(tfm_piv_user_contr{tfm_piv_user_counter}));
    
catch 
end

%store everything for shared use
setappdata(0,'tfm_piv_user_contr',tfm_piv_user_contr);

function piv_push_update(hObject, eventdata, h_piv)
%disable figure during calculation
enableDisableFig(h_piv(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_piv(1).fig,1));


try
    %load shared needed para
    tfm_init_user_conversion=getappdata(0,'tfm_init_user_conversion');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_init_user_Nframes=getappdata(0,'tfm_init_user_Nframes');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_piv_user_contr=getappdata(0,'tfm_piv_user_contr');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_piv_user_d=getappdata(0,'tfm_piv_user_d');
    tfm_piv_user_counter=getappdata(0,'tfm_piv_user_counter');
    tfm_init_user_binary1=getappdata(0,'tfm_init_user_binary1');
    
    
    current_vid=tfm_piv_user_counter;

        %waitbar
        sb=statusbar(h_piv(1).fig,['Updating...']);
        sb.getComponent(0).setForeground(java.awt.Color.red);
        
        %get displacmenets from calc. before
        Num=tfm_init_user_Nframes{current_vid};
        tfm_piv_user_xs=cell(1,Num);
        tfm_piv_user_ys=cell(1,Num);
        tfm_piv_user_us=cell(1,Num);
        tfm_piv_user_vs=cell(1,Num);
        
        for ifr=1:Num
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_x_',num2str(ifr),'.mat'],'x');
            tfm_piv_user_xs{ifr}=s.x;
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_y_',num2str(ifr),'.mat'],'y');
            tfm_piv_user_ys{ifr}=s.y;
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_u_',num2str(ifr),'.mat'],'fu');
            tfm_piv_user_us{ifr}=s.fu;
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_v_',num2str(ifr),'.mat'],'fv');
            tfm_piv_user_vs{ifr}=s.fv;
        end
        
        %mask: translate to correct spacing 
        dismask=tfm_init_user_binary1{current_vid}(tfm_piv_user_ys{1}(:,1) ,tfm_piv_user_xs{1}(1,:));
              
        %read relaxed contr from editbox
        contr=str2double(get(h_piv(1).edit_ref_contr,'String'));
        relax=str2double(get(h_piv(1).edit_ref_ref,'String'));

        %for later use
        tfm_piv_user_contr{current_vid}=contr;
        tfm_piv_user_relax{current_vid}=relax;
        
        %transform mask, st 0s become Nans
        mask=double(dismask);
        mask(mask==0)=NaN;
        
        %calculate preview displacement plots
        u1ref=tfm_piv_user_us{relax};
        v1ref=tfm_piv_user_vs{relax};
        d=zeros(1,Num);
        for ktest=1:Num
            deltaU=mask.*(tfm_piv_user_us{ktest}-u1ref);
            deltaV=mask.*(tfm_piv_user_vs{ktest}-v1ref);
            usn=(tfm_piv_user_us{ktest}-u1ref)-nanmean(deltaU(:)).*ones(size(u1ref,1),size(u1ref,2));
            vsn=(tfm_piv_user_vs{ktest}-v1ref)-nanmean(deltaV(:)).*ones(size(v1ref,1),size(v1ref,2));
            dsn=mask.*sqrt(usn.^2+vsn.^2);
            d(ktest)=nanmean(dsn(:));
        end
        d(relax)=NaN;
        %for later use
        tfm_piv_user_d{current_vid}=d*tfm_init_user_conversion{current_vid}*1e6;

    %statusbar
    sb=statusbar(h_piv(1).fig,'Calculation - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
      
    %make second panel visible
    set(h_piv(1).panel_ref,'Visible','on');
    
    %display displacement plot
    axes(h_piv(1).axes_ref);
    plot(1:length(tfm_piv_user_d{tfm_piv_user_counter}),tfm_piv_user_d{tfm_piv_user_counter})
    set(h_piv(1).axes_ref, 'XTick', []);
    set(h_piv(1).axes_ref, 'YTick', []);
    
    %buttons
    %set(h_piv(1).button_ok,'Visible','on');
    if tfm_piv_user_counter>1
        set(h_piv(1).button_backwards,'Enable','on');
    else
        set(h_piv(1).button_backwards,'Enable','off');
    end
    if tfm_piv_user_counter==tfm_init_user_Nfiles
        set(h_piv(1).button_forwards,'Enable','off');
    else
        set(h_piv(1).button_forwards,'Enable','on');
    end
      
    %set texts to 1st vid
    set(h_piv(1).text_whichvidname,'String',tfm_init_user_filenamestack{1,tfm_piv_user_counter});
    set(h_piv(1).text_whichvid,'String',[num2str(tfm_piv_user_counter),'/',num2str(tfm_init_user_Nfiles)]);
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end


%store everything for shared use
setappdata(0,'tfm_piv_user_contr',tfm_piv_user_contr);
setappdata(0,'tfm_piv_user_relax',tfm_piv_user_relax);
setappdata(0,'tfm_piv_user_d',tfm_piv_user_d);
setappdata(0,'tfm_piv_user_counter',tfm_piv_user_counter);

function piv_push_calcref(hObject, eventdata, h_piv)
%disable figure during calculation
enableDisableFig(h_piv(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_piv(1).fig,1));


try
%load shared
tfm_init_user_Nframes=getappdata(0,'tfm_init_user_Nframes');
tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
tfm_piv_user_contr=getappdata(0,'tfm_piv_user_contr');
tfm_init_user_binary1=getappdata(0,'tfm_init_user_binary1');
tfm_init_user_conversion=getappdata(0,'tfm_init_user_conversion');

%loop over vids and frames, calculate displacements inside blobbs and
%angles
%initialize
tfm_piv_user_meand=cell(tfm_init_user_Nfiles,max([tfm_init_user_Nframes{:}]));

%pivs
for ivid=1:tfm_init_user_Nfiles
    sb=statusbar(h_piv(1).fig,['Calculating... ',num2str(floor(100*(ivid-1)/tfm_init_user_Nfiles)), '%% done']);
    sb.getComponent(0).setForeground(java.awt.Color.red);
        
    %loop over frames
    Num=tfm_init_user_Nframes{ivid};
    %
    s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_x_',num2str(1),'.mat'],'x');
    tfm_piv_user_xs=s.x;
    s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_y_',num2str(1),'.mat'],'y');
    tfm_piv_user_ys=s.y;
    
    for frame=1:Num    
        %mask
        tfm_piv_user_dismask=tfm_init_user_binary1{ivid}(tfm_piv_user_ys(:,1) ,tfm_piv_user_xs(1,:));
        
        %calculation
        [ displacement,~,~,~,~,~,~]=calc_blobb3(tfm_init_user_filenamestack{1,ivid},tfm_piv_user_relax{ivid},tfm_piv_user_contr{ivid},frame,tfm_piv_user_dismask,tfm_init_user_binary1{ivid},[],[],[]);
        
        if frame==tfm_piv_user_relax{ivid}
            tfm_piv_user_meand{ivid,frame}=NaN;
        else
            tfm_piv_user_meand{ivid,frame}=displacement*tfm_init_user_conversion{ivid}*1e-6;
        end
        
    end
    
end
%statusbar
    sb=statusbar(h_piv(1).fig,'Calculation - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));

%enable ok button & checkbox
set(h_piv(1).button_ok,'Visible','on')
set(h_piv(1).checkbox_matrix,'Visible','on')
set(h_piv(1).checkbox_heatmaps,'Visible','on')

catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end


%save for shared use
setappdata(0,'tfm_piv_user_meand',tfm_piv_user_meand)

function piv_push_backwards(hObject, eventdata, h_piv)
%disable figure during calculation
enableDisableFig(h_piv(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_piv(1).fig,1));


try
    %load shared needed para
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_piv_user_contr=getappdata(0,'tfm_piv_user_contr');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_piv_user_d=getappdata(0,'tfm_piv_user_d');
    tfm_piv_user_counter=getappdata(0,'tfm_piv_user_counter');
        
    %update counter 
    tfm_piv_user_counter=tfm_piv_user_counter-1;
       
    %now display info for current video.
    set(h_piv(1).edit_ref_ref,'String',num2str(tfm_piv_user_relax{tfm_piv_user_counter}));
    set(h_piv(1).edit_ref_contr,'String',num2str(tfm_piv_user_contr{tfm_piv_user_counter}));
    
    %display displacement plot
    axes(h_piv(1).axes_ref);
    plot(1:length(tfm_piv_user_d{tfm_piv_user_counter}),tfm_piv_user_d{tfm_piv_user_counter}*1e6)
    set(h_piv(1).axes_ref, 'XTick', []);
    set(h_piv(1).axes_ref, 'YTick', []);
    
    %buttons
    %set(h_piv(1).button_ok,'Visible','on');
    if tfm_piv_user_counter>1
        set(h_piv(1).button_backwards,'Enable','on');
    else
        set(h_piv(1).button_backwards,'Enable','off');
    end
    if tfm_piv_user_counter==tfm_init_user_Nfiles
        set(h_piv(1).button_forwards,'Enable','off');
    else
        set(h_piv(1).button_forwards,'Enable','on');
    end
      
    %set texts to 1st vid
    set(h_piv(1).text_whichvidname,'String',tfm_init_user_filenamestack{1,tfm_piv_user_counter});
    set(h_piv(1).text_whichvid,'String',[num2str(tfm_piv_user_counter),'/',num2str(tfm_init_user_Nfiles)]);
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end


%store everything for shared use
setappdata(0,'tfm_piv_user_counter',tfm_piv_user_counter);

function piv_push_forwards(hObject, eventdata, h_piv)
%disable figure during calculation
enableDisableFig(h_piv(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_piv(1).fig,1));


try
    %load shared needed para
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_piv_user_contr=getappdata(0,'tfm_piv_user_contr');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_piv_user_d=getappdata(0,'tfm_piv_user_d');
    tfm_piv_user_counter=getappdata(0,'tfm_piv_user_counter');
        
    %update counter 
    tfm_piv_user_counter=tfm_piv_user_counter+1;
       
    %now display info for current video.
    set(h_piv(1).edit_ref_ref,'String',num2str(tfm_piv_user_relax{tfm_piv_user_counter}));
    set(h_piv(1).edit_ref_contr,'String',num2str(tfm_piv_user_contr{tfm_piv_user_counter}));
    
    %display displacement plot
    axes(h_piv(1).axes_ref);
    plot(1:length(tfm_piv_user_d{tfm_piv_user_counter}),tfm_piv_user_d{tfm_piv_user_counter}*1e6)
    set(h_piv(1).axes_ref, 'XTick', []);
    set(h_piv(1).axes_ref, 'YTick', []);
    
    %buttons
    %set(h_piv(1).button_ok,'Visible','on');
    if tfm_piv_user_counter>1
        set(h_piv(1).button_backwards,'Enable','on');
    else
        set(h_piv(1).button_backwards,'Enable','off');
    end
    if tfm_piv_user_counter==tfm_init_user_Nfiles
        set(h_piv(1).button_forwards,'Enable','off');
    else
        set(h_piv(1).button_forwards,'Enable','on');
    end
      
    %set texts to 1st vid
    set(h_piv(1).text_whichvidname,'String',tfm_init_user_filenamestack{1,tfm_piv_user_counter});
    set(h_piv(1).text_whichvid,'String',[num2str(tfm_piv_user_counter),'/',num2str(tfm_init_user_Nfiles)]);
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end


%store everything for shared use
setappdata(0,'tfm_piv_user_counter',tfm_piv_user_counter);

function piv_push_ok(hObject, eventdata, h_piv, h_main)
%disable figure during calculation
enableDisableFig(h_piv(1).fig,0);

%turn back on in the end
%clean1=onCleanup(@()enableDisableFig(h_piv(1).fig,1));


try
    %load what shared para we need
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_init_user_Nframes=getappdata(0,'tfm_init_user_Nframes');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_init_user_pathnamestack=getappdata(0,'tfm_init_user_pathnamestack');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_piv_user_contr=getappdata(0,'tfm_piv_user_contr');
  
    %add relaxed/contracted to excel file
    for ivid=1:tfm_init_user_Nfiles
        sb=statusbar(h_piv(1).fig,['Saving to Excel... ',num2str(floor(100*(ivid-1)/tfm_init_user_Nfiles)), '%% done']);
        sb.getComponent(0).setForeground(java.awt.Color.red);
        
        newfile=[tfm_init_user_pathnamestack{1,ivid},'/',tfm_init_user_filenamestack{1,ivid},'/Results/',tfm_init_user_filenamestack{1,ivid},'.xls'];
        A = {tfm_piv_user_relax{ivid},tfm_piv_user_contr{ivid}};
        sheet = 'General';
        xlRange = 'F3';
        xlwrite(newfile,A,sheet,xlRange)
    end
    %statusbar
    sb=statusbar(h_piv(1).fig,'Saving - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %check if user wants to save
    value = get(h_piv(1).checkbox_matrix, 'Value');
    
    if value
        w_i=0;
        %loop over videos
        for ivid=1:tfm_init_user_Nfiles
            %make output folder for displacements
            if ~isequal(exist([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Displacements'], 'dir'),7)
                mkdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Displacements'])
            end
            
            %loop over frames
            for ifr=1:tfm_init_user_Nframes{ivid}
                %waitbar
                w_i=w_i+1;
                sb=statusbar(h_piv(1).fig,['Saving full fields... ',num2str(floor(100*(w_i-1)/sum([tfm_init_user_Nframes{:}]))), '%% done']);
                sb.getComponent(0).setForeground(java.awt.Color.red);
                %copy displacements
                copyfile(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_x_',num2str(ifr),'.mat'],[tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Displacements/piv_x_',num2str(ifr),'.mat']);
                copyfile(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_y_',num2str(ifr),'.mat'],[tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Displacements/piv_y_',num2str(ifr),'.mat']);
                copyfile(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_u_',num2str(ifr),'.mat'],[tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Displacements/piv_u_',num2str(ifr),'.mat']);
                copyfile(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_v_',num2str(ifr),'.mat'],[tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Displacements/piv_v_',num2str(ifr),'.mat']);
            end
        end
        %statusbar
        sb=statusbar(h_piv(1).fig,'Saving - Done !');
        sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    end
    
    %check if user wants to save heatmaps
    value = get(h_piv(1).checkbox_heatmaps, 'Value');
    
    if ~value
        for ivid=1:tfm_init_user_Nfiles
        rmdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Displacement Heatmaps'],'s')
        end
    end
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

%enable fig
enableDisableFig(h_piv(1).fig,1)


%change main windows 3. button status
set(h_main(1).button_piv,'ForegroundColor',[0 .5 0]);
set(h_main(1).button_tfm,'Enable','on');

%close window
close(h_piv(1).fig);

%move main window to the side
movegui(h_main(1).fig,'center')

function piv_checkbox(hObject, eventdata, h_piv)
if get(h_piv(1).checkbox,'Value')
    set(h_piv(1).panel_post,'Visible','on')
else
    set(h_piv(1).panel_post,'Visible','off')
end
