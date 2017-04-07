%beads_para.m ; part of the Beads GUI: execute beads_main.m
%version 2.0.1
%written by O. Schwab (oschwab@stanford.edu)
%last change: 01/04/15

function beads_para(h_main)
%main function for the parameter window of lifeact gui

%create new window for parameter
%fig size
figsize=[650,955];
%get screen size
screensize = get(0,'ScreenSize');
%position fig on center of screen
xpos = ceil((screensize(3)-figsize(2))/2);
ypos = ceil((screensize(4)-figsize(1))/2);
%create fig; invisible at first
h_para(1).fig=figure(...
    'position',[xpos, ypos, figsize(2), figsize(1)],...
    'units','pixels',...
    'renderer','OpenGL',...
    'MenuBar','none',...
    'PaperPositionMode','auto',...
    'Name','Beads Parameters',...
    'NumberTitle','off',...
    'Resize','off',...
    'Color',[.94,.94,.94],...
    'visible','off');

%create uipanel for guess
h_para(1).panel_guess = uipanel('Parent',h_para(1).fig,'Title','Determine parameters','units','pixels','Position',[20,590,145,50]);
%button
h_para(1).button_guess = uicontrol('Parent',h_para(1).panel_guess,'style','pushbutton','position',[5,5,132,25],'string','Guess all');

%uipanel for pattern ratio
h_para(1).panel_ratio = uipanel('Parent',h_para(1).fig,'Title','Ratio of the patterns','units','pixels','Position',[175,590,145,50]);
%edit
h_para(1).edit_ratio = uicontrol('Parent',h_para(1).panel_ratio,'style','edit','position',[5,5,132,25]);

%uipanel for displacements
h_para(1).panel_disp = uipanel('Parent',h_para(1).fig,'Title','Displacements','units','pixels','Position',[20,400,300,180]);
%axes
h_para(1).axes_disp = axes('Parent',h_para(1).panel_disp,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%button: addmax
h_para(1).button_disp_addmax = uicontrol('Parent',h_para(1).panel_disp,'style','pushbutton','position',[5,25,70,20],'string','Add max');
%button: removemax
h_para(1).button_disp_removemax = uicontrol('Parent',h_para(1).panel_disp,'style','pushbutton','position',[5,5,70,20],'string','Remove max');
%button: addmin
h_para(1).button_disp_addmin = uicontrol('Parent',h_para(1).panel_disp,'style','pushbutton','position',[75,25,70,20],'string','Add min');
%button: removemin
h_para(1).button_disp_removemin = uicontrol('Parent',h_para(1).panel_disp,'style','pushbutton','position',[75,5,70,20],'string','Remove min');
%button: clearall
h_para(1).button_disp_clearall = uicontrol('Parent',h_para(1).panel_disp,'style','pushbutton','position',[145,5,35,40],'string','Clear');
%text: deltad
h_para(1).text_disp = uicontrol('Parent',h_para(1).panel_disp,'style','text','position',[185,25,110,15],'HorizontalAlignment','left','string','Delta d = ');

%uipanel for velocities
h_para(1).panel_vel = uipanel('Parent',h_para(1).fig,'Title','Velocities','units','pixels','Position',[20,215,300,180]);
%axes
h_para(1).axes_vel = axes('Parent',h_para(1).panel_vel,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%button: addmax
h_para(1).button_vel_addmax = uicontrol('Parent',h_para(1).panel_vel,'style','pushbutton','position',[5,25,70,20],'string','Add max');
%button: removemax
h_para(1).button_vel_removemax = uicontrol('Parent',h_para(1).panel_vel,'style','pushbutton','position',[5,5,70,20],'string','Remove max');
%button: addmin
h_para(1).button_vel_addmin = uicontrol('Parent',h_para(1).panel_vel,'style','pushbutton','position',[75,25,70,20],'string','Add min');
%button: removemin
h_para(1).button_vel_removemin = uicontrol('Parent',h_para(1).panel_vel,'style','pushbutton','position',[75,5,70,20],'string','Remove min');
%button: clearall
h_para(1).button_vel_clearall = uicontrol('Parent',h_para(1).panel_vel,'style','pushbutton','position',[145,5,35,40],'string','Clear');
%text: vcontr
h_para(1).text_vel1 = uicontrol('Parent',h_para(1).panel_vel,'style','text','position',[185,25,110,15],'HorizontalAlignment','left','string','vcontr = ');
%text: vrelax
h_para(1).text_vel2 = uicontrol('Parent',h_para(1).panel_vel,'style','text','position',[185,5,110,15],'HorizontalAlignment','left','string','vrelax = ');

%uipanel for frequencies
h_para(1).panel_freq = uipanel('Parent',h_para(1).fig,'Title','Frequency','units','pixels','Position',[20,30,300,180]);
%axes
h_para(1).axes_freq = axes('Parent',h_para(1).panel_freq,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%radiobutton group for user eval
h_para(1).buttongroup_freq = uibuttongroup('Parent',h_para(1).panel_freq,'Units', 'pixels','Position',[5,5,70,40]);
%radiobutton 1: fft
h_para(1).radiobutton_fft = uicontrol('Parent',h_para(1).buttongroup_freq,'style','radiobutton','position',[5,20,60,15],'string','FFT','tag','radiobutton_fft');
%radiobutton 1: pick
h_para(1).radiobutton_pick = uicontrol('Parent',h_para(1).buttongroup_freq,'style','radiobutton','position',[5,5,60,15],'string','Pick','tag','radiobutton_pick');
%button: add
h_para(1).button_freq_add = uicontrol('Parent',h_para(1).panel_freq,'style','pushbutton','position',[75,25,70,20],'string','Add');
%button: add fft
h_para(1).button_freq_addfft = uicontrol('Parent',h_para(1).panel_freq,'style','pushbutton','position',[75,25,70,20],'string','Pick');
%button: remove
h_para(1).button_freq_remove = uicontrol('Parent',h_para(1).panel_freq,'style','pushbutton','position',[75,5,70,20],'string','Remove');
%button: clearall
h_para(1).button_freq_clearall = uicontrol('Parent',h_para(1).panel_freq,'style','pushbutton','position',[145,5,35,40],'string','Clear');
%text: f
h_para(1).text_freq1 = uicontrol('Parent',h_para(1).panel_freq,'style','text','position',[185,25,110,15],'HorizontalAlignment','left','string','f = ');
%text: T
h_para(1).text_freq2 = uicontrol('Parent',h_para(1).panel_freq,'style','text','position',[185,5,110,15],'HorizontalAlignment','left','string','T = ');

%uipanel for forces
h_para(1).panel_forces = uipanel('Parent',h_para(1).fig,'Title','Forces','units','pixels','Position',[330,400,300,180]);
%axes
h_para(1).axes_forces = axes('Parent',h_para(1).panel_forces,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%button: addmax
h_para(1).button_forces_addmax = uicontrol('Parent',h_para(1).panel_forces,'style','pushbutton','position',[50,25,70,20],'string','Add max');
%button: removemax
h_para(1).button_forces_removemax = uicontrol('Parent',h_para(1).panel_forces,'style','pushbutton','position',[50,5,70,20],'string','Remove max');
%button: addmin
h_para(1).button_forces_addmin = uicontrol('Parent',h_para(1).panel_forces,'style','pushbutton','position',[120,25,70,20],'string','Add min');
%button: removemin
h_para(1).button_forces_removemin = uicontrol('Parent',h_para(1).panel_forces,'style','pushbutton','position',[120,5,70,20],'string','Remove min');
%button: clearall
h_para(1).button_forces_clearall = uicontrol('Parent',h_para(1).panel_forces,'style','pushbutton','position',[190,25,35,20],'string','Clear');
%text: deltaf
h_para(1).text_forces = uicontrol('Parent',h_para(1).panel_forces,'style','text','position',[195,5,100,15],'HorizontalAlignment','left','string','F = ');
%radiobutton group for user eval
h_para(1).buttongroup_forces = uibuttongroup('Parent',h_para(1).panel_forces,'Units', 'pixels','Position',[5,5,43,40]);
%radiobutton 1: tot
h_para(1).radiobutton_forcetot = uicontrol('Parent',h_para(1).buttongroup_forces,'style','radiobutton','position',[1,26,35,10],'string','|F|','tag','radiobutton_ftot');
%radiobutton 2: x
h_para(1).radiobutton_forcex = uicontrol('Parent',h_para(1).buttongroup_forces,'style','radiobutton','position',[1,14,37,10],'string','|Fx|','tag','radiobutton_fx');
%radiobutton 2: x
h_para(1).radiobutton_forcey = uicontrol('Parent',h_para(1).buttongroup_forces,'style','radiobutton','position',[1,2,37,10],'string','|Fy|','tag','radiobutton_fy');

%uipanel for power
h_para(1).panel_power = uipanel('Parent',h_para(1).fig,'Title','Power','units','pixels','Position',[330,215,300,180]);
%axes
h_para(1).axes_power = axes('Parent',h_para(1).panel_power,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%button: addmax
h_para(1).button_power_addmax = uicontrol('Parent',h_para(1).panel_power,'style','pushbutton','position',[5,25,70,20],'string','Add max');
%button: removemax
h_para(1).button_power_removemax = uicontrol('Parent',h_para(1).panel_power,'style','pushbutton','position',[5,5,70,20],'string','Remove max');
%button: addmin
h_para(1).button_power_addmin = uicontrol('Parent',h_para(1).panel_power,'style','pushbutton','position',[75,25,70,20],'string','Add min');
%button: removemin
h_para(1).button_power_removemin = uicontrol('Parent',h_para(1).panel_power,'style','pushbutton','position',[75,5,70,20],'string','Remove min');
%button: clearall
h_para(1).button_power_clearall = uicontrol('Parent',h_para(1).panel_power,'style','pushbutton','position',[145,5,35,40],'string','Clear');
%text: Pcontr
h_para(1).text_power1 = uicontrol('Parent',h_para(1).panel_power,'style','text','position',[185,25,110,15],'HorizontalAlignment','left','string','Pcontr = ');
%text: Prelax
h_para(1).text_power2 = uicontrol('Parent',h_para(1).panel_power,'style','text','position',[185,5,110,15],'HorizontalAlignment','left','string','Prelax = ');

%uipanel for contraction time
h_para(1).panel_contr = uipanel('Parent',h_para(1).fig,'Title','Contraction time equivalent','units','pixels','Position',[330,30,300,180]);
%axes
h_para(1).axes_contr = axes('Parent',h_para(1).panel_contr,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%button: add
h_para(1).button_contr_add = uicontrol('Parent',h_para(1).panel_contr,'style','pushbutton','position',[5,25,70,20],'string','Add');
%button: remove
h_para(1).button_contr_remove = uicontrol('Parent',h_para(1).panel_contr,'style','pushbutton','position',[5,5,70,20],'string','Remove');
%button: clearall
h_para(1).button_contr_clearall = uicontrol('Parent',h_para(1).panel_contr,'style','pushbutton','position',[75,5,35,40],'string','Clear');
%text: tcontr
h_para(1).text_contr = uicontrol('Parent',h_para(1).panel_contr,'style','text','position',[115,25,110,15],'HorizontalAlignment','left','string','t = ');

%uipanel for double peaks
h_para(1).panel_dp = uipanel('Parent',h_para(1).fig,'Title','Double peaks','units','pixels','Position',[640,400,300,240]);
%text: dp?
h_para(1).text_dp = uicontrol('Parent',h_para(1).panel_dp,'style','text','position',[5,205,150,15],'HorizontalAlignment','left','string','Are there double peaks?');
%checkbox: yes
h_para(1).checkbox_dpyes = uicontrol('Parent',h_para(1).panel_dp,'style','checkbox','position',[160,200,50,25],'string','Yes','HorizontalAlignment','left');
%checkbox: no
h_para(1).checkbox_dpno = uicontrol('Parent',h_para(1).panel_dp,'style','checkbox','position',[220,200,50,25],'string','No','HorizontalAlignment','left','value',1);
%uipanel for dp para
h_para(1).panel_dp2 = uipanel('Parent',h_para(1).panel_dp,'units','pixels','Position',[5,5,290,190]);
%axes
h_para(1).axes_dp2 = axes('Parent',h_para(1).panel_dp2,'Units', 'pixels','Position',[5,65,277,115],'box','on');
%text: time betw main&sec
h_para(1).text_dp2_1 = uicontrol('Parent',h_para(1).panel_dp2,'style','text','position',[5,45,200,15],'HorizontalAlignment','left','string','Time main-sec. peak');
%button: add
h_para(1).button_dp2_add = uicontrol('Parent',h_para(1).panel_dp2,'style','pushbutton','position',[5,25,70,20],'string','Add');
%button: remove
h_para(1).button_dp2_remove = uicontrol('Parent',h_para(1).panel_dp2,'style','pushbutton','position',[5,5,70,20],'string','Remove');
%button: clearall
h_para(1).button_dp2_clearall = uicontrol('Parent',h_para(1).panel_dp2,'style','pushbutton','position',[75,5,35,40],'string','Clear');
%text: t
h_para(1).text_dp2_2 = uicontrol('Parent',h_para(1).panel_dp2,'style','text','position',[115,45,110,15],'HorizontalAlignment','left','string','t = ');
%text: ratio peaks
h_para(1).text_dp2_3 = uicontrol('Parent',h_para(1).panel_dp2,'style','text','position',[160,25,120,15],'HorizontalAlignment','left','string','Ratio normal/double');
%edit: ratio peaks
h_para(1).edit_dp2 = uicontrol('Parent',h_para(1).panel_dp2,'style','edit','position',[160,5,120,20]);

%uipanel for preview
h_para(1).panel_preview = uipanel('Parent',h_para(1).fig,'Title','Preview of current outline','units','pixels','Position',[640,215,300,180]);
%axes
h_para(1).axes_preview = axes('Parent',h_para(1).panel_preview,'Units', 'pixels','Position',[5,5,287,160],'box','on');

%uipanel for arrythmia
h_para(1).panel_tag = uipanel('Parent',h_para(1).fig,'Title','Arrhythmia','units','pixels','Position',[330,590,300,50]);
%checkbox
h_para(1).checkbox_tag = uicontrol('Parent',h_para(1).panel_tag,'style','checkbox','position',[5,5,287,25],'string','Tag if not useful for further analysis','HorizontalAlignment','left');

%button: forwards
h_para(1).button_forwards = uicontrol('Parent',h_para(1).fig,'style','pushbutton','position',[665,177,25,25],'string','>');
%button: backwards
h_para(1).button_backwards = uicontrol('Parent',h_para(1).fig,'style','pushbutton','position',[640,177,25,25],'string','<');
%text: show which video (i/n)
h_para(1).text_whichvid = uicontrol('Parent',h_para(1).fig,'style','text','position',[695,185,25,15],'string','(1/1)','HorizontalAlignment','left');
%text: show which video (name)
h_para(1).text_whichvidname = uicontrol('Parent',h_para(1).fig,'style','text','position',[640,160,100,15],'string','Experiment','HorizontalAlignment','left');

%create ok button
h_para(1).button_ok = uicontrol('Parent',h_para(1).fig,'style','pushbutton','position',[890,25,45,20],'string','OK','visible','on');
%create save checkbox
h_para(1).checkbox_save = uicontrol('Parent',h_para(1).fig,'style','checkbox','position',[640,30,150,15],'string','Save plots {.fig,.png}','HorizontalAlignment','left');

%callbacks for buttons and buttongroup
set(h_para(1).button_guess,'callback',{@para_push_guess,h_para})
set(h_para(1).button_disp_addmax,'callback',{@para_push_disp_addmax,h_para})
set(h_para(1).button_disp_addmin,'callback',{@para_push_disp_addmin,h_para})
set(h_para(1).button_disp_removemax,'callback',{@para_push_disp_removemax,h_para})
set(h_para(1).button_disp_removemin,'callback',{@para_push_disp_removemin,h_para})
set(h_para(1).button_disp_clearall,'callback',{@para_push_disp_clearall,h_para})
set(h_para(1).button_vel_addmax,'callback',{@para_push_vel_addmax,h_para})
set(h_para(1).button_vel_addmin,'callback',{@para_push_vel_addmin,h_para})
set(h_para(1).button_vel_removemax,'callback',{@para_push_vel_removemax,h_para})
set(h_para(1).button_vel_removemin,'callback',{@para_push_vel_removemin,h_para})
set(h_para(1).button_vel_clearall,'callback',{@para_push_vel_clearall,h_para})
set(h_para(1).button_freq_add,'callback',{@para_push_freq_add,h_para})
set(h_para(1).button_freq_addfft,'callback',{@para_push_freq_addfft,h_para})
set(h_para(1).button_freq_remove,'callback',{@para_push_freq_remove,h_para})
set(h_para(1).button_freq_clearall,'callback',{@para_push_freq_clearall,h_para})
set(h_para(1).button_forces_addmax,'callback',{@para_push_forces_addmax,h_para})
set(h_para(1).button_forces_addmin,'callback',{@para_push_forces_addmin,h_para})
set(h_para(1).button_forces_removemax,'callback',{@para_push_forces_removemax,h_para})
set(h_para(1).button_forces_removemin,'callback',{@para_push_forces_removemin,h_para})
set(h_para(1).button_forces_clearall,'callback',{@para_push_forces_clearall,h_para})
set(h_para(1).button_power_addmax,'callback',{@para_push_power_addmax,h_para})
set(h_para(1).button_power_addmin,'callback',{@para_push_power_addmin,h_para})
set(h_para(1).button_power_removemax,'callback',{@para_push_power_removemax,h_para})
set(h_para(1).button_power_removemin,'callback',{@para_push_power_removemin,h_para})
set(h_para(1).button_power_clearall,'callback',{@para_push_power_clearall,h_para})
set(h_para(1).button_contr_add,'callback',{@para_push_contr_add,h_para})
set(h_para(1).button_contr_remove,'callback',{@para_push_contr_remove,h_para})
set(h_para(1).button_contr_clearall,'callback',{@para_push_contr_clearall,h_para})
set(h_para(1).button_dp2_add,'callback',{@para_push_dp2_add,h_para})
set(h_para(1).button_dp2_remove,'callback',{@para_push_dp2_remove,h_para})
set(h_para(1).button_dp2_clearall,'callback',{@para_push_dp2_clearall,h_para})
set(h_para(1).button_forwards,'callback',{@para_push_forwards,h_para})
set(h_para(1).button_backwards,'callback',{@para_push_backwards,h_para})
set(h_para(1).button_ok,'callback',{@para_push_ok,h_para,h_main})
set(h_para(1).buttongroup_freq,'SelectionChangeFcn',{@para_buttongroup_freq,h_para})
set(h_para(1).buttongroup_forces,'SelectionChangeFcn',{@para_buttongroup_forces,h_para})
set(h_para(1).checkbox_dpyes,'callback',{@para_checkbox_dpyes,h_para})
set(h_para(1).checkbox_dpno,'callback',{@para_checkbox_dpno,h_para})
set(h_para(1).checkbox_tag,'callback',{@para_checkbox_tag,h_para})

%prelimiary stuff
%hide and disable buttons and panels
set(h_para(1).panel_disp,'Visible','off');
set(h_para(1).panel_ratio,'Visible','off');
set(h_para(1).panel_vel,'Visible','off');
set(h_para(1).panel_freq,'Visible','off');
set(h_para(1).panel_forces,'Visible','off');
set(h_para(1).panel_power,'Visible','off');
set(h_para(1).panel_contr,'Visible','off');
set(h_para(1).panel_dp,'Visible','off');
set(h_para(1).panel_tag,'Visible','off');
set(h_para(1).text_whichvidname,'Visible','off');
set(h_para(1).text_whichvid,'Visible','off');
set(h_para(1).button_ok,'Visible','off');
set(h_para(1).button_backwards,'Visible','off');
set(h_para(1).button_forwards,'Visible','off');
set(h_para(1).panel_preview,'Visible','off');
set(h_para(1).checkbox_save,'Visible','off');

%initiate counter
tfm_para_user_counter=1;

%store everything for shared use
setappdata(0,'tfm_para_user_counter',tfm_para_user_counter)

%make fig visible
set(h_para(1).fig,'visible','on');

%move main window to the side
movegui(h_main(1).fig,'west')

function para_push_guess(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));

try
    sb=statusbar(h_para(1).fig,'Calculating... ');
    sb.getComponent(0).setForeground(java.awt.Color.red);
    
    %grey out button, do not turn it back on
    set(h_para(1).button_guess,'Enable','off')
    
    %load shared needed para
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_init_user_Nframes=getappdata(0,'tfm_init_user_Nframes');
    tfm_piv_user_meand=getappdata(0,'tfm_piv_user_meand');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_init_user_binary1=getappdata(0,'tfm_init_user_binary1');
    tfm_init_user_outline2x=getappdata(0,'tfm_init_user_outline2x');
    tfm_init_user_outline2y=getappdata(0,'tfm_init_user_outline2y');
    
    %initialize
    F_tot=cell(1,max([tfm_init_user_Nframes{:}]));
    Fx_tot=cell(1,max([tfm_init_user_Nframes{:}]));
    Fy_tot=cell(1,max([tfm_init_user_Nframes{:}]));
    Velocity=cell(1,tfm_init_user_Nfiles);
    Power=cell(1,tfm_init_user_Nfiles);
    dmax=cell(1,tfm_init_user_Nfiles);
    dmin=cell(1,tfm_init_user_Nfiles);
    dt=cell(1,tfm_init_user_Nfiles);
    vmax=cell(1,tfm_init_user_Nfiles);
    vmin=cell(1,tfm_init_user_Nfiles);
    Fxmax=cell(1,tfm_init_user_Nfiles);
    Fymax=cell(1,tfm_init_user_Nfiles);
    Fxmin=cell(1,tfm_init_user_Nfiles);
    Fymin=cell(1,tfm_init_user_Nfiles);
    Fmax=cell(1,tfm_init_user_Nfiles);
    Fmin=cell(1,tfm_init_user_Nfiles);
    Pmax=cell(1,tfm_init_user_Nfiles);
    Pmin=cell(1,tfm_init_user_Nfiles);
    y_fft=cell(1,tfm_init_user_Nfiles);
    freq=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_d=cell(1,tfm_init_user_Nfiles);
    
    %calc. forces
    for current_vid=1:tfm_init_user_Nfiles
        %
        %transform mask, st 0s become Nans
        mask=double(tfm_init_user_binary1{current_vid});
        mask(mask==0)=NaN;
        
        for frame=1:tfm_init_user_Nframes{current_vid}
            %load spacing
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_x_',num2str(frame),'.mat'],'x');
            x=s.x;
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_y_',num2str(frame),'.mat'],'y');
            y=s.y;
            %load tfm data
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/tfm_Fx_',num2str(frame),'.mat'],'Fx');
            Fx=s.Fx.*mask(y(:,1) ,x(1,:));
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/tfm_Fy_',num2str(frame),'.mat'],'Fy');
            Fy=s.Fy.*mask(y(:,1) ,x(1,:));
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/tfm_F_',num2str(frame),'.mat'],'F');
            F=s.F.*mask(y(:,1) ,x(1,:));
            
            %total force: make vector, sum over vector.
            F_vec = subsref((F).', substruct('()', {':'})).';
            Fx_vec = subsref((Fx).', substruct('()', {':'})).';
            Fy_vec = subsref((Fy).', substruct('()', {':'})).';
            F_tot{current_vid}(frame)=sum(F_vec(~isnan(F_vec)));
            Fx_tot{current_vid}(frame)=sum(abs(Fx_vec(~isnan(Fx_vec))));
            Fy_tot{current_vid}(frame)=sum(abs(Fy_vec(~isnan(Fy_vec))));
        end
        F_tot{current_vid}(tfm_piv_user_relax{current_vid})=NaN;
        Fx_tot{current_vid}(tfm_piv_user_relax{current_vid})=NaN;
        Fy_tot{current_vid}(tfm_piv_user_relax{current_vid})=NaN;
        
    end
    
    %format diplacements
    for current_vid=1:tfm_init_user_Nfiles
        tfm_para_user_d{current_vid}=[tfm_piv_user_meand{current_vid,:}];
    end
    
    %calculate velocity
    for current_vid=1:tfm_init_user_Nfiles
        %
        Velocity{current_vid}=zeros(1,tfm_init_user_Nframes{current_vid})*NaN;
        for frame=2:tfm_init_user_Nframes{current_vid}-1
            %velocities
            D1=tfm_para_user_d{current_vid}(frame-1);
            D2=tfm_para_user_d{current_vid}(frame+1);
            Velocity{current_vid}(frame)=(D2-D1)/2*tfm_init_user_framerate{current_vid};        %-1 so that it starts at 1
        end
        
        %%denoise
        %Velocity{current_vid}=inpaint_nans(Velocity{current_vid});
        %[Velocity{current_vid}, ~, ~] = wdemeandn(Velocity{current_vid}, 'minimaxi', 's', 'sln', 2, 'db5');
    end
    
    
    %calculate power
    for current_vid=1:tfm_init_user_Nfiles
        %
        Power{current_vid}=zeros(1,tfm_init_user_Nframes{current_vid})*NaN;
        for frame=2:tfm_init_user_Nframes{current_vid}-1
            %power
            Power{current_vid}(frame)=F_tot{current_vid}(frame)*Velocity{current_vid}(frame);
        end
        %denoise
        %Power{current_vid}=inpaint_nans(Power{current_vid});
        %%[Power{current_vid}, ~, ~] = wden(Power{current_vid}, 'minimaxi', 's', 'sln', 2, 'db5');
    end
    
    %guess peaks
    for current_vid=1:tfm_init_user_Nfiles
        %guess max/min. displ.
        [dmax{current_vid}, dmin{current_vid}] = peakdet(tfm_para_user_d{current_vid}, 0.5*(max(tfm_para_user_d{current_vid})-min(tfm_para_user_d{current_vid})));
        dt{current_vid}=(1:length(tfm_para_user_d{current_vid}))/tfm_init_user_framerate{current_vid};
        %veloc.
        [vmax{current_vid}, vmin{current_vid}] = peakdet(Velocity{current_vid}, 0.5*(max(Velocity{current_vid})-min(Velocity{current_vid})));
        %Fx.
        [Fxmax{current_vid}, Fxmin{current_vid}] = peakdet(Fx_tot{current_vid}, 0.5*(max(Fx_tot{current_vid})-min(Fx_tot{current_vid})));
        %Fy.
        [Fymax{current_vid}, Fymin{current_vid}] = peakdet(Fy_tot{current_vid}, 0.5*(max(Fy_tot{current_vid})-min(Fy_tot{current_vid})));
        %F.
        [Fmax{current_vid}, Fmin{current_vid}] = peakdet(F_tot{current_vid}, 0.5*(max(F_tot{current_vid})-min(F_tot{current_vid})));
        %P.
        [Pmax{current_vid}, Pmin{current_vid}] = peakdet(Power{current_vid}, 0.5*(max(Power{current_vid})-min(Power{current_vid})));
        if isempty(dmax{current_vid})
            dmax{current_vid}(:,1)=NaN; dmax{current_vid}(:,2)=NaN;
        end
        if isempty(dmin{current_vid})
            dmin{current_vid}(:,1)=NaN; dmin{current_vid}(:,2)=NaN;
        end
        if isempty(vmax{current_vid})
            vmax{current_vid}(:,1)=NaN; vmax{current_vid}(:,2)=NaN;
        end
        if isempty(vmin{current_vid})
            vmin{current_vid}(:,1)=NaN; vmin{current_vid}(:,2)=NaN;
        end
        if isempty(Fxmax{current_vid})
            Fxmax{current_vid}(:,1)=NaN; Fxmax{current_vid}(:,2)=NaN;
        end
        if isempty(Fxmin{current_vid})
            Fxmin{current_vid}(:,1)=NaN; Fxmin{current_vid}(:,2)=NaN;
        end
        if isempty(Fymax{current_vid})
            Fymax{current_vid}(:,1)=NaN; Fymax{current_vid}(:,2)=NaN;
        end
        if isempty(Fymin{current_vid})
            Fymin{current_vid}(:,1)=NaN; Fymin{current_vid}(:,2)=NaN;
        end
        if isempty(Fmax{current_vid})
            Fmax{current_vid}(:,1)=NaN; Fmax{current_vid}(:,2)=NaN;
        end
        if isempty(Fmin{current_vid})
            Fmin{current_vid}(:,1)=NaN; Fmin{current_vid}(:,2)=NaN;
        end
        if isempty(Pmax{current_vid})
            Pmax{current_vid}(:,1)=NaN; Pmax{current_vid}(:,2)=NaN;
        end
        if isempty(Pmin{current_vid})
            Pmin{current_vid}(:,1)=NaN; Pmin{current_vid}(:,2)=NaN;
        end
    end
    
    %frequency
    for current_vid=1:tfm_init_user_Nfiles
        %dt, tfm_para_user_d{current_vid}
        Nsamps = length(dt{current_vid});
        Fs=tfm_init_user_framerate{current_vid};
        %t = (1/Fs)*(1:Nsamps);
        %Do Fourier Transform
        y=tfm_para_user_d{current_vid};
        y(isnan(y))=0;
        y_fft0 = abs(fft(y));            %Retain Magnitude
        y_fft{current_vid} = y_fft0(1:Nsamps/2);      %Discard Half of Points
        freq{current_vid} = Fs*(0:Nsamps/2-1)/Nsamps;   %Prepare freq data for plot
    end
    
    %plot 1st displ. in axes
    reset(h_para(1).axes_disp)
    axes(h_para(1).axes_disp)
    plot(dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(dmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},dmin{tfm_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(dmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},dmax{tfm_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %displ. in double peak
    reset(h_para(1).axes_dp2)
    axes(h_para(1).axes_dp2)
    plot(dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    
    %plot 1st velocity. in axes
    reset(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(dt{tfm_para_user_counter},zeros(1,length(dt{tfm_para_user_counter})),'--k'), hold on;
    plot(dt{tfm_para_user_counter},Velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(vmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},vmin{tfm_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(vmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},vmax{tfm_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    if get(h_para(1).radiobutton_forcex,'Value')
        %plot 1st forcex. in axes
        reset(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(dt{tfm_para_user_counter},Fx_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(Fxmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fxmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        plot(Fxmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fxmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
    elseif get(h_para(1).radiobutton_forcey,'Value')
        %plot 1st forcey. in axes
        reset(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(dt{tfm_para_user_counter},Fy_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(Fymin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fymin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        plot(Fymax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fymax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
    elseif get(h_para(1).radiobutton_forcetot,'Value')
        %plot 1st force. in axes
        reset(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(dt{tfm_para_user_counter},F_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(Fmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        plot(Fmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
    end
    
    %plot 1st power. in axes
    reset(h_para(1).axes_power)
    axes(h_para(1).axes_power)
    plot(dt{tfm_para_user_counter},zeros(1,length(dt{tfm_para_user_counter})),'--k'), hold on;
    plot(dt{tfm_para_user_counter},Power{tfm_para_user_counter}*1e12,'-b'), hold on;
    plot(Pmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Pmin{tfm_para_user_counter}(:,2)*1e12,'.r'), hold on;
    plot(Pmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Pmax{tfm_para_user_counter}(:,2)*1e12,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %%plot 1st velocity. in axes
    reset(h_para(1).axes_contr)
    axes(h_para(1).axes_contr)
    plot(dt{tfm_para_user_counter},Velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %freq.
    if get(h_para(1).radiobutton_fft,'Value')
        %make unwanted buttons invisible
        set(h_para(1).button_freq_add,'Visible','off');
        set(h_para(1).button_freq_remove,'Visible','off');
        set(h_para(1).button_freq_clearall,'Visible','off');
        %enable wanted button
        set(h_para(1).button_freq_addfft,'Visible','on');
        %plot frequency. in axes
        reset(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(freq{tfm_para_user_counter},y_fft{tfm_para_user_counter},'-b'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
    elseif get(h_para(1).radiobutton_pick,'Value')
        %make  buttons visible
        set(h_para(1).button_freq_add,'Visible','on');
        set(h_para(1).button_freq_remove,'Visible','on');
        set(h_para(1).button_freq_clearall,'Visible','on');
        %disable unwanted button
        set(h_para(1).button_freq_addfft,'Visible','off');
        %plot displ. in axes
        reset(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
    end
    
    %preview
    reset(h_para(1).axes_preview)
    axes(h_para(1).axes_preview)
    s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,tfm_para_user_counter},'/image',num2str(tfm_piv_user_relax{tfm_para_user_counter}),'.mat'],'imagei');
    image=s.imagei;
    imagesc(image); hold on;
    
    set(h_para(1).axes_preview,'xtick',[],'ytick',[])
    colormap('gray')
    freezeColors
    plot(tfm_init_user_outline2x{tfm_para_user_counter},tfm_init_user_outline2y{tfm_para_user_counter},'r','LineWidth',1);
    axis image;
    
    %calculate para and display them.
    
    %initial val. for contaction time
    t_init(:,1)=NaN;
    t_init(:,2)=NaN;
    t_init(:,3)=NaN;
    t_init(:,4)=NaN;
    
    %initial val. for dp time
    t_dp(:,1)=NaN;
    t_dp(:,2)=NaN;
    t_dp(:,3)=NaN;
    t_dp(:,4)=NaN;
    
    %initialize
    tfm_para_user_para_Deltad=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_DeltaFx=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_DeltaFy=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_DeltaF=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_vcontr=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_vrelax=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_Pcontr=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_Prelax=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_tcontr=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_tdp=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_freq=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_freqy=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_tcontr=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_tdp=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_ratiop=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_ratiodp=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_freq2=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_freq2=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_tagdp=cell(1,tfm_init_user_Nfiles);
    tfm_para_user_para_tag=cell(1,tfm_init_user_Nfiles);
    
    %para
    for current_vid=1:tfm_init_user_Nfiles
        tfm_para_user_para_Deltad{current_vid}=nanmean(dmax{current_vid}(:,2))-nanmean(dmin{current_vid}(:,2));
        tfm_para_user_para_DeltaFx{current_vid}=nanmean(Fxmax{current_vid}(:,2))-nanmean(Fxmin{current_vid}(:,2));
        tfm_para_user_para_DeltaFy{current_vid}=nanmean(Fymax{current_vid}(:,2))-nanmean(Fymin{current_vid}(:,2));
        tfm_para_user_para_DeltaF{current_vid}=nanmean(Fmax{current_vid}(:,2))-nanmean(Fmin{current_vid}(:,2));
        tfm_para_user_para_vcontr{current_vid}=nanmean(vmax{current_vid}(:,2));
        tfm_para_user_para_vrelax{current_vid}=nanmean(vmin{current_vid}(:,2));
        tfm_para_user_para_Pcontr{current_vid}=nanmean(Pmax{current_vid}(:,2));
        tfm_para_user_para_Prelax{current_vid}=nanmean(Pmin{current_vid}(:,2));
        tfm_para_user_para_tcontr{current_vid}=NaN;
        tfm_para_user_para_tdp{current_vid}=NaN;
        tfm_para_user_para_freq{current_vid}=NaN;
        tfm_para_user_para_freqy{current_vid}=NaN;
        tfm_para_user_tcontr{current_vid}=t_init;
        tfm_para_user_tdp{current_vid}=t_dp;
        tfm_para_user_para_ratiop{current_vid}=NaN;
        tfm_para_user_para_ratiodp{current_vid}=NaN;
        tfm_para_user_para_freq2{current_vid}=NaN;
        tfm_para_user_freq2{current_vid}=t_init;
        tfm_para_user_para_tagdp{current_vid}=0;
        tfm_para_user_para_tag{current_vid}=0;
    end
    
    
    %diplay
    set(h_para(1).text_disp,'String',['dcontr=',num2str(tfm_para_user_para_Deltad{tfm_para_user_counter},'%.2e'),' [m]']);
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(tfm_para_user_para_vcontr{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(tfm_para_user_para_vrelax{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_forces,'String',['F=',num2str(tfm_para_user_para_DeltaF{tfm_para_user_counter},'%.2e'),' [N]']);
    set(h_para(1).text_power1,'String',['Pcontr=',num2str(tfm_para_user_para_Pcontr{tfm_para_user_counter},'%.2e'),' [W]']);
    set(h_para(1).text_power2,'String',['Prelax=',num2str(tfm_para_user_para_Prelax{tfm_para_user_counter},'%.2e'),' [W]']);
    set(h_para(1).text_dp2_2,'String',['t=',num2str(NaN,'%.2e'),' [s]']);
    set(h_para(1).text_contr,'String',['tcontr=',num2str(NaN,'%.2e'),' [s]']);
    set(h_para(1).text_freq1,'String',['f=',num2str(NaN,'%.2e'),' [Hz]']);
    set(h_para(1).text_freq2,'String',['T=',num2str(NaN,'%.2e'),' [s]']);
    set(h_para(1).edit_ratio,'String',[num2str(NaN,'%.2e')]);
    set(h_para(1).edit_dp2,'String',[num2str(NaN,'%.2e')]);
    
    %set texts to 1st vid
    set(h_para(1).text_whichvidname,'String',tfm_init_user_filenamestack{1,1});
    set(h_para(1).text_whichvid,'String',[num2str(1),'/',num2str(tfm_init_user_Nfiles)]);
    
    %displaz and enable/disable buttons and panels
    set(h_para(1).panel_ratio,'Visible','on');
    set(h_para(1).panel_disp,'Visible','on');
    set(h_para(1).panel_vel,'Visible','on');
    set(h_para(1).panel_freq,'Visible','on');
    set(h_para(1).panel_forces,'Visible','on');
    set(h_para(1).panel_power,'Visible','on');
    set(h_para(1).panel_contr,'Visible','on');
    set(h_para(1).panel_dp,'Visible','on');
    set(h_para(1).panel_dp2,'Visible','off');
    set(h_para(1).panel_tag,'Visible','on');
    set(h_para(1).button_backwards,'Visible','on');
    set(h_para(1).button_forwards,'Visible','on');
    set(h_para(1).button_ok,'Visible','on');
    set(h_para(1).panel_preview,'Visible','on');
    set(h_para(1).text_whichvidname,'Visible','on');
    set(h_para(1).text_whichvid,'Visible','on');
    set(h_para(1).checkbox_save,'Visible','on');
    
    %forward /backbutton
    if tfm_para_user_counter==1
        set(h_para(1).button_backwards,'Enable','off');
    else
        set(h_para(1).button_backwards,'Enable','on');
    end
    if tfm_para_user_counter==tfm_init_user_Nfiles
        set(h_para(1).button_forwards,'Enable','off');
    else
        set(h_para(1).button_forwards,'Enable','on');
    end
    
    
    %save for shared use
    setappdata(0,'tfm_para_user_d',tfm_para_user_d);
    setappdata(0,'tfm_para_user_dmax',dmax);
    setappdata(0,'tfm_para_user_dmin',dmin);
    setappdata(0,'tfm_para_user_vmax',vmax);
    setappdata(0,'tfm_para_user_vmin',vmin);
    setappdata(0,'tfm_para_user_Fxmax',Fxmax);
    setappdata(0,'tfm_para_user_Fxmin',Fxmin);
    setappdata(0,'tfm_para_user_Fymax',Fymax);
    setappdata(0,'tfm_para_user_Fymin',Fymin);
    setappdata(0,'tfm_para_user_Fmax',Fmax);
    setappdata(0,'tfm_para_user_Fmin',Fmin);
    setappdata(0,'tfm_para_user_Pmax',Pmax);
    setappdata(0,'tfm_para_user_Pmin',Pmin);
    setappdata(0,'tfm_para_user_dt',dt);
    setappdata(0,'tfm_para_user_velocity',Velocity);
    setappdata(0,'tfm_para_user_power',Power);
    setappdata(0,'tfm_para_user_F_tot',F_tot);
    setappdata(0,'tfm_para_user_Fx_tot',Fx_tot);
    setappdata(0,'tfm_para_user_Fy_tot',Fy_tot);
    setappdata(0,'tfm_para_user_para_Deltad',tfm_para_user_para_Deltad);
    setappdata(0,'tfm_para_user_para_DeltaFx',tfm_para_user_para_DeltaFx);
    setappdata(0,'tfm_para_user_para_DeltaFy',tfm_para_user_para_DeltaFy);
    setappdata(0,'tfm_para_user_para_DeltaF',tfm_para_user_para_DeltaF);
    setappdata(0,'tfm_para_user_para_vcontr',tfm_para_user_para_vcontr);
    setappdata(0,'tfm_para_user_para_vrelax',tfm_para_user_para_vrelax);
    setappdata(0,'tfm_para_user_para_Pcontr',tfm_para_user_para_Pcontr);
    setappdata(0,'tfm_para_user_para_Prelax',tfm_para_user_para_Prelax);
    setappdata(0,'tfm_para_user_tcontr',tfm_para_user_tcontr);
    setappdata(0,'tfm_para_user_para_tcontr',tfm_para_user_para_tcontr);
    setappdata(0,'tfm_para_user_tdp',tfm_para_user_tdp);
    setappdata(0,'tfm_para_user_para_tdp',tfm_para_user_para_tdp);
    setappdata(0,'tfm_para_user_freq2',tfm_para_user_freq2);
    setappdata(0,'tfm_para_user_para_freq2',tfm_para_user_para_freq2);
    setappdata(0,'tfm_para_user_para_freq',tfm_para_user_para_freq);
    setappdata(0,'tfm_para_user_para_freqy',tfm_para_user_para_freqy);
    setappdata(0,'tfm_para_user_freq',freq);
    setappdata(0,'tfm_para_user_y_fft',y_fft);
    setappdata(0,'tfm_para_user_para_ratiop',tfm_para_user_para_ratiop);
    setappdata(0,'tfm_para_user_para_ratiodp',tfm_para_user_para_ratiodp);
    setappdata(0,'tfm_para_user_para_tagdp',tfm_para_user_para_tagdp);
    setappdata(0,'tfm_para_user_para_tag',tfm_para_user_para_tag);
    
    %statusbar
    sb=statusbar(h_para(1).fig,'Calculation - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function para_push_disp_addmax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_dmax=getappdata(0,'tfm_para_user_dmax');
    tfm_para_user_dmin=getappdata(0,'tfm_para_user_dmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_Deltad=getappdata(0,'tfm_para_user_para_Deltad');
    
    d_init=tfm_para_user_dmax{tfm_para_user_counter};
    hf=figure;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter},'-b'), hold on;
    i1=plot(tfm_para_user_dmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    i2=plot(tfm_para_user_dmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmax{tfm_para_user_counter}(:,2),'.g'); hold on;
    title('Add new maximum pt.')
    [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    d_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
    d_add(:,2)=y;
    d_new(:,1)=[d_init(:,1);d_add(:,1)];
    d_new(:,2)=[d_init(:,2);d_add(:,2)];
    %plot new in axes
    cla(h_para(1).axes_disp)
    axes(h_para(1).axes_disp)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_dmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmin{tfm_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(d_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},d_new(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %
    tfm_para_user_dmax{tfm_para_user_counter}=d_new;
    
    %update para
    tfm_para_user_para_Deltad{tfm_para_user_counter}=nanmean(tfm_para_user_dmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_dmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_disp,'String',['dcontr=',num2str(tfm_para_user_para_Deltad{tfm_para_user_counter},'%.2e'),' [m]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_dmax',tfm_para_user_dmax);
    setappdata(0,'tfm_para_user_para_Deltad',tfm_para_user_para_Deltad);
    
catch
end

function para_push_disp_addmin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_dmax=getappdata(0,'tfm_para_user_dmax');
    tfm_para_user_dmin=getappdata(0,'tfm_para_user_dmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_Deltad=getappdata(0,'tfm_para_user_para_Deltad');
    
    d_init=tfm_para_user_dmin{tfm_para_user_counter};
    hf=figure;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter},'-b'), hold on;
    i1=plot(tfm_para_user_dmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    i2=plot(tfm_para_user_dmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmax{tfm_para_user_counter}(:,2),'.g'); hold on;
    title('Add new mainimum pt.')
    [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    d_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
    d_add(:,2)=y;
    d_new(:,1)=[d_init(:,1);d_add(:,1)];
    d_new(:,2)=[d_init(:,2);d_add(:,2)];
    %plot new in axes
    cla(h_para(1).axes_disp)
    axes(h_para(1).axes_disp)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_dmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmax{tfm_para_user_counter}(:,2)*1e6,'.g'), hold on;
    plot(d_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},d_new(:,2)*1e6,'.r'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_dmin{tfm_para_user_counter}=d_new;
    
    %update para
    tfm_para_user_para_Deltad{tfm_para_user_counter}=nanmean(tfm_para_user_dmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_dmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_disp,'String',['dcontr=',num2str(tfm_para_user_para_Deltad{tfm_para_user_counter},'%.2e'),' [m]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_dmin',tfm_para_user_dmin);
    setappdata(0,'tfm_para_user_para_Deltad',tfm_para_user_para_Deltad);
    
catch
end

function para_push_disp_removemax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_dmax=getappdata(0,'tfm_para_user_dmax');
    tfm_para_user_dmin=getappdata(0,'tfm_para_user_dmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_Deltad=getappdata(0,'tfm_para_user_para_Deltad');
    
    d_init=tfm_para_user_dmax{tfm_para_user_counter};
    hf=figure;
    i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter},'-b'); hold on;
    i2=plot(tfm_para_user_dmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    plot(tfm_para_user_dmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmax{tfm_para_user_counter}(:,2),'.g'), hold on;
    title('Delete maximum pt.')
    [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    d_new(:,1)=d_init(:,1);
    d_new(:,2)=d_init(:,2);
    d_new(p,:)=[];
    
    
    %plot new in axes
    cla(h_para(1).axes_disp)
    axes(h_para(1).axes_disp)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_dmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmin{tfm_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(d_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},d_new(:,2)*1e6,'.g'), hold on;
    
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_dmax{tfm_para_user_counter}=d_new;
    
    %update para
    tfm_para_user_para_Deltad{tfm_para_user_counter}=nanmean(tfm_para_user_dmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_dmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_disp,'String',['dcontr=',num2str(tfm_para_user_para_Deltad{tfm_para_user_counter},'%.2e'),' [m]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_dmax',tfm_para_user_dmax);
    setappdata(0,'tfm_para_user_para_Deltad',tfm_para_user_para_Deltad);
    
catch
end

function para_push_disp_removemin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_dmax=getappdata(0,'tfm_para_user_dmax');
    tfm_para_user_dmin=getappdata(0,'tfm_para_user_dmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_Deltad=getappdata(0,'tfm_para_user_para_Deltad');
    
    d_init=tfm_para_user_dmin{tfm_para_user_counter};
    hf=figure;
    i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter},'-b'); hold on;
    plot(tfm_para_user_dmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    i2=plot(tfm_para_user_dmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmax{tfm_para_user_counter}(:,2),'.g'); hold on;
    title('Delete minimum pt.')
    
    [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    d_new(:,1)=d_init(:,1);
    d_new(:,2)=d_init(:,2);
    d_new(p,:)=[];
    
    
    %plot new in axes
    cla(h_para(1).axes_disp)
    axes(h_para(1).axes_disp)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_dmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_dmax{tfm_para_user_counter}(:,2)*1e6,'.g'), hold on;
    plot(d_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},d_new(:,2)*1e6,'.r'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_dmin{tfm_para_user_counter}=d_new;
    
    %update para
    tfm_para_user_para_Deltad{tfm_para_user_counter}=nanmean(tfm_para_user_dmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_dmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_disp,'String',['dcontr=',num2str(tfm_para_user_para_Deltad{tfm_para_user_counter},'%.2e'),' [m]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_dmin',tfm_para_user_dmin);
    setappdata(0,'tfm_para_user_para_Deltad',tfm_para_user_para_Deltad);
    
catch
end

function para_push_disp_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_dmax=getappdata(0,'tfm_para_user_dmax');
    tfm_para_user_dmin=getappdata(0,'tfm_para_user_dmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_para_Deltad=getappdata(0,'tfm_para_user_para_Deltad');
    
    %plot new in axes
    cla(h_para(1).axes_disp)
    axes(h_para(1).axes_disp)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %delte dmin and dmax
    tfm_para_user_dmin{tfm_para_user_counter}(:,1)=NaN;
    tfm_para_user_dmin{tfm_para_user_counter}(:,2)=NaN;
    tfm_para_user_dmax{tfm_para_user_counter}(:,1)=NaN;
    tfm_para_user_dmax{tfm_para_user_counter}(:,2)=NaN;
    
    %update para
    tfm_para_user_para_Deltad{tfm_para_user_counter}=nanmean(tfm_para_user_dmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_dmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_disp,'String',['dcontr=',num2str(tfm_para_user_para_Deltad{tfm_para_user_counter},'%.2e'),' [m]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_dmin',tfm_para_user_dmin);
    setappdata(0,'tfm_para_user_dmax',tfm_para_user_dmax);
    setappdata(0,'tfm_para_user_para_Deltad',tfm_para_user_para_Deltad);
    
catch
end

function para_push_vel_addmax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_vmax=getappdata(0,'tfm_para_user_vmax');
    tfm_para_user_vmin=getappdata(0,'tfm_para_user_vmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_velocity=getappdata(0,'tfm_para_user_velocity');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_vcontr=getappdata(0,'tfm_para_user_para_vcontr');
    tfm_para_user_para_vrelax=getappdata(0,'tfm_para_user_para_vrelax');
    
    v_init=tfm_para_user_vmax{tfm_para_user_counter};
    hf=figure;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter},'-b'), hold on;
    i1=plot(tfm_para_user_vmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    i2=plot(tfm_para_user_vmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmax{tfm_para_user_counter}(:,2),'.g'); hold on;
    title('Add new maximum pt.')
    [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    v_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
    v_add(:,2)=y;
    v_new(:,1)=[v_init(:,1);v_add(:,1)];
    v_new(:,2)=[v_init(:,2);v_add(:,2)];
    %plot new in axes
    cla(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(tfm_para_user_dt{tfm_para_user_counter},zeros(1,length(tfm_para_user_dt{tfm_para_user_counter})),'--k'), hold on;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_vmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmin{tfm_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(v_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},v_new(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_vmax{tfm_para_user_counter}=v_new;
    
    %upate para
    tfm_para_user_para_vcontr{tfm_para_user_counter}=nanmean(tfm_para_user_vmax{tfm_para_user_counter}(:,2));
    tfm_para_user_para_vrelax{tfm_para_user_counter}=nanmean(tfm_para_user_vmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(tfm_para_user_para_vcontr{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(tfm_para_user_para_vrelax{tfm_para_user_counter},'%.2e'),' [m/s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_vmax',tfm_para_user_vmax);
    setappdata(0,'tfm_para_user_para_vcontr',tfm_para_user_para_vcontr);
    setappdata(0,'tfm_para_user_para_vrelax',tfm_para_user_para_vrelax);
    
catch
end

function para_push_vel_addmin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_vmax=getappdata(0,'tfm_para_user_vmax');
    tfm_para_user_vmin=getappdata(0,'tfm_para_user_vmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_velocity=getappdata(0,'tfm_para_user_velocity');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_vcontr=getappdata(0,'tfm_para_user_para_vcontr');
    tfm_para_user_para_vrelax=getappdata(0,'tfm_para_user_para_vrelax');
    
    v_init=tfm_para_user_vmin{tfm_para_user_counter};
    hf=figure;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter},'-b'), hold on;
    i1=plot(tfm_para_user_vmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    i2=plot(tfm_para_user_vmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmax{tfm_para_user_counter}(:,2),'.g'); hold on;
    title('Add new minimum pt.')
    [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    v_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
    v_add(:,2)=y;
    v_new(:,1)=[v_init(:,1);v_add(:,1)];
    v_new(:,2)=[v_init(:,2);v_add(:,2)];
    %plot new in axes
    cla(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(tfm_para_user_dt{tfm_para_user_counter},zeros(1,length(tfm_para_user_dt{tfm_para_user_counter})),'--k'), hold on;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_vmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmax{tfm_para_user_counter}(:,2)*1e6,'.g'), hold on;
    plot(v_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},v_new(:,2)*1e6,'.r'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_vmin{tfm_para_user_counter}=v_new;
    
    %upate para
    tfm_para_user_para_vcontr{tfm_para_user_counter}=nanmean(tfm_para_user_vmax{tfm_para_user_counter}(:,2));
    tfm_para_user_para_vrelax{tfm_para_user_counter}=nanmean(tfm_para_user_vmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(tfm_para_user_para_vcontr{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(tfm_para_user_para_vrelax{tfm_para_user_counter},'%.2e'),' [m/s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_vmin',tfm_para_user_vmin);
    setappdata(0,'tfm_para_user_para_vcontr',tfm_para_user_para_vcontr);
    setappdata(0,'tfm_para_user_para_vrelax',tfm_para_user_para_vrelax);
    
catch
end

function para_push_vel_removemax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_vmax=getappdata(0,'tfm_para_user_vmax');
    tfm_para_user_vmin=getappdata(0,'tfm_para_user_vmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_velocity=getappdata(0,'tfm_para_user_velocity');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_vcontr=getappdata(0,'tfm_para_user_para_vcontr');
    tfm_para_user_para_vrelax=getappdata(0,'tfm_para_user_para_vrelax');
    
    v_init=tfm_para_user_vmax{tfm_para_user_counter};
    hf=figure;
    i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter},'-b'); hold on;
    i2=plot(tfm_para_user_vmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    plot(tfm_para_user_vmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmax{tfm_para_user_counter}(:,2),'.g'), hold on;
    title('Delete maximum pt.')
    [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    v_new(:,1)=v_init(:,1);
    v_new(:,2)=v_init(:,2);
    v_new(p,:)=[];
    
    
    %plot new in axes
    cla(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(tfm_para_user_dt{tfm_para_user_counter},zeros(1,length(tfm_para_user_dt{tfm_para_user_counter})),'--k'), hold on;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_vmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmin{tfm_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(v_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},v_new(:,2)*1e6,'.g'), hold on;
    
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_vmax{tfm_para_user_counter}=v_new;
    
    %upate para
    tfm_para_user_para_vcontr{tfm_para_user_counter}=nanmean(tfm_para_user_vmax{tfm_para_user_counter}(:,2));
    tfm_para_user_para_vrelax{tfm_para_user_counter}=nanmean(tfm_para_user_vmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(tfm_para_user_para_vcontr{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(tfm_para_user_para_vrelax{tfm_para_user_counter},'%.2e'),' [m/s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_vmax',tfm_para_user_vmax);
    setappdata(0,'tfm_para_user_para_vcontr',tfm_para_user_para_vcontr);
    setappdata(0,'tfm_para_user_para_vrelax',tfm_para_user_para_vrelax);
    
catch
end

function para_push_vel_removemin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_vmax=getappdata(0,'tfm_para_user_vmax');
    tfm_para_user_vmin=getappdata(0,'tfm_para_user_vmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_velocity=getappdata(0,'tfm_para_user_velocity');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_vcontr=getappdata(0,'tfm_para_user_para_vcontr');
    tfm_para_user_para_vrelax=getappdata(0,'tfm_para_user_para_vrelax');
    
    v_init=tfm_para_user_vmin{tfm_para_user_counter};
    hf=figure;
    i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter},'-b'); hold on;
    plot(tfm_para_user_vmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    i2=plot(tfm_para_user_vmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmax{tfm_para_user_counter}(:,2),'.g'); hold on;
    title('Delete minimum pt.')
    
    [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    v_new(:,1)=v_init(:,1);
    v_new(:,2)=v_init(:,2);
    v_new(p,:)=[];
    
    
    %plot new in axes
    cla(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(tfm_para_user_dt{tfm_para_user_counter},zeros(1,length(tfm_para_user_dt{tfm_para_user_counter})),'--k'), hold on;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_vmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_vmax{tfm_para_user_counter}(:,2)*1e6,'.g'), hold on;
    plot(v_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},v_new(:,2)*1e6,'.r'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_vmin{tfm_para_user_counter}=v_new;
    
    %upate para
    tfm_para_user_para_vcontr{tfm_para_user_counter}=nanmean(tfm_para_user_vmax{tfm_para_user_counter}(:,2));
    tfm_para_user_para_vrelax{tfm_para_user_counter}=nanmean(tfm_para_user_vmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(tfm_para_user_para_vcontr{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(tfm_para_user_para_vrelax{tfm_para_user_counter},'%.2e'),' [m/s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_vmin',tfm_para_user_vmin);
    setappdata(0,'tfm_para_user_para_vcontr',tfm_para_user_para_vcontr);
    setappdata(0,'tfm_para_user_para_vrelax',tfm_para_user_para_vrelax);
    
catch
end

function para_push_vel_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_vmax=getappdata(0,'tfm_para_user_vmax');
    tfm_para_user_vmin=getappdata(0,'tfm_para_user_vmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_velocity=getappdata(0,'tfm_para_user_velocity');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_para_vcontr=getappdata(0,'tfm_para_user_para_vcontr');
    tfm_para_user_para_vrelax=getappdata(0,'tfm_para_user_para_vrelax');
    
    %plot new in axes
    cla(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(tfm_para_user_dt{tfm_para_user_counter},zeros(1,length(tfm_para_user_dt{tfm_para_user_counter})),'--k'), hold on;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %delte dmin and dmax
    tfm_para_user_vmin{tfm_para_user_counter}(:,1)=NaN;
    tfm_para_user_vmin{tfm_para_user_counter}(:,2)=NaN;
    tfm_para_user_vmax{tfm_para_user_counter}(:,1)=NaN;
    tfm_para_user_vmax{tfm_para_user_counter}(:,2)=NaN;
    
    %upate para
    tfm_para_user_para_vcontr{tfm_para_user_counter}=nanmean(tfm_para_user_vmax{tfm_para_user_counter}(:,2));
    tfm_para_user_para_vrelax{tfm_para_user_counter}=nanmean(tfm_para_user_vmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(tfm_para_user_para_vcontr{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(tfm_para_user_para_vrelax{tfm_para_user_counter},'%.2e'),' [m/s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_vmin',tfm_para_user_vmin);
    setappdata(0,'tfm_para_user_vmax',tfm_para_user_vmax);
    setappdata(0,'tfm_para_user_para_vcontr',tfm_para_user_para_vcontr);
    setappdata(0,'tfm_para_user_para_vrelax',tfm_para_user_para_vrelax);
    
catch
end

function para_push_freq_add(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %add  pair
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_freq2=getappdata(0,'tfm_para_user_freq2');
    tfm_para_user_para_freq2=getappdata(0,'tfm_para_user_para_freq2');
    
    t_init=tfm_para_user_freq2{tfm_para_user_counter};
    
    hf=figure;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter},'-b'), hold on;
    i1=plot(t_init(:,1),t_init(:,3),'.r');
    i2=plot(t_init(:,2),t_init(:,4),'.r');
    title('Add new left side')
    [~,x1,y1] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    cla;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter},'-b'), hold on;
    i1=plot(t_init(:,1),t_init(:,3),'.r');
    i2=plot(t_init(:,2),t_init(:,4),'.r');
    i3=plot(x1,y1,'.g'); hold on;
    title('Add new right side')
    [~,x2,y2] = selectdata('SelectionMode','closest','Ignore',[i1,i2,i3]);
    close(hf);
    
    t_add(:,1)=x1;
    t_add(:,2)=x2;
    t_add(:,3)=y1;
    t_add(:,4)=y2;
    t_new(:,1)=[t_init(:,1);t_add(:,1)];
    t_new(:,2)=[t_init(:,2);t_add(:,2)];
    t_new(:,3)=[t_init(:,3);t_add(:,3)];
    t_new(:,4)=[t_init(:,4);t_add(:,4)];
    
    %displ. in double peak
    cla(h_para(1).axes_freq)
    axes(h_para(1).axes_freq)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    %plot delta t
    dtcontr=zeros(1,size(t_new,1));
    cmap = hsv(size(t_new,1));
    for i=1:size(t_new,1)
        plot(t_new(i,1),t_new(i,3)*1e6,'.','Color',cmap(i,:))
        plot(t_new(i,2),t_new(i,4)*1e6,'.','Color',cmap(i,:))
        dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
        plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'Color',cmap(i,:),'LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %save new pt vector
    tfm_para_user_freq2{tfm_para_user_counter}=t_new;
    x=nanmean(dtcontr);
    
    %display
    set(h_para(1).text_freq1,'String',['f=',num2str(1/(x+eps),'%.2e'),' [Hz]']);
    set(h_para(1).text_freq2,'String',['T=',num2str(x,'%.2e'),' [s]']);
    
    tfm_para_user_para_freq2{tfm_para_user_counter}=1/(x+eps);
    
    %save for shared use
    setappdata(0,'tfm_para_user_freq2',tfm_para_user_freq2);
    setappdata(0,'tfm_para_user_para_freq2',tfm_para_user_para_freq2);
    
catch
end

function para_push_freq_addfft(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_freq=getappdata(0,'tfm_para_user_freq');
    tfm_para_user_para_freq=getappdata(0,'tfm_para_user_para_freq');
    tfm_para_user_para_freqy=getappdata(0,'tfm_para_user_para_freqy');
    tfm_para_user_y_fft=getappdata(0,'tfm_para_user_y_fft');
    
    %
    freq=tfm_para_user_freq;
    y_fft=tfm_para_user_y_fft;
    
    hf=figure;
    plot(freq{tfm_para_user_counter},y_fft{tfm_para_user_counter},'-b'), hold on;
    title('Pick peak')
    [~,x,y] = selectdata('SelectionMode','closest');
    close(hf);
    
    %plot
    cla(h_para(1).axes_freq)
    axes(h_para(1).axes_freq)
    plot(freq{tfm_para_user_counter},y_fft{tfm_para_user_counter},'-b'), hold on;
    plot(x,y,'.g')
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %display
    set(h_para(1).text_freq1,'String',['f=',num2str(x,'%.2e'),' [Hz]']);
    set(h_para(1).text_freq2,'String',['T=',num2str(1/x,'%.2e'),' [s]']);
    
    tfm_para_user_para_freq{tfm_para_user_counter}=x;
    tfm_para_user_para_freqy{tfm_para_user_counter}=y;
    
    %save for shared use
    setappdata(0,'tfm_para_user_para_freq',tfm_para_user_para_freq);
    setappdata(0,'tfm_para_user_para_freqy',tfm_para_user_para_freqy);
    %setappdata(0,'tfm_para_user_para_vcontr',tfm_para_user_para_vcontr);
    %setappdata(0,'tfm_para_user_para_vrelax',tfm_para_user_para_vrelax);
    
catch
end

function para_push_freq_remove(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_freq2=getappdata(0,'tfm_para_user_freq2');
    tfm_para_user_para_freq2=getappdata(0,'tfm_para_user_para_freq2');
    
    t_init=tfm_para_user_freq2{tfm_para_user_counter};
    
    hf=figure;
    i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter},'-b'); hold on;
    plot(t_init(:,1),t_init(:,3),'.r');
    i2=plot(t_init(:,2),t_init(:,4),'.r');
    title('Delte left pt.')
    [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    t_new(:,1)=t_init(:,1);
    t_new(:,2)=t_init(:,2);
    t_new(:,3)=t_init(:,3);
    t_new(:,4)=t_init(:,4);
    t_new(p,:)=[];
    
    %displ. in double peak
    cla(h_para(1).axes_freq)
    axes(h_para(1).axes_freq)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    %plot delta t
    dtcontr=zeros(1,size(t_new,1));
    cmap = hsv(size(t_new,1));
    for i=1:size(t_new,1)
        plot(t_new(i,1),t_new(i,3)*1e6,'.','Color',cmap(i,:))
        plot(t_new(i,2),t_new(i,4)*1e6,'.','Color',cmap(i,:))
        dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
        plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'Color',cmap(i,:),'LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %save new pt vector
    tfm_para_user_freq2{tfm_para_user_counter}=t_new;
    x=nanmean(dtcontr);
    
    %display
    set(h_para(1).text_freq1,'String',['f=',num2str(1/(x+eps),'%.2e'),' [Hz]']);
    set(h_para(1).text_freq2,'String',['T=',num2str(x,'%.2e'),' [s]']);
    
    tfm_para_user_para_freq2{tfm_para_user_counter}=1/(x+eps);
    
    %save for shared use
    setappdata(0,'tfm_para_user_freq2',tfm_para_user_freq2);
    setappdata(0,'tfm_para_user_para_freq2',tfm_para_user_para_freq2);
    
catch
end

function para_push_freq_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %remove all
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_freq2=getappdata(0,'tfm_para_user_freq2');
    tfm_para_user_para_freq2=getappdata(0,'tfm_para_user_para_freq2');
    
    t_new(:,1)=NaN;
    t_new(:,2)=NaN;
    t_new(:,3)=NaN;
    t_new(:,4)=NaN;
    
    cla(h_para(1).axes_freq)
    axes(h_para(1).axes_freq)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    %plot delta t
    dtcontr=zeros(1,size(t_new,1));
    cmap = hsv(size(t_new,1));
    for i=1:size(t_new,1)
        plot(t_new(i,1),t_new(i,3)*1e6,'.','Color',cmap(i,:))
        plot(t_new(i,2),t_new(i,4)*1e6,'.','Color',cmap(i,:))
        dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
        plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'Color',cmap(i,:),'LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %save new pt vector
    tfm_para_user_freq2{tfm_para_user_counter}=t_new;
    tfm_para_user_para_freq2{tfm_para_user_counter}=nanmean(dtcontr);
    x=tfm_para_user_para_freq2{tfm_para_user_counter};
    
    %display
    set(h_para(1).text_freq1,'String',['f=',num2str(1/(x+eps),'%.2e'),' [Hz]']);
    set(h_para(1).text_freq2,'String',['T=',num2str(x,'%.2e'),' [s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_freq2',tfm_para_user_freq2);
    setappdata(0,'tfm_para_user_para_freq2',tfm_para_user_para_freq2);
    
catch
end

function para_push_forces_addmax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    if get(h_para(1).radiobutton_forcetot,'Value') %ftot
        %load shared needed para
        tfm_para_user_Fmax=getappdata(0,'tfm_para_user_Fmax');
        tfm_para_user_Fmin=getappdata(0,'tfm_para_user_Fmin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_F_tot=getappdata(0,'tfm_para_user_F_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaF=getappdata(0,'tfm_para_user_para_DeltaF');
        
        F_init=tfm_para_user_Fmax{tfm_para_user_counter};
        hf=figure;
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter},'-b'), hold on;
        i1=plot(tfm_para_user_Fmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmin{tfm_para_user_counter}(:,2),'.r'); hold on;
        i2=plot(tfm_para_user_Fmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Add new maximum pt.')
        [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        F_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
        F_add(:,2)=y;
        F_new(:,1)=[F_init(:,1);F_add(:,1)];
        F_new(:,2)=[F_init(:,2);F_add(:,2)];
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        plot(F_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},F_new(:,2)*1e9,'.g'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fmax{tfm_para_user_counter}=F_new;
        
        %update para
        tfm_para_user_para_DeltaF{tfm_para_user_counter}=nanmean(tfm_para_user_Fmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fmin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['F=',num2str(tfm_para_user_para_DeltaF{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fmax',tfm_para_user_Fmax);
        setappdata(0,'tfm_para_user_para_DeltaF',tfm_para_user_para_DeltaF);
    elseif get(h_para(1).radiobutton_forcex,'Value') %fx
        %load shared needed para
        tfm_para_user_Fxmax=getappdata(0,'tfm_para_user_Fxmax');
        tfm_para_user_Fxmin=getappdata(0,'tfm_para_user_Fxmin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_Fx_tot=getappdata(0,'tfm_para_user_Fx_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaFx=getappdata(0,'tfm_para_user_para_DeltaFx');
        
        F_init=tfm_para_user_Fxmax{tfm_para_user_counter};
        hf=figure;
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter},'-b'), hold on;
        i1=plot(tfm_para_user_Fxmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmin{tfm_para_user_counter}(:,2),'.r'); hold on;
        i2=plot(tfm_para_user_Fxmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Add new maximum pt.')
        [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        F_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
        F_add(:,2)=y;
        F_new(:,1)=[F_init(:,1);F_add(:,1)];
        F_new(:,2)=[F_init(:,2);F_add(:,2)];
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fxmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        plot(F_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},F_new(:,2)*1e9,'.g'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fxmax{tfm_para_user_counter}=F_new;
        
        %update para
        tfm_para_user_para_DeltaFx{tfm_para_user_counter}=nanmean(tfm_para_user_Fxmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fxmin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fx=',num2str(tfm_para_user_para_DeltaFx{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fxmax',tfm_para_user_Fxmax);
        setappdata(0,'tfm_para_user_para_DeltaFx',tfm_para_user_para_DeltaFx);
        
    elseif get(h_para(1).radiobutton_forcey,'Value') %fy
        %load shared needed para
        tfm_para_user_Fymax=getappdata(0,'tfm_para_user_Fymax');
        tfm_para_user_Fymin=getappdata(0,'tfm_para_user_Fymin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_Fy_tot=getappdata(0,'tfm_para_user_Fy_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaFy=getappdata(0,'tfm_para_user_para_DeltaFy');
        
        F_init=tfm_para_user_Fymax{tfm_para_user_counter};
        hf=figure;
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter},'-b'), hold on;
        i1=plot(tfm_para_user_Fymin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymin{tfm_para_user_counter}(:,2),'.r'); hold on;
        i2=plot(tfm_para_user_Fymax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Add new maximum pt.')
        [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        F_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
        F_add(:,2)=y;
        F_new(:,1)=[F_init(:,1);F_add(:,1)];
        F_new(:,2)=[F_init(:,2);F_add(:,2)];
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fymin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        plot(F_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},F_new(:,2)*1e9,'.g'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fymax{tfm_para_user_counter}=F_new;
        
        %update para
        tfm_para_user_para_DeltaFy{tfm_para_user_counter}=nanmean(tfm_para_user_Fymax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fymin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fy=',num2str(tfm_para_user_para_DeltaFy{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fymax',tfm_para_user_Fymax);
        setappdata(0,'tfm_para_user_para_DeltaFy',tfm_para_user_para_DeltaFy);
    end
catch
end

function para_push_forces_addmin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));

try
    if get(h_para(1).radiobutton_forcex,'Value') %Fx
        %load shared needed para
        tfm_para_user_Fxmax=getappdata(0,'tfm_para_user_Fxmax');
        tfm_para_user_Fxmin=getappdata(0,'tfm_para_user_Fxmin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_Fx_tot=getappdata(0,'tfm_para_user_Fx_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaFx=getappdata(0,'tfm_para_user_para_DeltaFx');
        
        Fx_init=tfm_para_user_Fxmin{tfm_para_user_counter};
        hf=figure;
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter},'-b'), hold on;
        i1=plot(tfm_para_user_Fxmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmin{tfm_para_user_counter}(:,2),'.r'); hold on;
        i2=plot(tfm_para_user_Fxmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Add new minimum pt.')
        [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        Fx_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
        Fx_add(:,2)=y;
        Fx_new(:,1)=[Fx_init(:,1);Fx_add(:,1)];
        Fx_new(:,2)=[Fx_init(:,2);Fx_add(:,2)];
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fxmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(Fx_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fx_new(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fxmin{tfm_para_user_counter}=Fx_new;
        
        %update para
        tfm_para_user_para_DeltaFx{tfm_para_user_counter}=nanmean(tfm_para_user_Fxmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fxmin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fx=',num2str(tfm_para_user_para_DeltaFx{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fxmin',tfm_para_user_Fxmin);
        setappdata(0,'tfm_para_user_para_DeltaFx',tfm_para_user_para_DeltaFx);
        
    elseif get(h_para(1).radiobutton_forcey,'Value') %Fy
        %load shared needed para
        tfm_para_user_Fymax=getappdata(0,'tfm_para_user_Fymax');
        tfm_para_user_Fymin=getappdata(0,'tfm_para_user_Fymin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_Fy_tot=getappdata(0,'tfm_para_user_Fy_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaFy=getappdata(0,'tfm_para_user_para_DeltaFy');
        
        Fy_init=tfm_para_user_Fymin{tfm_para_user_counter};
        hf=figure;
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter},'-b'), hold on;
        i1=plot(tfm_para_user_Fymin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymin{tfm_para_user_counter}(:,2),'.r'); hold on;
        i2=plot(tfm_para_user_Fymax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Add new minimum pt.')
        [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        Fy_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
        Fy_add(:,2)=y;
        Fy_new(:,1)=[Fy_init(:,1);Fy_add(:,1)];
        Fy_new(:,2)=[Fy_init(:,2);Fy_add(:,2)];
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fymax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(Fy_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fy_new(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fymin{tfm_para_user_counter}=Fy_new;
        
        %update para
        tfm_para_user_para_DeltaFy{tfm_para_user_counter}=nanmean(tfm_para_user_Fymax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fymin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fy=',num2str(tfm_para_user_para_DeltaFy{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fymin',tfm_para_user_Fymin);
        setappdata(0,'tfm_para_user_para_DeltaFy',tfm_para_user_para_DeltaFy);
        
    elseif get(h_para(1).radiobutton_forcetot,'Value') %F
        %load shared needed para
        tfm_para_user_Fmax=getappdata(0,'tfm_para_user_Fmax');
        tfm_para_user_Fmin=getappdata(0,'tfm_para_user_Fmin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_F_tot=getappdata(0,'tfm_para_user_F_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaF=getappdata(0,'tfm_para_user_para_DeltaF');
        
        F_init=tfm_para_user_Fmin{tfm_para_user_counter};
        hf=figure;
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter},'-b'), hold on;
        i1=plot(tfm_para_user_Fmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmin{tfm_para_user_counter}(:,2),'.r'); hold on;
        i2=plot(tfm_para_user_Fmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Add new minimum pt.')
        [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        F_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
        F_add(:,2)=y;
        F_new(:,1)=[F_init(:,1);F_add(:,1)];
        F_new(:,2)=[F_init(:,2);F_add(:,2)];
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(F_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},F_new(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fmin{tfm_para_user_counter}=F_new;
        
        %update para
        tfm_para_user_para_DeltaF{tfm_para_user_counter}=nanmean(tfm_para_user_Fmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fmin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['F=',num2str(tfm_para_user_para_DeltaF{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fmin',tfm_para_user_Fmin);
        setappdata(0,'tfm_para_user_para_DeltaF',tfm_para_user_para_DeltaF);
        
    end
catch
end

function para_push_forces_removemax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));

try
    
    %remove Fimax pts
    if get(h_para(1).radiobutton_forcex,'Value') %Fx
        %load shared needed para
        tfm_para_user_Fxmax=getappdata(0,'tfm_para_user_Fxmax');
        tfm_para_user_Fxmin=getappdata(0,'tfm_para_user_Fxmin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_Fx_tot=getappdata(0,'tfm_para_user_Fx_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaFx=getappdata(0,'tfm_para_user_para_DeltaFx');
        
        Fx_init=tfm_para_user_Fxmax{tfm_para_user_counter};
        hf=figure;
        i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter},'-b'); hold on;
        i2=plot(tfm_para_user_Fxmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmin{tfm_para_user_counter}(:,2),'.r'); hold on;
        plot(tfm_para_user_Fxmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Delete maximum pt.')
        [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        Fx_new(:,1)=Fx_init(:,1);
        Fx_new(:,2)=Fx_init(:,2);
        Fx_new(p,:)=[];
        
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fxmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        plot(Fx_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fx_new(:,2)*1e9,'.g'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fxmax{tfm_para_user_counter}=Fx_new;
        
        %update para
        tfm_para_user_para_DeltaFx{tfm_para_user_counter}=nanmean(tfm_para_user_Fxmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fxmin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fx=',num2str(tfm_para_user_para_DeltaFx{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fxmax',tfm_para_user_Fxmax);
        setappdata(0,'tfm_para_user_para_DeltaFx',tfm_para_user_para_DeltaFx);
        
    elseif get(h_para(1).radiobutton_forcey,'Value') %Fy
        %load shared needed para
        tfm_para_user_Fymax=getappdata(0,'tfm_para_user_Fymax');
        tfm_para_user_Fymin=getappdata(0,'tfm_para_user_Fymin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_Fy_tot=getappdata(0,'tfm_para_user_Fy_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaFy=getappdata(0,'tfm_para_user_para_DeltaFy');
        
        Fy_init=tfm_para_user_Fymax{tfm_para_user_counter};
        hf=figure;
        i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter},'-b'); hold on;
        i2=plot(tfm_para_user_Fymin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymin{tfm_para_user_counter}(:,2),'.r'); hold on;
        plot(tfm_para_user_Fymax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Delete maximum pt.')
        [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        Fy_new(:,1)=Fy_init(:,1);
        Fy_new(:,2)=Fy_init(:,2);
        Fy_new(p,:)=[];
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fymin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        plot(Fy_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fy_new(:,2)*1e9,'.g'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fymax{tfm_para_user_counter}=Fy_new;
        
        %update para
        tfm_para_user_para_DeltaFy{tfm_para_user_counter}=nanmean(tfm_para_user_Fymax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fymin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fy=',num2str(tfm_para_user_para_DeltaFy{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fymax',tfm_para_user_Fymax);
        setappdata(0,'tfm_para_user_para_DeltaFy',tfm_para_user_para_DeltaFy);
        
    elseif get(h_para(1).radiobutton_forcetot,'Value') %F
        %load shared needed para
        tfm_para_user_Fmax=getappdata(0,'tfm_para_user_Fmax');
        tfm_para_user_Fmin=getappdata(0,'tfm_para_user_Fmin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_F_tot=getappdata(0,'tfm_para_user_F_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaF=getappdata(0,'tfm_para_user_para_DeltaF');
        
        F_init=tfm_para_user_Fmax{tfm_para_user_counter};
        hf=figure;
        i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter},'-b'); hold on;
        i2=plot(tfm_para_user_Fmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmin{tfm_para_user_counter}(:,2),'.r'); hold on;
        plot(tfm_para_user_Fmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Delete maximum pt.')
        [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        F_new(:,1)=F_init(:,1);
        F_new(:,2)=F_init(:,2);
        F_new(p,:)=[];
        
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        plot(F_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},F_new(:,2)*1e9,'.g'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fmax{tfm_para_user_counter}=F_new;
        
        %update para
        tfm_para_user_para_DeltaF{tfm_para_user_counter}=nanmean(tfm_para_user_Fmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fmin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['F=',num2str(tfm_para_user_para_DeltaF{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fmax',tfm_para_user_Fmax);
        setappdata(0,'tfm_para_user_para_DeltaF',tfm_para_user_para_DeltaF);
        
    end
catch
end

function para_push_forces_removemin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));

try
    if get(h_para(1).radiobutton_forcex,'Value') %Fx
        %load shared needed para
        tfm_para_user_Fxmax=getappdata(0,'tfm_para_user_Fxmax');
        tfm_para_user_Fxmin=getappdata(0,'tfm_para_user_Fxmin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_Fx_tot=getappdata(0,'tfm_para_user_Fx_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaFx=getappdata(0,'tfm_para_user_para_DeltaFx');
        
        Fx_init=tfm_para_user_Fxmin{tfm_para_user_counter};
        hf=figure;
        i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter},'-b'); hold on;
        plot(tfm_para_user_Fxmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmin{tfm_para_user_counter}(:,2),'.r'); hold on;
        i2=plot(tfm_para_user_Fxmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Delete minimum pt.')
        [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        Fx_new(:,1)=Fx_init(:,1);
        Fx_new(:,2)=Fx_init(:,2);
        Fx_new(p,:)=[];
        
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fxmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(Fx_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fx_new(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fxmin{tfm_para_user_counter}=Fx_new;
        
        %update para
        tfm_para_user_para_DeltaFx{tfm_para_user_counter}=nanmean(tfm_para_user_Fxmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fxmin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fx=',num2str(tfm_para_user_para_DeltaFx{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fxmin',tfm_para_user_Fxmin);
        setappdata(0,'tfm_para_user_para_DeltaFx',tfm_para_user_para_DeltaFx);
        
    elseif get(h_para(1).radiobutton_forcey,'Value') %Fy
        %load shared needed para
        tfm_para_user_Fymax=getappdata(0,'tfm_para_user_Fymax');
        tfm_para_user_Fymin=getappdata(0,'tfm_para_user_Fymin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_Fy_tot=getappdata(0,'tfm_para_user_Fy_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaFy=getappdata(0,'tfm_para_user_para_DeltaFy');
        
        Fy_init=tfm_para_user_Fymin{tfm_para_user_counter};
        hf=figure;
        i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter},'-b'); hold on;
        plot(tfm_para_user_Fymin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymin{tfm_para_user_counter}(:,2),'.r'); hold on;
        i2=plot(tfm_para_user_Fymax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Delete minimum pt.')
        [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        Fy_new(:,1)=Fy_init(:,1);
        Fy_new(:,2)=Fy_init(:,2);
        Fy_new(p,:)=[];
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fymax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(Fy_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},Fy_new(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fymin{tfm_para_user_counter}=Fy_new;
        
        %update para
        tfm_para_user_para_DeltaFy{tfm_para_user_counter}=nanmean(tfm_para_user_Fymax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fymin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fy=',num2str(tfm_para_user_para_DeltaFy{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fymin',tfm_para_user_Fymin);
        setappdata(0,'tfm_para_user_para_DeltaFy',tfm_para_user_para_DeltaFy);
        
    elseif get(h_para(1).radiobutton_forcetot,'Value') %F
        %load shared needed para
        tfm_para_user_Fmax=getappdata(0,'tfm_para_user_Fmax');
        tfm_para_user_Fmin=getappdata(0,'tfm_para_user_Fmin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_F_tot=getappdata(0,'tfm_para_user_F_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
        tfm_para_user_para_DeltaF=getappdata(0,'tfm_para_user_para_DeltaF');
        
        F_init=tfm_para_user_Fmin{tfm_para_user_counter};
        hf=figure;
        i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter},'-b'); hold on;
        plot(tfm_para_user_Fmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmin{tfm_para_user_counter}(:,2),'.r'); hold on;
        i2=plot(tfm_para_user_Fmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmax{tfm_para_user_counter}(:,2),'.g'); hold on;
        title('Delete minimum pt.')
        [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
        close(hf);
        
        F_new(:,1)=F_init(:,1);
        F_new(:,2)=F_init(:,2);
        F_new(p,:)=[];
        
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(F_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},F_new(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %
        tfm_para_user_Fmin{tfm_para_user_counter}=F_new;
        
        %update para
        tfm_para_user_para_DeltaF{tfm_para_user_counter}=nanmean(tfm_para_user_Fmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fmin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['F=',num2str(tfm_para_user_para_DeltaF{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fmin',tfm_para_user_Fmin);
        setappdata(0,'tfm_para_user_para_DeltaF',tfm_para_user_para_DeltaF);
        
    end
catch
end

function para_push_forces_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));

try
    if get(h_para(1).radiobutton_forcex,'Value') %Fx
        %load shared needed para
        tfm_para_user_Fxmax=getappdata(0,'tfm_para_user_Fxmax');
        tfm_para_user_Fxmin=getappdata(0,'tfm_para_user_Fxmin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_Fx_tot=getappdata(0,'tfm_para_user_Fx_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_para_user_para_DeltaFx=getappdata(0,'tfm_para_user_para_DeltaFx');
        
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        
        %delte Fimin and Fimax
        tfm_para_user_Fxmin{tfm_para_user_counter}(:,1)=NaN;
        tfm_para_user_Fxmin{tfm_para_user_counter}(:,2)=NaN;
        tfm_para_user_Fxmax{tfm_para_user_counter}(:,1)=NaN;
        tfm_para_user_Fxmax{tfm_para_user_counter}(:,2)=NaN;
        
        %update para
        tfm_para_user_para_DeltaFx{tfm_para_user_counter}=nanmean(tfm_para_user_Fxmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fxmin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fx=',num2str(tfm_para_user_para_DeltaFx{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fxmin',tfm_para_user_Fxmin);
        setappdata(0,'tfm_para_user_Fxmax',tfm_para_user_Fxmax);
        setappdata(0,'tfm_para_user_para_DeltaFx',tfm_para_user_para_DeltaFx);
        
    elseif get(h_para(1).radiobutton_forcey,'Value') %Fy
        %load shared needed para
        tfm_para_user_Fymax=getappdata(0,'tfm_para_user_Fymax');
        tfm_para_user_Fymin=getappdata(0,'tfm_para_user_Fymin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_Fy_tot=getappdata(0,'tfm_para_user_Fy_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_para_user_para_DeltaFy=getappdata(0,'tfm_para_user_para_DeltaFy');
        
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        
        %delte Fimin and Fimax
        tfm_para_user_Fymin{tfm_para_user_counter}(:,1)=NaN;
        tfm_para_user_Fymin{tfm_para_user_counter}(:,2)=NaN;
        tfm_para_user_Fymax{tfm_para_user_counter}(:,1)=NaN;
        tfm_para_user_Fymax{tfm_para_user_counter}(:,2)=NaN;
        
        %update para
        tfm_para_user_para_DeltaFy{tfm_para_user_counter}=nanmean(tfm_para_user_Fymax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fymin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fy=',num2str(tfm_para_user_para_DeltaFy{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fymin',tfm_para_user_Fymin);
        setappdata(0,'tfm_para_user_Fymax',tfm_para_user_Fymax);
        setappdata(0,'tfm_para_user_para_DeltaFy',tfm_para_user_para_DeltaFy);
        
    elseif get(h_para(1).radiobutton_forcetot,'Value') %F
        %load shared needed para
        tfm_para_user_Fmax=getappdata(0,'tfm_para_user_Fmax');
        tfm_para_user_Fmin=getappdata(0,'tfm_para_user_Fmin');
        tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
        tfm_para_user_F_tot=getappdata(0,'tfm_para_user_F_tot');
        tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
        tfm_para_user_para_DeltaF=getappdata(0,'tfm_para_user_para_DeltaF');
        
        %plot new in axes
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        
        %delte Fimin and Fimax
        tfm_para_user_Fmin{tfm_para_user_counter}(:,1)=NaN;
        tfm_para_user_Fmin{tfm_para_user_counter}(:,2)=NaN;
        tfm_para_user_Fmax{tfm_para_user_counter}(:,1)=NaN;
        tfm_para_user_Fmax{tfm_para_user_counter}(:,2)=NaN;
        
        %update para
        tfm_para_user_para_DeltaF{tfm_para_user_counter}=nanmean(tfm_para_user_Fmax{tfm_para_user_counter}(:,2))-nanmean(tfm_para_user_Fmin{tfm_para_user_counter}(:,2));
        set(h_para(1).text_forces,'String',['Fx=',num2str(tfm_para_user_para_DeltaF{tfm_para_user_counter},'%.2e'),' [N]']);
        
        %save for shared use
        setappdata(0,'tfm_para_user_Fmin',tfm_para_user_Fmin);
        setappdata(0,'tfm_para_user_Fmax',tfm_para_user_Fmax);
        setappdata(0,'tfm_para_user_para_DeltaF',tfm_para_user_para_DeltaF);
        
    end
catch
end

function para_push_power_addmax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_Pmax=getappdata(0,'tfm_para_user_Pmax');
    tfm_para_user_Pmin=getappdata(0,'tfm_para_user_Pmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_power=getappdata(0,'tfm_para_user_power');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_Pcontr=getappdata(0,'tfm_para_user_para_Pcontr');
    tfm_para_user_para_Prelax=getappdata(0,'tfm_para_user_para_Prelax');
    
    P_init=tfm_para_user_Pmax{tfm_para_user_counter};
    hf=figure;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter},'-b'), hold on;
    i1=plot(tfm_para_user_Pmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    i2=plot(tfm_para_user_Pmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmax{tfm_para_user_counter}(:,2),'.g'); hold on;
    title('Add new maximum pt.')
    [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    P_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
    P_add(:,2)=y;
    P_new(:,1)=[P_init(:,1);P_add(:,1)];
    P_new(:,2)=[P_init(:,2);P_add(:,2)];
    %plot new in axes
    cla(h_para(1).axes_power)
    axes(h_para(1).axes_power)
    plot(tfm_para_user_dt{tfm_para_user_counter},zeros(1,length(tfm_para_user_dt{tfm_para_user_counter})),'--k'), hold on;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter}*1e12,'-b'), hold on;
    plot(tfm_para_user_Pmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmin{tfm_para_user_counter}(:,2)*1e12,'.r'), hold on;
    plot(P_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},P_new(:,2)*1e12,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_Pmax{tfm_para_user_counter}=P_new;
    
    %upate para
    tfm_para_user_para_Pcontr{tfm_para_user_counter}=nanmean(tfm_para_user_Pmax{tfm_para_user_counter}(:,2));
    tfm_para_user_para_Prelax{tfm_para_user_counter}=nanmean(tfm_para_user_Pmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_power1,'String',['Pcontr=',num2str(tfm_para_user_para_Pcontr{tfm_para_user_counter},'%.2e'),' [W]']);
    set(h_para(1).text_power2,'String',['Prelax=',num2str(tfm_para_user_para_Prelax{tfm_para_user_counter},'%.2e'),' [W]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_Pmax',tfm_para_user_Pmax);
    setappdata(0,'tfm_para_user_para_Pcontr',tfm_para_user_para_Pcontr);
    setappdata(0,'tfm_para_user_para_Prelax',tfm_para_user_para_Prelax);
    
catch
end

function para_push_power_addmin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_Pmax=getappdata(0,'tfm_para_user_Pmax');
    tfm_para_user_Pmin=getappdata(0,'tfm_para_user_Pmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_power=getappdata(0,'tfm_para_user_power');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_Pcontr=getappdata(0,'tfm_para_user_para_Pcontr');
    tfm_para_user_para_Prelax=getappdata(0,'tfm_para_user_para_Prelax');
    
    P_init=tfm_para_user_Pmin{tfm_para_user_counter};
    hf=figure;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter},'-b'), hold on;
    i1=plot(tfm_para_user_Pmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    i2=plot(tfm_para_user_Pmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmax{tfm_para_user_counter}(:,2),'.g'); hold on;
    title('Add new minimum pt.')
    [~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    P_add(:,1)=x*tfm_init_user_framerate{tfm_para_user_counter};
    P_add(:,2)=y;
    P_new(:,1)=[P_init(:,1);P_add(:,1)];
    P_new(:,2)=[P_init(:,2);P_add(:,2)];
    %plot new in axes
    cla(h_para(1).axes_power)
    axes(h_para(1).axes_power)
    plot(tfm_para_user_dt{tfm_para_user_counter},zeros(1,length(tfm_para_user_dt{tfm_para_user_counter})),'--k'), hold on;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter}*1e12,'-b'), hold on;
    plot(tfm_para_user_Pmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmax{tfm_para_user_counter}(:,2)*1e12,'.g'), hold on;
    plot(P_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},P_new(:,2)*1e12,'.r'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_Pmin{tfm_para_user_counter}=P_new;
    
    %upate para
    tfm_para_user_para_Pcontr{tfm_para_user_counter}=nanmean(tfm_para_user_Pmax{tfm_para_user_counter}(:,2));
    tfm_para_user_para_Prelax{tfm_para_user_counter}=nanmean(tfm_para_user_Pmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_power1,'String',['Pcontr=',num2str(tfm_para_user_para_Pcontr{tfm_para_user_counter},'%.2e'),' [W]']);
    set(h_para(1).text_power2,'String',['Prelax=',num2str(tfm_para_user_para_Prelax{tfm_para_user_counter},'%.2e'),' [W]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_Pmin',tfm_para_user_Pmin);
    setappdata(0,'tfm_para_user_para_Pcontr',tfm_para_user_para_Pcontr);
    setappdata(0,'tfm_para_user_para_Prelax',tfm_para_user_para_Prelax);
    
catch
end

function para_push_power_removemax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_Pmax=getappdata(0,'tfm_para_user_Pmax');
    tfm_para_user_Pmin=getappdata(0,'tfm_para_user_Pmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_power=getappdata(0,'tfm_para_user_power');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_Pcontr=getappdata(0,'tfm_para_user_para_Pcontr');
    tfm_para_user_para_Prelax=getappdata(0,'tfm_para_user_para_Prelax');
    
    P_init=tfm_para_user_Pmax{tfm_para_user_counter};
    hf=figure;
    i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter},'-b'); hold on;
    i2=plot(tfm_para_user_Pmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    plot(tfm_para_user_Pmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmax{tfm_para_user_counter}(:,2),'.g'), hold on;
    title('Delete maximum pt.')
    [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    P_new(:,1)=P_init(:,1);
    P_new(:,2)=P_init(:,2);
    P_new(p,:)=[];
    
    
    %plot new in axes
    cla(h_para(1).axes_power)
    axes(h_para(1).axes_power)
    plot(tfm_para_user_dt{tfm_para_user_counter},zeros(1,length(tfm_para_user_dt{tfm_para_user_counter})),'--k'), hold on;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter}*1e12,'-b'), hold on;
    plot(tfm_para_user_Pmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmin{tfm_para_user_counter}(:,2)*1e12,'.r'), hold on;
    plot(P_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},P_new(:,2)*1e12,'.g'), hold on;
    
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_Pmax{tfm_para_user_counter}=P_new;
    
    %upate para
    tfm_para_user_para_Pcontr{tfm_para_user_counter}=nanmean(tfm_para_user_Pmax{tfm_para_user_counter}(:,2));
    tfm_para_user_para_Prelax{tfm_para_user_counter}=nanmean(tfm_para_user_Pmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_power1,'String',['Pcontr=',num2str(tfm_para_user_para_Pcontr{tfm_para_user_counter},'%.2e'),' [W]']);
    set(h_para(1).text_power2,'String',['Prelax=',num2str(tfm_para_user_para_Prelax{tfm_para_user_counter},'%.2e'),' [W]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_Pmax',tfm_para_user_Pmax);
    setappdata(0,'tfm_para_user_para_Pcontr',tfm_para_user_para_Pcontr);
    setappdata(0,'tfm_para_user_para_Prelax',tfm_para_user_para_Prelax);
    
catch
end

function para_push_power_removemin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_Pmax=getappdata(0,'tfm_para_user_Pmax');
    tfm_para_user_Pmin=getappdata(0,'tfm_para_user_Pmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_power=getappdata(0,'tfm_para_user_power');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_Pcontr=getappdata(0,'tfm_para_user_para_Pcontr');
    tfm_para_user_para_Prelax=getappdata(0,'tfm_para_user_para_Prelax');
    
    P_init=tfm_para_user_Pmin{tfm_para_user_counter};
    hf=figure;
    i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter},'-b'); hold on;
    plot(tfm_para_user_Pmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmin{tfm_para_user_counter}(:,2),'.r'); hold on;
    i2=plot(tfm_para_user_Pmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmax{tfm_para_user_counter}(:,2),'.g'); hold on;
    title('Delete minimum pt.')
    
    [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    P_new(:,1)=P_init(:,1);
    P_new(:,2)=P_init(:,2);
    P_new(p,:)=[];
    
    
    %plot new in axes
    cla(h_para(1).axes_power)
    axes(h_para(1).axes_power)
    plot(tfm_para_user_dt{tfm_para_user_counter},zeros(1,length(tfm_para_user_dt{tfm_para_user_counter})),'--k'), hold on;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter}*1e12,'-b'), hold on;
    plot(tfm_para_user_Pmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmax{tfm_para_user_counter}(:,2)*1e12,'.g'), hold on;
    plot(P_new(:,1)/tfm_init_user_framerate{tfm_para_user_counter},P_new(:,2)*1e12,'.r'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    tfm_para_user_Pmin{tfm_para_user_counter}=P_new;
    
    %upate para
    tfm_para_user_para_Pcontr{tfm_para_user_counter}=nanmean(tfm_para_user_Pmax{tfm_para_user_counter}(:,2));
    tfm_para_user_para_Prelax{tfm_para_user_counter}=nanmean(tfm_para_user_Pmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_power1,'String',['Pcontr=',num2str(tfm_para_user_para_Pcontr{tfm_para_user_counter},'%.2e'),' [W]']);
    set(h_para(1).text_power2,'String',['Prelax=',num2str(tfm_para_user_para_Prelax{tfm_para_user_counter},'%.2e'),' [W]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_Pmin',tfm_para_user_Pmin);
    setappdata(0,'tfm_para_user_para_Pcontr',tfm_para_user_para_Pcontr);
    setappdata(0,'tfm_para_user_para_Prelax',tfm_para_user_para_Prelax);
    
catch
end

function para_push_power_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load shared needed para
    tfm_para_user_Pmax=getappdata(0,'tfm_para_user_Pmax');
    tfm_para_user_Pmin=getappdata(0,'tfm_para_user_Pmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_power=getappdata(0,'tfm_para_user_power');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_para_Pcontr=getappdata(0,'tfm_para_user_para_Pcontr');
    tfm_para_user_para_Prelax=getappdata(0,'tfm_para_user_para_Prelax');
    
    %plot new in axes
    cla(h_para(1).axes_power)
    axes(h_para(1).axes_power)
    plot(tfm_para_user_dt{tfm_para_user_counter},zeros(1,length(tfm_para_user_dt{tfm_para_user_counter})),'--k'), hold on;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter}*1e12,'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %delte pmin and pmax
    tfm_para_user_Pmin{tfm_para_user_counter}(:,1)=NaN;
    tfm_para_user_Pmin{tfm_para_user_counter}(:,2)=NaN;
    tfm_para_user_Pmax{tfm_para_user_counter}(:,1)=NaN;
    tfm_para_user_Pmax{tfm_para_user_counter}(:,2)=NaN;
    
    %upate para
    tfm_para_user_para_Pcontr{tfm_para_user_counter}=nanmean(tfm_para_user_Pmax{tfm_para_user_counter}(:,2));
    tfm_para_user_para_Prelax{tfm_para_user_counter}=nanmean(tfm_para_user_Pmin{tfm_para_user_counter}(:,2));
    set(h_para(1).text_power1,'String',['Pcontr=',num2str(tfm_para_user_para_Pcontr{tfm_para_user_counter},'%.2e'),' [W]']);
    set(h_para(1).text_power2,'String',['Prelax=',num2str(tfm_para_user_para_Prelax{tfm_para_user_counter},'%.2e'),' [W]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_Pmin',tfm_para_user_Pmin);
    setappdata(0,'tfm_para_user_Pmax',tfm_para_user_Pmax);
    setappdata(0,'tfm_para_user_para_Pcontr',tfm_para_user_para_Pcontr);
    setappdata(0,'tfm_para_user_para_Prelax',tfm_para_user_para_Prelax);
    
catch
end

function para_push_contr_add(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_velocity=getappdata(0,'tfm_para_user_velocity');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_tcontr=getappdata(0,'tfm_para_user_tcontr');
    tfm_para_user_para_tcontr=getappdata(0,'tfm_para_user_para_tcontr');
    
    t_init=tfm_para_user_tcontr{tfm_para_user_counter};
    
    hf=figure;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter},'-b'), hold on;
    i1=plot(t_init(:,1),t_init(:,3),'.r');
    i2=plot(t_init(:,2),t_init(:,4),'.r');
    title('Add new maximum pt.')
    [~,x1,y1] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    cla;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter},'-b'), hold on;
    i1=plot(t_init(:,1),t_init(:,3),'.r');
    i2=plot(t_init(:,2),t_init(:,4),'.r');
    i3=plot(x1,y1,'.g'); hold on;
    title('Add new minimum pt.')
    [~,x2,y2] = selectdata('SelectionMode','closest','Ignore',[i1,i2,i3]);
    close(hf);
    
    t_add(:,1)=x1;
    t_add(:,2)=x2;
    t_add(:,3)=y1;
    t_add(:,4)=y2;
    t_new(:,1)=[t_init(:,1);t_add(:,1)];
    t_new(:,2)=[t_init(:,2);t_add(:,2)];
    t_new(:,3)=[t_init(:,3);t_add(:,3)];
    t_new(:,4)=[t_init(:,4);t_add(:,4)];
    
    %plot new in axes
    cla(h_para(1).axes_contr)
    axes(h_para(1).axes_contr)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(t_new(:,1),t_new(:,3)*1e6,'.r')
    plot(t_new(:,2),t_new(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(t_new,1));
    for i=1:size(t_new,1)
        dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
        plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %save new pt vector
    tfm_para_user_tcontr{tfm_para_user_counter}=t_new;
    tfm_para_user_para_tcontr{tfm_para_user_counter}=nanmean(dtcontr);
    set(h_para(1).text_contr,'String',['tcontr=',num2str(tfm_para_user_para_tcontr{tfm_para_user_counter},'%.2e'),' [s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_tcontr',tfm_para_user_tcontr);
    setappdata(0,'tfm_para_user_para_tcontr',tfm_para_user_para_tcontr);
    
catch
end

function para_push_contr_remove(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_velocity=getappdata(0,'tfm_para_user_velocity');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_tcontr=getappdata(0,'tfm_para_user_tcontr');
    tfm_para_user_para_tcontr=getappdata(0,'tfm_para_user_para_tcontr');
    
    t_init=tfm_para_user_tcontr{tfm_para_user_counter};
    
    hf=figure;
    i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter},'-b'); hold on;
    plot(t_init(:,1),t_init(:,3),'.r');
    i2=plot(t_init(:,2),t_init(:,4),'.r');
    title('Delte maximum pt.')
    [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    t_new(:,1)=t_init(:,1);
    t_new(:,2)=t_init(:,2);
    t_new(:,3)=t_init(:,3);
    t_new(:,4)=t_init(:,4);
    t_new(p,:)=[];
    
    %plot new in axes
    cla(h_para(1).axes_contr)
    axes(h_para(1).axes_contr)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(t_new(:,1),t_new(:,3)*1e6,'.r')
    plot(t_new(:,2),t_new(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(t_new,1));
    for i=1:size(t_new,1)
        dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
        plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %save new pt vector
    tfm_para_user_tcontr{tfm_para_user_counter}=t_new;
    tfm_para_user_para_tcontr{tfm_para_user_counter}=nanmean(dtcontr);
    set(h_para(1).text_contr,'String',['tcontr=',num2str(tfm_para_user_para_tcontr{tfm_para_user_counter},'%.2e'),' [s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_tcontr',tfm_para_user_tcontr);
    setappdata(0,'tfm_para_user_para_tcontr',tfm_para_user_para_tcontr);
    
catch
end

function para_push_contr_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_velocity=getappdata(0,'tfm_para_user_velocity');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_tcontr=getappdata(0,'tfm_para_user_tcontr');
    tfm_para_user_para_tcontr=getappdata(0,'tfm_para_user_para_tcontr');
    
    t_init=tfm_para_user_tcontr{tfm_para_user_counter};
    
    t_new(:,1)=NaN;
    t_new(:,2)=NaN;
    t_new(:,3)=NaN;
    t_new(:,4)=NaN;
    
    %plot new in axes
    cla(h_para(1).axes_contr)
    axes(h_para(1).axes_contr)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    
    dtcontr=zeros(1,size(t_new,1));
    for i=1:size(t_new,1)
        dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
        plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %save new pt vector
    tfm_para_user_tcontr{tfm_para_user_counter}=t_new;
    tfm_para_user_para_tcontr{tfm_para_user_counter}=nanmean(dtcontr);
    set(h_para(1).text_contr,'String',['tcontr=',num2str(tfm_para_user_para_tcontr{tfm_para_user_counter},'%.2e'),' [s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_tcontr',tfm_para_user_tcontr);
    setappdata(0,'tfm_para_user_para_tcontr',tfm_para_user_para_tcontr);
    
catch
end

function para_push_dp2_add(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_tdp=getappdata(0,'tfm_para_user_tdp');
    tfm_para_user_para_tdp=getappdata(0,'tfm_para_user_para_tdp');
    
    t_init=tfm_para_user_tdp{tfm_para_user_counter};
    
    hf=figure;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter},'-b'), hold on;
    i1=plot(t_init(:,1),t_init(:,3),'.r');
    i2=plot(t_init(:,2),t_init(:,4),'.r');
    title('Add new primary peak')
    [~,x1,y1] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    cla;
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter},'-b'), hold on;
    i1=plot(t_init(:,1),t_init(:,3),'.r');
    i2=plot(t_init(:,2),t_init(:,4),'.r');
    i3=plot(x1,y1,'.g'); hold on;
    title('Add corresponding secondary peak')
    [~,x2,y2] = selectdata('SelectionMode','closest','Ignore',[i1,i2,i3]);
    close(hf);
    
    t_add(:,1)=x1;
    t_add(:,2)=x2;
    t_add(:,3)=y1;
    t_add(:,4)=y2;
    t_new(:,1)=[t_init(:,1);t_add(:,1)];
    t_new(:,2)=[t_init(:,2);t_add(:,2)];
    t_new(:,3)=[t_init(:,3);t_add(:,3)];
    t_new(:,4)=[t_init(:,4);t_add(:,4)];
    
    %displ. in double peak
    cla(h_para(1).axes_dp2)
    axes(h_para(1).axes_dp2)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(t_new(:,1),t_new(:,3)*1e6,'.r')
    plot(t_new(:,2),t_new(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(t_new,1));
    for i=1:size(t_new,1)
        dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
        plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %save new pt vector
    tfm_para_user_tdp{tfm_para_user_counter}=t_new;
    tfm_para_user_para_tdp{tfm_para_user_counter}=nanmean(dtcontr);
    set(h_para(1).text_dp2_2,'String',['t=',num2str(tfm_para_user_para_tdp{tfm_para_user_counter},'%.2e'),' [s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_tdp',tfm_para_user_tdp);
    setappdata(0,'tfm_para_user_para_tdp',tfm_para_user_para_tdp);
    
catch
end

function para_push_dp2_remove(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_tdp=getappdata(0,'tfm_para_user_tdp');
    tfm_para_user_para_tdp=getappdata(0,'tfm_para_user_para_tdp');
    
    t_init=tfm_para_user_tdp{tfm_para_user_counter};
    
    hf=figure;
    i1=plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter},'-b'); hold on;
    plot(t_init(:,1),t_init(:,3),'.r');
    i2=plot(t_init(:,2),t_init(:,4),'.r');
    title('Delte maximum pt.')
    [p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
    close(hf);
    
    t_new(:,1)=t_init(:,1);
    t_new(:,2)=t_init(:,2);
    t_new(:,3)=t_init(:,3);
    t_new(:,4)=t_init(:,4);
    t_new(p,:)=[];
    
    %displ. in double peak
    cla(h_para(1).axes_dp2)
    axes(h_para(1).axes_dp2)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(t_new(:,1),t_new(:,3)*1e6,'.r')
    plot(t_new(:,2),t_new(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(t_new,1));
    for i=1:size(t_new,1)
        dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
        plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %save new pt vector
    tfm_para_user_tdp{tfm_para_user_counter}=t_new;
    tfm_para_user_para_tdp{tfm_para_user_counter}=nanmean(dtcontr);
    set(h_para(1).text_dp2_2,'String',['t=',num2str(tfm_para_user_para_tdp{tfm_para_user_counter},'%.2e'),' [s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_tdp',tfm_para_user_tdp);
    setappdata(0,'tfm_para_user_para_tdp',tfm_para_user_para_tdp);
    
catch
end

function para_push_dp2_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_para_user_tdp=getappdata(0,'tfm_para_user_tdp');
    tfm_para_user_para_tdp=getappdata(0,'tfm_para_user_para_tdp');
    
    t_new(:,1)=NaN;
    t_new(:,2)=NaN;
    t_new(:,3)=NaN;
    t_new(:,4)=NaN;
    
    cla(h_para(1).axes_dp2)
    axes(h_para(1).axes_dp2)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    
    dtcontr=zeros(1,size(t_new,1));
    for i=1:size(t_new,1)
        dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
        plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %save new pt vector
    tfm_para_user_tdp{tfm_para_user_counter}=t_new;
    tfm_para_user_para_tdp{tfm_para_user_counter}=nanmean(dtcontr);
    set(h_para(1).text_dp2_2,'String',['t=',num2str(tfm_para_user_para_tdp{tfm_para_user_counter},'%.2e'),' [s]']);
    
    %save for shared use
    setappdata(0,'tfm_para_user_tdp',tfm_para_user_tdp);
    setappdata(0,'tfm_para_user_para_tdp',tfm_para_user_para_tdp);
    
catch
end

function para_push_forwards(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load what shared para we need
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    dmax=getappdata(0,'tfm_para_user_dmax');
    dmin=getappdata(0,'tfm_para_user_dmin');
    vmax=getappdata(0,'tfm_para_user_vmax');
    vmin=getappdata(0,'tfm_para_user_vmin');
    dt=getappdata(0,'tfm_para_user_dt');
    Velocity=getappdata(0,'tfm_para_user_velocity');
    tfm_para_user_para_Deltad=getappdata(0,'tfm_para_user_para_Deltad');
    tfm_para_user_para_vcontr=getappdata(0,'tfm_para_user_para_vcontr');
    tfm_para_user_para_vrelax=getappdata(0,'tfm_para_user_para_vrelax');
    tfm_para_user_tcontr=getappdata(0,'tfm_para_user_tcontr');
    tfm_para_user_para_tcontr=getappdata(0,'tfm_para_user_para_tcontr');
    tfm_para_user_tdp=getappdata(0,'tfm_para_user_tdp');
    tfm_para_user_para_tdp=getappdata(0,'tfm_para_user_para_tdp');
    tfm_para_user_freq2=getappdata(0,'tfm_para_user_freq2');
    tfm_para_user_para_freq2=getappdata(0,'tfm_para_user_para_freq2');
    tfm_para_user_para_freq=getappdata(0,'tfm_para_user_para_freq');
    tfm_para_user_para_freqy=getappdata(0,'tfm_para_user_para_freqy');
    freq=getappdata(0,'tfm_para_user_freq');
    y_fft=getappdata(0,'tfm_para_user_y_fft');
    tfm_para_user_para_ratiop=getappdata(0,'tfm_para_user_para_ratiop');
    tfm_para_user_para_ratiodp=getappdata(0,'tfm_para_user_para_ratiodp');
    tfm_init_user_outline2x=getappdata(0,'tfm_init_user_outline2x');
    tfm_init_user_outline2y=getappdata(0,'tfm_init_user_outline2y');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_para_user_para_tagdp=getappdata(0,'tfm_para_user_para_tagdp');
    tfm_para_user_para_tag=getappdata(0,'tfm_para_user_para_tag');
    tfm_para_user_Fmax=getappdata(0,'tfm_para_user_Fmax');
    tfm_para_user_Fmin=getappdata(0,'tfm_para_user_Fmin');
    tfm_para_user_F_tot=getappdata(0,'tfm_para_user_F_tot');
    tfm_para_user_para_DeltaF=getappdata(0,'tfm_para_user_para_DeltaF');
    tfm_para_user_Fxmax=getappdata(0,'tfm_para_user_Fxmax');
    tfm_para_user_Fxmin=getappdata(0,'tfm_para_user_Fxmin');
    tfm_para_user_Fx_tot=getappdata(0,'tfm_para_user_Fx_tot');
    tfm_para_user_para_DeltaFx=getappdata(0,'tfm_para_user_para_DeltaFx'); 
    tfm_para_user_Fymax=getappdata(0,'tfm_para_user_Fymax');
    tfm_para_user_Fymin=getappdata(0,'tfm_para_user_Fymin');
    tfm_para_user_Fy_tot=getappdata(0,'tfm_para_user_Fy_tot');
    tfm_para_user_para_DeltaFy=getappdata(0,'tfm_para_user_para_DeltaFy');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate'); 
    tfm_para_user_Pmax=getappdata(0,'tfm_para_user_Pmax');
    tfm_para_user_Pmin=getappdata(0,'tfm_para_user_Pmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_power=getappdata(0,'tfm_para_user_power');
    tfm_para_user_para_Pcontr=getappdata(0,'tfm_para_user_para_Pcontr');
    tfm_para_user_para_Prelax=getappdata(0,'tfm_para_user_para_Prelax');
    
    %save current stuff
    tfm_para_user_para_ratiop{tfm_para_user_counter}=str2double(get(h_para(1).edit_ratio,'String'));
    if tfm_para_user_para_tagdp{tfm_para_user_counter}
        tfm_para_user_para_ratiodp{tfm_para_user_counter}=str2double(get(h_para(1).edit_dp2,'String'));
    end
    
    %go to video before
    tfm_para_user_counter=tfm_para_user_counter+1;
    
    %set tags
    set(h_para(1).edit_ratio,'String',num2str(tfm_para_user_para_ratiop{tfm_para_user_counter}));
    if tfm_para_user_para_tagdp{tfm_para_user_counter}
        set(h_para(1).edit_dp2,'String',num2str(tfm_para_user_para_ratiodp{tfm_para_user_counter}));
    end
    %checkboxes
    if tfm_para_user_para_tag{tfm_para_user_counter}
        set(h_para(1).checkbox_tag,'Value',1)
    else
        set(h_para(1).checkbox_tag,'Value',0)
    end
    if tfm_para_user_para_tagdp{tfm_para_user_counter}
        set(h_para(1).panel_dp2,'Visible','on')
        set(h_para(1).checkbox_dpyes,'Value',1)
        set(h_para(1).checkbox_dpno,'Value',0)
    else
        set(h_para(1).checkbox_dpyes,'Value',0)
        set(h_para(1).checkbox_dpno,'Value',1)
        set(h_para(1).panel_dp2,'Visible','off')
    end
    
    %display plots
    %plot 1st displ. in axes
    cla(h_para(1).axes_disp)
    axes(h_para(1).axes_disp)
    plot(dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(dmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},dmin{tfm_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(dmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},dmax{tfm_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %displ. in double peak
    cla(h_para(1).axes_dp2)
    axes(h_para(1).axes_dp2)
    plot(dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_tdp{tfm_para_user_counter}(:,1),tfm_para_user_tdp{tfm_para_user_counter}(:,3)*1e6,'.r')
    plot(tfm_para_user_tdp{tfm_para_user_counter}(:,2),tfm_para_user_tdp{tfm_para_user_counter}(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(tfm_para_user_tdp{tfm_para_user_counter},1));
    for i=1:size(tfm_para_user_tdp{tfm_para_user_counter},1)
        dtcontr(1,i)=abs(tfm_para_user_tdp{tfm_para_user_counter}(i,2)-tfm_para_user_tdp{tfm_para_user_counter}(i,1));
        plot(linspace(tfm_para_user_tdp{tfm_para_user_counter}(i,1),tfm_para_user_tdp{tfm_para_user_counter}(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %plot 1st velocity. in axes
    cla(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(dt{tfm_para_user_counter},zeros(1,length(dt{tfm_para_user_counter})),'--k'), hold on;
    plot(dt{tfm_para_user_counter},Velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(vmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},vmin{tfm_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(vmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},vmax{tfm_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %%plot 1st velocity. in axes
    cla(h_para(1).axes_contr)
    axes(h_para(1).axes_contr)
    plot(dt{tfm_para_user_counter},Velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_tcontr{tfm_para_user_counter}(:,1),tfm_para_user_tcontr{tfm_para_user_counter}(:,3)*1e6,'.r')
    plot(tfm_para_user_tcontr{tfm_para_user_counter}(:,2),tfm_para_user_tcontr{tfm_para_user_counter}(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(tfm_para_user_tcontr{tfm_para_user_counter},1));
    for i=1:size(tfm_para_user_tcontr{tfm_para_user_counter},1)
        dtcontr(1,i)=abs(tfm_para_user_tcontr{tfm_para_user_counter}(i,2)-tfm_para_user_tcontr{tfm_para_user_counter}(i,1));
        plot(linspace(tfm_para_user_tcontr{tfm_para_user_counter}(i,1),tfm_para_user_tcontr{tfm_para_user_counter}(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %preview
    reset(h_para(1).axes_preview)
    axes(h_para(1).axes_preview)
    s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,tfm_para_user_counter},'/image',num2str(tfm_piv_user_relax{tfm_para_user_counter}),'.mat'],'imagei');
    image=s.imagei;
    imagesc(image); hold on;
    
    set(h_para(1).axes_preview,'xtick',[],'ytick',[])
    colormap('gray')
    freezeColors
    plot(tfm_init_user_outline2x{tfm_para_user_counter},tfm_init_user_outline2y{tfm_para_user_counter},'r','LineWidth',1);
    axis image;
    
    %forces
    if get(h_para(1).radiobutton_forcetot,'Value') %ftot
        %set correct plot
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(tfm_para_user_Fmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %set correct text
        set(h_para(1).text_forces,'String',['F=',num2str(tfm_para_user_para_DeltaF{tfm_para_user_counter},'%.2e'),' [N]']);
    elseif get(h_para(1).radiobutton_forcex,'Value') %fx
        %set correct plot
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fxmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(tfm_para_user_Fxmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %set correct text
        set(h_para(1).text_forces,'String',['Fx=',num2str(tfm_para_user_para_DeltaFx{tfm_para_user_counter},'%.2e'),' [N]']);
    elseif get(h_para(1).radiobutton_forcey,'Value') %fy
        %set correct plot
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fymax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(tfm_para_user_Fymin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %set correct text
        set(h_para(1).text_forces,'String',['Fy=',num2str(tfm_para_user_para_DeltaFy{tfm_para_user_counter},'%.2e'),' [N]']);
    end
    
    %power
    cla(h_para(1).axes_power)
    axes(h_para(1).axes_power)
    plot(dt{tfm_para_user_counter},zeros(1,length(dt{tfm_para_user_counter})),'--k'), hold on;
    plot(dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter}*1e12,'-b'), hold on;
    plot(tfm_para_user_Pmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmin{tfm_para_user_counter}(:,2)*1e12,'.r'), hold on;
    plot(tfm_para_user_Pmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmax{tfm_para_user_counter}(:,2)*1e12,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %freq.
    if get(h_para(1).radiobutton_fft,'Value')
        %make unwanted buttons invisible
        set(h_para(1).button_freq_add,'Visible','off');
        set(h_para(1).button_freq_remove,'Visible','off');
        set(h_para(1).button_freq_clearall,'Visible','off');
        %enable wanted button
        set(h_para(1).button_freq_addfft,'Visible','on');
        %plot frequency. in axes
        x=tfm_para_user_para_freq{tfm_para_user_counter};
        y=tfm_para_user_para_freqy{tfm_para_user_counter};
        cla(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(freq{tfm_para_user_counter},y_fft{tfm_para_user_counter},'-b'), hold on;
        plot(x,y,'.g')
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %para
        set(h_para(1).text_freq1,'String',['f=',num2str(x,'%.2e'),' [Hz]']);
        set(h_para(1).text_freq2,'String',['T=',num2str(1/(x+eps),'%.2e'),' [s]']);
    elseif get(h_para(1).radiobutton_pick,'Value')
        %make  buttons visible
        set(h_para(1).button_freq_add,'Visible','on');
        set(h_para(1).button_freq_remove,'Visible','on');
        set(h_para(1).button_freq_clearall,'Visible','on');
        %disable unwanted button
        set(h_para(1).button_freq_addfft,'Visible','off');
        %plot displ. in axes
        t_new=tfm_para_user_freq2{tfm_para_user_counter};
        x=1/(tfm_para_user_para_freq2{tfm_para_user_counter}+eps);
        cla(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
        %plot delta t
        dtcontr=zeros(1,size(t_new,1));
        cmap = hsv(size(t_new,1));
        for i=1:size(t_new,1)
            plot(t_new(i,1),t_new(i,3)*1e6,'.','Color',cmap(i,:))
            plot(t_new(i,2),t_new(i,4)*1e6,'.','Color',cmap(i,:))
            dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
            plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'Color',cmap(i,:),'LineWidth',5)
        end
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %para
        set(h_para(1).text_freq1,'String',['f=',num2str(1/(x+eps),'%.2e'),' [Hz]']);
        set(h_para(1).text_freq2,'String',['T=',num2str(x,'%.2e'),' [s]']);
    end
    
    %displaz para
    %diplay
    set(h_para(1).text_disp,'String',['dcontr=',num2str(tfm_para_user_para_Deltad{tfm_para_user_counter},'%.2e'),' [m]']);
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(tfm_para_user_para_vcontr{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(tfm_para_user_para_vrelax{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_dp2_2,'String',['t=',num2str(tfm_para_user_para_tdp{tfm_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_contr,'String',['tcontr=',num2str(tfm_para_user_para_tcontr{tfm_para_user_counter},'%.2e'),' [s]']);  
    set(h_para(1).text_power1,'String',['Pcontr=',num2str(tfm_para_user_para_Pcontr{tfm_para_user_counter},'%.2e'),' [W]']);
    set(h_para(1).text_power2,'String',['Prelax=',num2str(tfm_para_user_para_Prelax{tfm_para_user_counter},'%.2e'),' [W]']);
    
    %set texts to 1st vid
    set(h_para(1).text_whichvidname,'String',tfm_init_user_filenamestack{1,tfm_para_user_counter});
    set(h_para(1).text_whichvid,'String',[num2str(tfm_para_user_counter),'/',num2str(tfm_init_user_Nfiles)]);
    
    
    %forward /backbutton
    if tfm_para_user_counter==1
        set(h_para(1).button_backwards,'Enable','off');
    else
        set(h_para(1).button_backwards,'Enable','on');
    end
    if tfm_para_user_counter==tfm_init_user_Nfiles
        set(h_para(1).button_forwards,'Enable','off');
    else
        set(h_para(1).button_forwards,'Enable','on');
    end
    
    %shared data
    setappdata(0,'tfm_para_user_para_ratiop',tfm_para_user_para_ratiop);
    setappdata(0,'tfm_para_user_para_ratiodp',tfm_para_user_para_ratiodp);
    setappdata(0,'tfm_para_user_counter',tfm_para_user_counter);
    
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function para_push_backwards(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load what shared para we need
    tfm_para_user_d=getappdata(0,'tfm_para_user_d');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    dmax=getappdata(0,'tfm_para_user_dmax');
    dmin=getappdata(0,'tfm_para_user_dmin');
    vmax=getappdata(0,'tfm_para_user_vmax');
    vmin=getappdata(0,'tfm_para_user_vmin');
    dt=getappdata(0,'tfm_para_user_dt');
    Velocity=getappdata(0,'tfm_para_user_velocity');
    tfm_para_user_para_Deltad=getappdata(0,'tfm_para_user_para_Deltad');
    tfm_para_user_para_vcontr=getappdata(0,'tfm_para_user_para_vcontr');
    tfm_para_user_para_vrelax=getappdata(0,'tfm_para_user_para_vrelax');
    tfm_para_user_tcontr=getappdata(0,'tfm_para_user_tcontr');
    tfm_para_user_para_tcontr=getappdata(0,'tfm_para_user_para_tcontr');
    tfm_para_user_tdp=getappdata(0,'tfm_para_user_tdp');
    tfm_para_user_para_tdp=getappdata(0,'tfm_para_user_para_tdp');
    tfm_para_user_freq2=getappdata(0,'tfm_para_user_freq2');
    tfm_para_user_para_freq2=getappdata(0,'tfm_para_user_para_freq2');
    tfm_para_user_para_freq=getappdata(0,'tfm_para_user_para_freq');
    tfm_para_user_para_freqy=getappdata(0,'tfm_para_user_para_freqy');
    freq=getappdata(0,'tfm_para_user_freq');
    y_fft=getappdata(0,'tfm_para_user_y_fft');
    tfm_para_user_para_ratiop=getappdata(0,'tfm_para_user_para_ratiop');
    tfm_para_user_para_ratiodp=getappdata(0,'tfm_para_user_para_ratiodp');
    tfm_init_user_outline2x=getappdata(0,'tfm_init_user_outline2x');
    tfm_init_user_outline2y=getappdata(0,'tfm_init_user_outline2y');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_para_user_para_tagdp=getappdata(0,'tfm_para_user_para_tagdp');
    tfm_para_user_para_tag=getappdata(0,'tfm_para_user_para_tag');
    tfm_para_user_Fmax=getappdata(0,'tfm_para_user_Fmax');
    tfm_para_user_Fmin=getappdata(0,'tfm_para_user_Fmin');
    tfm_para_user_F_tot=getappdata(0,'tfm_para_user_F_tot');
    tfm_para_user_para_DeltaF=getappdata(0,'tfm_para_user_para_DeltaF');
    tfm_para_user_Fxmax=getappdata(0,'tfm_para_user_Fxmax');
    tfm_para_user_Fxmin=getappdata(0,'tfm_para_user_Fxmin');
    tfm_para_user_Fx_tot=getappdata(0,'tfm_para_user_Fx_tot');
    tfm_para_user_para_DeltaFx=getappdata(0,'tfm_para_user_para_DeltaFx'); 
    tfm_para_user_Fymax=getappdata(0,'tfm_para_user_Fymax');
    tfm_para_user_Fymin=getappdata(0,'tfm_para_user_Fymin');
    tfm_para_user_Fy_tot=getappdata(0,'tfm_para_user_Fy_tot');
    tfm_para_user_para_DeltaFy=getappdata(0,'tfm_para_user_para_DeltaFy');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate'); 
    tfm_para_user_Pmax=getappdata(0,'tfm_para_user_Pmax');
    tfm_para_user_Pmin=getappdata(0,'tfm_para_user_Pmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_power=getappdata(0,'tfm_para_user_power');
    tfm_para_user_para_Pcontr=getappdata(0,'tfm_para_user_para_Pcontr');
    tfm_para_user_para_Prelax=getappdata(0,'tfm_para_user_para_Prelax');
    
    %save current stuff
    tfm_para_user_para_ratiop{tfm_para_user_counter}=str2double(get(h_para(1).edit_ratio,'String'));
    if tfm_para_user_para_tagdp{tfm_para_user_counter}
        tfm_para_user_para_ratiodp{tfm_para_user_counter}=str2double(get(h_para(1).edit_dp2,'String'));
    end
    
    %go to video before
    tfm_para_user_counter=tfm_para_user_counter-1;
    
    %set tags
    set(h_para(1).edit_ratio,'String',num2str(tfm_para_user_para_ratiop{tfm_para_user_counter}));
    if tfm_para_user_para_tagdp{tfm_para_user_counter}
        set(h_para(1).edit_dp2,'String',num2str(tfm_para_user_para_ratiodp{tfm_para_user_counter}));
    end
    %checkboxes
    if tfm_para_user_para_tag{tfm_para_user_counter}
        set(h_para(1).checkbox_tag,'Value',1)
    else
        set(h_para(1).checkbox_tag,'Value',0)
    end
    if tfm_para_user_para_tagdp{tfm_para_user_counter}
        set(h_para(1).panel_dp2,'Visible','on')
        set(h_para(1).checkbox_dpyes,'Value',1)
        set(h_para(1).checkbox_dpno,'Value',0)
    else
        set(h_para(1).checkbox_dpyes,'Value',0)
        set(h_para(1).checkbox_dpno,'Value',1)
        set(h_para(1).panel_dp2,'Visible','off')
    end
    
    %display plots
    %plot 1st displ. in axes
    cla(h_para(1).axes_disp)
    axes(h_para(1).axes_disp)
    plot(dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(dmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},dmin{tfm_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(dmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},dmax{tfm_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %displ. in double peak
    cla(h_para(1).axes_dp2)
    axes(h_para(1).axes_dp2)
    plot(dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_tdp{tfm_para_user_counter}(:,1),tfm_para_user_tdp{tfm_para_user_counter}(:,3)*1e6,'.r')
    plot(tfm_para_user_tdp{tfm_para_user_counter}(:,2),tfm_para_user_tdp{tfm_para_user_counter}(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(tfm_para_user_tdp{tfm_para_user_counter},1));
    for i=1:size(tfm_para_user_tdp{tfm_para_user_counter},1)
        dtcontr(1,i)=abs(tfm_para_user_tdp{tfm_para_user_counter}(i,2)-tfm_para_user_tdp{tfm_para_user_counter}(i,1));
        plot(linspace(tfm_para_user_tdp{tfm_para_user_counter}(i,1),tfm_para_user_tdp{tfm_para_user_counter}(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %plot 1st velocity. in axes
    cla(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(dt{tfm_para_user_counter},zeros(1,length(dt{tfm_para_user_counter})),'--k'), hold on;
    plot(dt{tfm_para_user_counter},Velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(vmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},vmin{tfm_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(vmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},vmax{tfm_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %%plot 1st velocity. in axes
    cla(h_para(1).axes_contr)
    axes(h_para(1).axes_contr)
    plot(dt{tfm_para_user_counter},Velocity{tfm_para_user_counter}*1e6,'-b'), hold on;
    plot(tfm_para_user_tcontr{tfm_para_user_counter}(:,1),tfm_para_user_tcontr{tfm_para_user_counter}(:,3)*1e6,'.r')
    plot(tfm_para_user_tcontr{tfm_para_user_counter}(:,2),tfm_para_user_tcontr{tfm_para_user_counter}(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(tfm_para_user_tcontr{tfm_para_user_counter},1));
    for i=1:size(tfm_para_user_tcontr{tfm_para_user_counter},1)
        dtcontr(1,i)=abs(tfm_para_user_tcontr{tfm_para_user_counter}(i,2)-tfm_para_user_tcontr{tfm_para_user_counter}(i,1));
        plot(linspace(tfm_para_user_tcontr{tfm_para_user_counter}(i,1),tfm_para_user_tcontr{tfm_para_user_counter}(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %preview
    reset(h_para(1).axes_preview)
    axes(h_para(1).axes_preview)
    s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,tfm_para_user_counter},'/image',num2str(tfm_piv_user_relax{tfm_para_user_counter}),'.mat'],'imagei');
    image=s.imagei;
    imagesc(image); hold on;
    
    set(h_para(1).axes_preview,'xtick',[],'ytick',[])
    colormap('gray')
    freezeColors
    plot(tfm_init_user_outline2x{tfm_para_user_counter},tfm_init_user_outline2y{tfm_para_user_counter},'r','LineWidth',1);
    axis image;
    
    %forces
    if get(h_para(1).radiobutton_forcetot,'Value') %ftot
        %set correct plot
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(tfm_para_user_Fmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %set correct text
        set(h_para(1).text_forces,'String',['F=',num2str(tfm_para_user_para_DeltaF{tfm_para_user_counter},'%.2e'),' [N]']);
    elseif get(h_para(1).radiobutton_forcex,'Value') %fx
        %set correct plot
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fxmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(tfm_para_user_Fxmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %set correct text
        set(h_para(1).text_forces,'String',['Fx=',num2str(tfm_para_user_para_DeltaFx{tfm_para_user_counter},'%.2e'),' [N]']);
    elseif get(h_para(1).radiobutton_forcey,'Value') %fy
        %set correct plot
        cla(h_para(1).axes_forces)
        axes(h_para(1).axes_forces)
        plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
        plot(tfm_para_user_Fymax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
        plot(tfm_para_user_Fymin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %set correct text
        set(h_para(1).text_forces,'String',['Fy=',num2str(tfm_para_user_para_DeltaFy{tfm_para_user_counter},'%.2e'),' [N]']);
    end
    
    %power
    cla(h_para(1).axes_power)
    axes(h_para(1).axes_power)
    plot(dt{tfm_para_user_counter},zeros(1,length(dt{tfm_para_user_counter})),'--k'), hold on;
    plot(dt{tfm_para_user_counter},tfm_para_user_power{tfm_para_user_counter}*1e12,'-b'), hold on;
    plot(tfm_para_user_Pmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmin{tfm_para_user_counter}(:,2)*1e12,'.r'), hold on;
    plot(tfm_para_user_Pmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Pmax{tfm_para_user_counter}(:,2)*1e12,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %freq.
    if get(h_para(1).radiobutton_fft,'Value')
        %make unwanted buttons invisible
        set(h_para(1).button_freq_add,'Visible','off');
        set(h_para(1).button_freq_remove,'Visible','off');
        set(h_para(1).button_freq_clearall,'Visible','off');
        %enable wanted button
        set(h_para(1).button_freq_addfft,'Visible','on');
        %plot frequency. in axes
        x=tfm_para_user_para_freq{tfm_para_user_counter};
        y=tfm_para_user_para_freqy{tfm_para_user_counter};
        cla(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(freq{tfm_para_user_counter},y_fft{tfm_para_user_counter},'-b'), hold on;
        plot(x,y,'.g')
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %para
        set(h_para(1).text_freq1,'String',['f=',num2str(x,'%.2e'),' [Hz]']);
        set(h_para(1).text_freq2,'String',['T=',num2str(1/(x+eps),'%.2e'),' [s]']);
    elseif get(h_para(1).radiobutton_pick,'Value')
        %make  buttons visible
        set(h_para(1).button_freq_add,'Visible','on');
        set(h_para(1).button_freq_remove,'Visible','on');
        set(h_para(1).button_freq_clearall,'Visible','on');
        %disable unwanted button
        set(h_para(1).button_freq_addfft,'Visible','off');
        %plot displ. in axes
        t_new=tfm_para_user_freq2{tfm_para_user_counter};
        x=1/(tfm_para_user_para_freq2{tfm_para_user_counter}+eps);
        cla(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
        %plot delta t
        dtcontr=zeros(1,size(t_new,1));
        cmap = hsv(size(t_new,1));
        for i=1:size(t_new,1)
            plot(t_new(i,1),t_new(i,3)*1e6,'.','Color',cmap(i,:))
            plot(t_new(i,2),t_new(i,4)*1e6,'.','Color',cmap(i,:))
            dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
            plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'Color',cmap(i,:),'LineWidth',5)
        end
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        %para
        set(h_para(1).text_freq1,'String',['f=',num2str(1/(x+eps),'%.2e'),' [Hz]']);
        set(h_para(1).text_freq2,'String',['T=',num2str(x,'%.2e'),' [s]']);
    end
    
    %displaz para
    %diplay
    set(h_para(1).text_disp,'String',['dcontr=',num2str(tfm_para_user_para_Deltad{tfm_para_user_counter},'%.2e'),' [m]']);
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(tfm_para_user_para_vcontr{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(tfm_para_user_para_vrelax{tfm_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_dp2_2,'String',['t=',num2str(tfm_para_user_para_tdp{tfm_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_contr,'String',['tcontr=',num2str(tfm_para_user_para_tcontr{tfm_para_user_counter},'%.2e'),' [s]']);  
    set(h_para(1).text_power1,'String',['Pcontr=',num2str(tfm_para_user_para_Pcontr{tfm_para_user_counter},'%.2e'),' [W]']);
    set(h_para(1).text_power2,'String',['Prelax=',num2str(tfm_para_user_para_Prelax{tfm_para_user_counter},'%.2e'),' [W]']);
    
    %set texts to 1st vid
    set(h_para(1).text_whichvidname,'String',tfm_init_user_filenamestack{1,tfm_para_user_counter});
    set(h_para(1).text_whichvid,'String',[num2str(tfm_para_user_counter),'/',num2str(tfm_init_user_Nfiles)]);
    
    
    %forward /backbutton
    if tfm_para_user_counter==1
        set(h_para(1).button_backwards,'Enable','off');
    else
        set(h_para(1).button_backwards,'Enable','on');
    end
    if tfm_para_user_counter==tfm_init_user_Nfiles
        set(h_para(1).button_forwards,'Enable','off');
    else
        set(h_para(1).button_forwards,'Enable','on');
    end
    
    %shared data
    setappdata(0,'tfm_para_user_para_ratiop',tfm_para_user_para_ratiop);
    setappdata(0,'tfm_para_user_para_ratiodp',tfm_para_user_para_ratiodp);
    setappdata(0,'tfm_para_user_counter',tfm_para_user_counter);
    
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function para_push_ok(hObject, eventdata, h_para, h_main)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
%clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%save stuff
%load what shared para we need
tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
tfm_init_user_Nframes=getappdata(0,'tfm_init_user_Nframes');
tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
tfm_init_user_pathnamestack=getappdata(0,'tfm_init_user_pathnamestack');
tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
tfm_para_user_para_ratiop=getappdata(0,'tfm_para_user_para_ratiop');
tfm_para_user_para_Deltad=getappdata(0,'tfm_para_user_para_Deltad');
tfm_para_user_para_vrelax=getappdata(0,'tfm_para_user_para_vrelax');
tfm_para_user_para_vcontr=getappdata(0,'tfm_para_user_para_vcontr');
tfm_para_user_para_tcontr=getappdata(0,'tfm_para_user_para_tcontr');
tfm_para_user_para_freq=getappdata(0,'tfm_para_user_para_freq');
tfm_para_user_para_freq2=getappdata(0,'tfm_para_user_para_freq2');
tfm_para_user_para_tag=getappdata(0,'tfm_para_user_para_tag');
tfm_para_user_para_tagdp=getappdata(0,'tfm_para_user_para_tagdp');
tfm_para_user_para_ratiodp=getappdata(0,'tfm_para_user_para_ratiodp');
tfm_para_user_para_tdp=getappdata(0,'tfm_para_user_para_tdp');
tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
tfm_para_user_d=getappdata(0,'tfm_para_user_d');
tfm_para_user_velocity=getappdata(0,'tfm_para_user_velocity');
tfm_para_user_para_DeltaFx=getappdata(0,'tfm_para_user_para_DeltaFx');
tfm_para_user_para_DeltaFy=getappdata(0,'tfm_para_user_para_DeltaFy');
tfm_para_user_para_DeltaF=getappdata(0,'tfm_para_user_para_DeltaF');
tfm_para_user_para_Prelax=getappdata(0,'tfm_para_user_para_Prelax');
tfm_para_user_para_Pcontr=getappdata(0,'tfm_para_user_para_Pcontr');
tfm_para_user_power=getappdata(0,'tfm_para_user_power');
tfm_para_user_F_tot=getappdata(0,'tfm_para_user_F_tot');
tfm_para_user_Fx_tot=getappdata(0,'tfm_para_user_Fx_tot');
tfm_para_user_Fy_tot=getappdata(0,'tfm_para_user_Fy_tot');

%save current stuff
tfm_para_user_para_ratiop{tfm_para_user_counter}=str2double(get(h_para(1).edit_ratio,'String'));
if tfm_para_user_para_tagdp{tfm_para_user_counter}
tfm_para_user_para_ratiodp{tfm_para_user_counter}=str2double(get(h_para(1).edit_dp2,'String'));
end 

%save para to excel
%loop over videos
for ivid=1:tfm_init_user_Nfiles
    %waitbar
    sb=statusbar(h_para(1).fig,['Saving parameters... ',num2str(floor(100*(ivid-1)/sum(tfm_init_user_Nfiles))), '%% done']);
    sb.getComponent(0).setForeground(java.awt.Color.red);
    %
    newfile=[tfm_init_user_pathnamestack{1,ivid},'/',tfm_init_user_filenamestack{1,ivid},'/Results/',tfm_init_user_filenamestack{1,ivid},'.xls'];
    A = {tfm_para_user_para_ratiop{ivid},tfm_para_user_para_Deltad{ivid},tfm_para_user_para_vrelax{ivid},tfm_para_user_para_vcontr{ivid}...
        tfm_para_user_para_tcontr{ivid},tfm_para_user_para_freq{ivid},tfm_para_user_para_freq2{ivid},tfm_para_user_para_DeltaFx{ivid},tfm_para_user_para_DeltaFy{ivid}...
        tfm_para_user_para_DeltaF{ivid},tfm_para_user_para_Prelax{ivid},tfm_para_user_para_Pcontr{ivid},tfm_para_user_para_tag{ivid}...
        tfm_para_user_para_tagdp{ivid},tfm_para_user_para_ratiodp{ivid},tfm_para_user_para_tdp{ivid}};
    sheet = 'Parameters';
    xlRange = 'A3';
    xlwrite(newfile,A,sheet,xlRange)
       
end

%statusbar
sb=statusbar(h_para(1).fig,'Saving - Done !');
sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));

%save curve data
%loop over videos
for ivid=1:tfm_init_user_Nfiles
    
    %waitbar
    sb=statusbar(h_para(1).fig,['Saving curve data... ',num2str(floor(100*(ivid-1)/sum(tfm_init_user_Nfiles))), '%% done']);
    sb.getComponent(0).setForeground(java.awt.Color.red);
    
    %file and sheet
    newfile=[tfm_init_user_pathnamestack{1,ivid},'/',tfm_init_user_filenamestack{1,ivid},'/Results/',tfm_init_user_filenamestack{1,ivid},'.xls'];
    sheet = 'Curves';
    %loop over time pts
    for ifr=1:tfm_init_user_Nframes{ivid}
        %displ.
        A = {tfm_para_user_dt{ivid}(ifr),tfm_para_user_d{ivid}(ifr)};
        xlRange = ['A',num2str(2+ifr)];
        xlwrite(newfile,A,sheet,xlRange)
        %veloc
        A = {tfm_para_user_dt{ivid}(ifr),tfm_para_user_velocity{ivid}(ifr)};
        xlRange = ['D',num2str(2+ifr)];
        xlwrite(newfile,A,sheet,xlRange)
        %forces
        A = {tfm_para_user_dt{ivid}(ifr),tfm_para_user_Fx_tot{ivid}(ifr),tfm_para_user_Fy_tot{ivid}(ifr),tfm_para_user_F_tot{ivid}(ifr)};
        xlRange = ['G',num2str(2+ifr)];
        xlwrite(newfile,A,sheet,xlRange)
        %power
        A = {tfm_para_user_dt{ivid}(ifr),tfm_para_user_power{ivid}(ifr)};
        xlRange = ['L',num2str(2+ifr)];
        xlwrite(newfile,A,sheet,xlRange)
    end
    
end
%statusbar
sb=statusbar(h_para(1).fig,'Saving - Done !');
sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));


%check if user wants to save plotsa
value = get(h_para(1).checkbox_save, 'Value');

if value
    %loop over videos
    for ivid=1:tfm_init_user_Nfiles
        if isequal(exist([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots'], 'dir'),7)
            rmdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots'],'s')
        end
        %make output folder for displacements
        mkdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots'])
        
        %waitbar
        sb=statusbar(h_para(1).fig,['Saving curve plots... ',num2str(floor(100*(ivid-1)/sum(tfm_init_user_Nfiles))), '%% done']);
        sb.getComponent(0).setForeground(java.awt.Color.red);
        
        %d
        sh=figure('Visible','off');
        plot(tfm_para_user_dt{ivid},tfm_para_user_d{ivid})
        title('Displacement')
        xlabel('Time [s]')
        ylabel('Average displacement [m]')
        savefig([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/displacement']);
        export_fig([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/displacement'],'-png','-m2',sh);
        close(sh);
        %vel
        sh=figure('Visible','off');
        plot(tfm_para_user_dt{ivid},tfm_para_user_velocity{ivid})
        title('Velocity')
        xlabel('Time [s]')
        ylabel('Velocity [m/s]')
        savefig([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/velocity']);
        export_fig([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/velocity'],'-png','-m2',sh);
        close(sh);
        %forces
        sh=figure('Visible','off');
        plot(tfm_para_user_dt{ivid},tfm_para_user_Fx_tot{ivid},'b'), hold on;
        plot(tfm_para_user_dt{ivid},tfm_para_user_Fy_tot{ivid},'r'), hold on;
        plot(tfm_para_user_dt{ivid},tfm_para_user_F_tot{ivid},'g'), hold on;
        legend('|Fx|','|Fy|','|F|')
        title('Forces')
        xlabel('Time [s]')
        ylabel('Forces [N]')
        savefig([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/forces']);
        export_fig([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/forces'],'-png','-m2',sh);
        close(sh);
        %power
        sh=figure('Visible','off');
        plot(tfm_para_user_dt{ivid},tfm_para_user_power{ivid})
        title('Power')
        xlabel('Time [s]')
        ylabel('Power [W]')
        savefig([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/power']);
        export_fig([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/power'],'-png','-m2',sh);
        close(sh);
    end
    %statusbar
    sb=statusbar(h_para(1).fig,'Saving - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
end

catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

%enable
enableDisableFig(h_para(1).fig,1)

%change main windows 3. button status
set(h_main(1).button_para,'ForegroundColor',[0 .5 0]);

%close window
close(h_para(1).fig);

function para_buttongroup_freq(hObject, eventdata, h_para)
%load shared needed para
tfm_para_user_d=getappdata(0,'tfm_para_user_d');
tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
freq=getappdata(0,'tfm_para_user_freq');
y_fft=getappdata(0,'tfm_para_user_y_fft');
dt=getappdata(0,'tfm_para_user_dt');
tfm_para_user_para_freq=getappdata(0,'tfm_para_user_para_freq');
tfm_para_user_para_freqy=getappdata(0,'tfm_para_user_para_freqy');
tfm_para_user_freq2=getappdata(0,'tfm_para_user_freq2');
tfm_para_user_para_freq2=getappdata(0,'tfm_para_user_para_freq2');

if get(h_para(1).radiobutton_fft,'Value')
    %make unwanted buttons invisible
    set(h_para(1).button_freq_add,'Visible','off');
    set(h_para(1).button_freq_remove,'Visible','off');
    set(h_para(1).button_freq_clearall,'Visible','off');
    %enable wanted button
    set(h_para(1).button_freq_addfft,'Visible','on');
    %plot frequency. in axes
    x=tfm_para_user_para_freq{tfm_para_user_counter};
    y=tfm_para_user_para_freqy{tfm_para_user_counter};
    cla(h_para(1).axes_freq)
    axes(h_para(1).axes_freq)
    plot(freq{tfm_para_user_counter},y_fft{tfm_para_user_counter},'-b'), hold on;
    plot(x,y,'.g')
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %set correct strings
    set(h_para(1).text_freq1,'String',['f=',num2str(x,'%.2e'),' [Hz]']);
    set(h_para(1).text_freq2,'String',['T=',num2str(1/(x+eps),'%.2e'),' [s]']);
elseif get(h_para(1).radiobutton_pick,'Value')
    %make  buttons visible
    set(h_para(1).button_freq_add,'Visible','on');
    set(h_para(1).button_freq_remove,'Visible','on');
    set(h_para(1).button_freq_clearall,'Visible','on');
    %disable unwanted button
    set(h_para(1).button_freq_addfft,'Visible','off');
    %plot displ. in axes
    t_new=tfm_para_user_freq2{tfm_para_user_counter};
    x2=1/(tfm_para_user_para_freq2{tfm_para_user_counter}+eps);
    
    cla(h_para(1).axes_freq)
    axes(h_para(1).axes_freq)
    plot(dt{tfm_para_user_counter},tfm_para_user_d{tfm_para_user_counter}*1e6,'-b'), hold on;
    %plot delta t
    dtcontr=zeros(1,size(t_new,1));
    cmap = hsv(size(t_new,1));
    for i=1:size(t_new,1)
        plot(t_new(i,1),t_new(i,3),'.','Color',cmap(i,:))
        plot(t_new(i,2),t_new(i,4),'.','Color',cmap(i,:))
        dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
        plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'Color',cmap(i,:),'LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %set correct strings
    set(h_para(1).text_freq1,'String',['f=',num2str(1/(x2+eps),'%.2e'),' [Hz]']);
    set(h_para(1).text_freq2,'String',['T=',num2str(x2,'%.2e'),' [s]']);
    
end

function para_buttongroup_forces(hObject, eventdata, h_para)

if get(h_para(1).radiobutton_forcetot,'Value') %ftot
    %load
    tfm_para_user_Fmax=getappdata(0,'tfm_para_user_Fmax');
    tfm_para_user_Fmin=getappdata(0,'tfm_para_user_Fmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_F_tot=getappdata(0,'tfm_para_user_F_tot');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_DeltaF=getappdata(0,'tfm_para_user_para_DeltaF');
    %set correct plot
    cla(h_para(1).axes_forces)
    axes(h_para(1).axes_forces)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_F_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
    plot(tfm_para_user_Fmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
    plot(tfm_para_user_Fmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %set correct text
    set(h_para(1).text_forces,'String',['F=',num2str(tfm_para_user_para_DeltaF{tfm_para_user_counter},'%.2e'),' [N]']);
elseif get(h_para(1).radiobutton_forcex,'Value') %fx
    %load
    tfm_para_user_Fxmax=getappdata(0,'tfm_para_user_Fxmax');
    tfm_para_user_Fxmin=getappdata(0,'tfm_para_user_Fxmin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_Fx_tot=getappdata(0,'tfm_para_user_Fx_tot');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_DeltaFx=getappdata(0,'tfm_para_user_para_DeltaFx');
    %set correct plot
    cla(h_para(1).axes_forces)
    axes(h_para(1).axes_forces)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fx_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
    plot(tfm_para_user_Fxmax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
    plot(tfm_para_user_Fxmin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fxmin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %set correct text
    set(h_para(1).text_forces,'String',['Fx=',num2str(tfm_para_user_para_DeltaFx{tfm_para_user_counter},'%.2e'),' [N]']);
elseif get(h_para(1).radiobutton_forcey,'Value') %fy
    %load
    tfm_para_user_Fymax=getappdata(0,'tfm_para_user_Fymax');
    tfm_para_user_Fymin=getappdata(0,'tfm_para_user_Fymin');
    tfm_para_user_dt=getappdata(0,'tfm_para_user_dt');
    tfm_para_user_Fy_tot=getappdata(0,'tfm_para_user_Fy_tot');
    tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');
    tfm_init_user_framerate=getappdata(0,'tfm_init_user_framerate');
    tfm_para_user_para_DeltaFy=getappdata(0,'tfm_para_user_para_DeltaFy');
    %set correct plot
    cla(h_para(1).axes_forces)
    axes(h_para(1).axes_forces)
    plot(tfm_para_user_dt{tfm_para_user_counter},tfm_para_user_Fy_tot{tfm_para_user_counter}*1e9,'-b'), hold on;
    plot(tfm_para_user_Fymax{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymax{tfm_para_user_counter}(:,2)*1e9,'.g'), hold on;
    plot(tfm_para_user_Fymin{tfm_para_user_counter}(:,1)/tfm_init_user_framerate{tfm_para_user_counter},tfm_para_user_Fymin{tfm_para_user_counter}(:,2)*1e9,'.r'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %set correct text
    set(h_para(1).text_forces,'String',['Fy=',num2str(tfm_para_user_para_DeltaFy{tfm_para_user_counter},'%.2e'),' [N]']);    
end

function para_checkbox_dpyes(hObject, eventdata, h_para)
set(h_para(1).panel_dp2,'Visible','on');
set(h_para(1).checkbox_dpno,'Value',0);

tfm_para_user_para_tagdp=getappdata(0,'tfm_para_user_para_tagdp');
tfm_para_user_para_ratiodp=getappdata(0,'tfm_para_user_para_ratiodp');
tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');

%yes: tag dp
if get(h_para(1).checkbox_dpyes,'Value');
    tfm_para_user_para_tagdp{tfm_para_user_counter}=1;
else
    tfm_para_user_para_tagdp{tfm_para_user_counter}=0;
end
set(h_para(1).edit_dp2,'String',num2str(tfm_para_user_para_ratiodp{tfm_para_user_counter}))
setappdata(0,'tfm_para_user_para_tagdp',tfm_para_user_para_tagdp);

function para_checkbox_dpno(hObject, eventdata, h_para)
set(h_para(1).panel_dp2,'Visible','off');
set(h_para(1).checkbox_dpyes,'Value',0);

tfm_para_user_para_tagdp=getappdata(0,'tfm_para_user_para_tagdp');
tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');

%yes: tag dp
if ~get(h_para(1).checkbox_dpno,'Value');
    tfm_para_user_para_tagdp{tfm_para_user_counter}=1;
else
    tfm_para_user_para_tagdp{tfm_para_user_counter}=0;
end
setappdata(0,'tfm_para_user_para_tagdp',tfm_para_user_para_tagdp);

function para_checkbox_tag(hObject, eventdata, h_para)
tfm_para_user_para_tag=getappdata(0,'tfm_para_user_para_tag');
tfm_para_user_counter=getappdata(0,'tfm_para_user_counter');

%yes: tag dp
if get(h_para(1).checkbox_tag,'Value');
    tfm_para_user_para_tag{tfm_para_user_counter}=1;
else
    tfm_para_user_para_tag{tfm_para_user_counter}=0;
end
setappdata(0,'tfm_para_user_para_tag',tfm_para_user_para_tag);
