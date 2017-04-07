%lifeact_para.m ; part of the Lifeact GUI: execute lifeact_main.m
%version 2.0.1
%written by O. Schwab (oschwab@stanford.edu)
%last change: 01/04/15

function lifeact_para(h_main)
%main function for the parameter window of lifeact gui

%create new window for parameter
%fig size
figsize=[650,1270];
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
    'Name','Lifeact Parameters',...
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

%uipanel for mean sarco
h_para(1).panel_meansarco = uipanel('Parent',h_para(1).fig,'Title','Mean sarcomere lengths','units','pixels','Position',[330,400,300,180]);
%axes
h_para(1).axes_meansarco = axes('Parent',h_para(1).panel_meansarco,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%button: addmax
h_para(1).button_meansarco_addmax = uicontrol('Parent',h_para(1).panel_meansarco,'style','pushbutton','position',[5,25,70,20],'string','Add max');
%button: removemax
h_para(1).button_meansarco_removemax = uicontrol('Parent',h_para(1).panel_meansarco,'style','pushbutton','position',[5,5,70,20],'string','Remove max');
%button: addmin
h_para(1).button_meansarco_addmin = uicontrol('Parent',h_para(1).panel_meansarco,'style','pushbutton','position',[75,25,70,20],'string','Add min');
%button: removemin
h_para(1).button_meansarco_removemin = uicontrol('Parent',h_para(1).panel_meansarco,'style','pushbutton','position',[75,5,70,20],'string','Remove min');
%button: clearall
h_para(1).button_meansarco_clearall = uicontrol('Parent',h_para(1).panel_meansarco,'style','pushbutton','position',[145,5,35,40],'string','Clear');
%text: means
h_para(1).text_meansarco1 = uicontrol('Parent',h_para(1).panel_meansarco,'style','text','position',[185,25,110,15],'HorizontalAlignment','left','string','mean = ');
%text: shortening
h_para(1).text_meansarco2 = uicontrol('Parent',h_para(1).panel_meansarco,'style','text','position',[185,5,110,15],'HorizontalAlignment','left','string','short = ');

%uipanel for std sarco
h_para(1).panel_stdsarco = uipanel('Parent',h_para(1).fig,'Title','Deviation sarcomere lengths','units','pixels','Position',[330,215,300,180]);
%axes
h_para(1).axes_stdsarco = axes('Parent',h_para(1).panel_stdsarco,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%text
h_para(1).text_stdsarco = uicontrol('Parent',h_para(1).panel_stdsarco,'style','text','position',[5,20,290,15],'HorizontalAlignment','left','string','mean deviation of sarcomeres = ');

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

%uipanel for myofibril orientations
h_para(1).panel_orient = uipanel('Parent',h_para(1).fig,'Title','Myofibril orientations','units','pixels','Position',[640,400,300,180]);
%axes
h_para(1).axes_orient = axes('Parent',h_para(1).panel_orient,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%text
h_para(1).text_orient = uicontrol('Parent',h_para(1).panel_orient,'style','text','position',[5,20,290,15],'HorizontalAlignment','left','string','mean deviation of orientations = ');

%uipanel for angle synchroniity
h_para(1).panel_stdangle = uipanel('Parent',h_para(1).fig,'Title','Movement synchronicty: spacial','units','pixels','Position',[640,215,300,180]);
%axes
h_para(1).axes_stdangle = axes('Parent',h_para(1).panel_stdangle,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%text
h_para(1).text_stdangle = uicontrol('Parent',h_para(1).panel_stdangle,'style','text','position',[5,20,290,15],'HorizontalAlignment','left','string','mean deviation of movement angles = ');

%uipanel for delta
h_para(1).panel_delta = uipanel('Parent',h_para(1).fig,'Title','Movement synchronicity: temporal','units','pixels','Position',[640,30,300,180]);
%axes
h_para(1).axes_delta = axes('Parent',h_para(1).panel_delta,'Units', 'pixels','Position',[5,50,287,115],'box','on');
%radiobutton group for user eval
h_para(1).buttongroup_delta = uibuttongroup('Parent',h_para(1).panel_delta,'Units', 'pixels','Position',[5,5,140,40]);
%radiobutton 1: heatmap
h_para(1).radiobutton_heatmap = uicontrol('Parent',h_para(1).buttongroup_delta,'style','radiobutton','position',[5,20,130,15],'string','Offset heatmap','tag','radiobutton_heatmap');
%radiobutton 1: histogram
h_para(1).radiobutton_histogram = uicontrol('Parent',h_para(1).buttongroup_delta,'style','radiobutton','position',[5,5,130,15],'string','Offset histogram','tag','radiobutton_histogram');
%text: mean
h_para(1).text_delta1 = uicontrol('Parent',h_para(1).panel_delta,'style','text','position',[150,25,110,15],'HorizontalAlignment','left','string','mean = ');
%text: std
h_para(1).text_delta2 = uicontrol('Parent',h_para(1).panel_delta,'style','text','position',[150,5,110,15],'HorizontalAlignment','left','string','std = ');

%uipanel for double peaks
h_para(1).panel_dp = uipanel('Parent',h_para(1).fig,'Title','Double peaks','units','pixels','Position',[950,400,300,240]);
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
h_para(1).panel_preview = uipanel('Parent',h_para(1).fig,'Title','Preview of current outline','units','pixels','Position',[950,215,300,180]);
%axes
h_para(1).axes_preview = axes('Parent',h_para(1).panel_preview,'Units', 'pixels','Position',[5,5,287,160],'box','on');

%uipanel for concentration
h_para(1).panel_conc = uipanel('Parent',h_para(1).fig,'Title','Ratio of cell occupied by myofibrils','units','pixels','Position',[330,590,300,50]);
%text
h_para(1).text_conc = uicontrol('Parent',h_para(1).panel_conc,'style','text','position',[5,5,287,20],'string','Concentration = ','HorizontalAlignment','left');

%uipanel for arrythmia
h_para(1).panel_tag = uipanel('Parent',h_para(1).fig,'Title','Arrhythmia','units','pixels','Position',[640,590,300,50]);
%checkbox
h_para(1).checkbox_tag = uicontrol('Parent',h_para(1).panel_tag,'style','checkbox','position',[5,5,287,25],'string','Tag if not useful for further analysis','HorizontalAlignment','left');

%button: forwards
h_para(1).button_forwards = uicontrol('Parent',h_para(1).fig,'style','pushbutton','position',[975,177,25,25],'string','>');
%button: backwards
h_para(1).button_backwards = uicontrol('Parent',h_para(1).fig,'style','pushbutton','position',[950,177,25,25],'string','<');
%text: show which video (i/n)
h_para(1).text_whichvid = uicontrol('Parent',h_para(1).fig,'style','text','position',[1005,185,25,15],'string','(1/1)','HorizontalAlignment','left');
%text: show which video (name)
h_para(1).text_whichvidname = uicontrol('Parent',h_para(1).fig,'style','text','position',[950,160,100,15],'string','Experiment','HorizontalAlignment','left');

%create ok button
h_para(1).button_ok = uicontrol('Parent',h_para(1).fig,'style','pushbutton','position',[1200,25,45,20],'string','OK','visible','on');
%create save checkbox
h_para(1).checkbox_save = uicontrol('Parent',h_para(1).fig,'style','checkbox','position',[950,30,150,15],'string','Save plots {.fig,.png}','HorizontalAlignment','left');

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
set(h_para(1).button_meansarco_addmax,'callback',{@para_push_meansarco_addmax,h_para})
set(h_para(1).button_meansarco_addmin,'callback',{@para_push_meansarco_addmin,h_para})
set(h_para(1).button_meansarco_removemax,'callback',{@para_push_meansarco_removemax,h_para})
set(h_para(1).button_meansarco_removemin,'callback',{@para_push_meansarco_removemin,h_para})
set(h_para(1).button_meansarco_clearall,'callback',{@para_push_meansarco_clearall,h_para})
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
set(h_para(1).buttongroup_delta,'SelectionChangeFcn',{@para_buttongroup_delta,h_para})
set(h_para(1).checkbox_dpyes,'callback',{@para_checkbox_dpyes,h_para})
set(h_para(1).checkbox_dpno,'callback',{@para_checkbox_dpno,h_para})
set(h_para(1).checkbox_tag,'callback',{@para_checkbox_tag,h_para})

%prelimiary stuff
%hide and disable buttons and panels
set(h_para(1).panel_disp,'Visible','off');
set(h_para(1).panel_ratio,'Visible','off');
set(h_para(1).panel_vel,'Visible','off');
set(h_para(1).panel_freq,'Visible','off');
set(h_para(1).panel_stdangle,'Visible','off');
set(h_para(1).panel_delta,'Visible','off');
set(h_para(1).panel_contr,'Visible','off');
set(h_para(1).panel_conc,'Visible','off');
set(h_para(1).panel_meansarco,'Visible','off');
set(h_para(1).panel_orient,'Visible','off');
set(h_para(1).panel_stdsarco,'Visible','off');
set(h_para(1).panel_dp,'Visible','off');
set(h_para(1).panel_tag,'Visible','off');
set(h_para(1).text_whichvidname,'Visible','off');
set(h_para(1).text_whichvid,'Visible','off');
set(h_para(1).button_ok,'Visible','off');
set(h_para(1).button_backwards,'Visible','off');
set(h_para(1).button_forwards,'Visible','off');
set(h_para(1).panel_preview,'Visible','off');
set(h_para(1).checkbox_save,'Visible','off');

%load what shared para we need
sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');

%total number of concs & rois: Nfiles*conc+?rois
sarco_para_user_totnum=sarco_init_user_Nfiles+sum(sarco_conc_user_number_roi);

%set texts to 1st vid
%set(h_para(1).text_whichvid,'String',sarco_init_user_filenamestack{1,1});
%set(h_para(1).text_freq2,'String',[num2str(1),'/',num2str(sarco_para_user_totnum)]);

%initiate counter
sarco_para_user_counter=1;

%store everything for shared use
setappdata(0,'sarco_para_user_counter',sarco_para_user_counter)
setappdata(0,'sarco_para_user_totnum',sarco_para_user_totnum)


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
    sarco_init_user_framerate=getappdata(0,'sarco_init_user_framerate');
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');
    sarco_piv_user_meand=getappdata(0,'sarco_piv_user_meand');
    sarco_piv_user_meand_roi=getappdata(0,'sarco_piv_user_meand_roi');
    sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
    sarco_conc_user_counter_roi=getappdata(0,'sarco_conc_user_counter_roi');
    sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');
    sarco_piv_user_delta=getappdata(0,'sarco_piv_user_delta');
    sarco_piv_user_meandelta=getappdata(0,'sarco_piv_user_meandelta');
    sarco_piv_user_stddelta=getappdata(0,'sarco_piv_user_stddelta');
    sarco_piv_user_meanalpha=getappdata(0,'sarco_piv_user_meanalpha');
    sarco_piv_user_stdalpha=getappdata(0,'sarco_piv_user_stdalpha');
    sarco_piv_user_delta_roi=getappdata(0,'sarco_piv_user_delta_roi');
    sarco_piv_user_meandelta_roi=getappdata(0,'sarco_piv_user_meandelta_roi');
    sarco_piv_user_stddelta_roi=getappdata(0,'sarco_piv_user_stddelta_roi');
    sarco_piv_user_meanalpha_roi=getappdata(0,'sarco_piv_user_meanalpha_roi');
    sarco_piv_user_stdalpha_roi=getappdata(0,'sarco_piv_user_stdalpha_roi');
    sarco_para_user_totnum=getappdata(0,'sarco_para_user_totnum');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_piv_user_relax=getappdata(0,'sarco_piv_user_relax');
    sarco_conc_user_outlinex=getappdata(0,'sarco_conc_user_outlinex');
    sarco_conc_user_outliney=getappdata(0,'sarco_conc_user_outliney');
    sarco_conc_user_outlinex_roi=getappdata(0,'sarco_conc_user_outlinex_roi');
    sarco_conc_user_outliney_roi=getappdata(0,'sarco_conc_user_outliney_roi');
    sarco_conc_user_binary1=getappdata(0,'sarco_conc_user_binary1');
    sarco_conc_user_areacell=getappdata(0,'sarco_conc_user_areacell');
    sarco_conc_user_areasarco=getappdata(0,'sarco_conc_user_areasarco');
    sarco_conc_user_areacell_roi=getappdata(0,'sarco_conc_user_areacell_roi');
    sarco_conc_user_areasarco_roi=getappdata(0,'sarco_conc_user_areasarco_roi');
    sarco_sarco_user_meansarco=getappdata(0,'sarco_sarco_user_meansarco');
    sarco_sarco_user_stdsarco=getappdata(0,'sarco_sarco_user_stdsarco');
    sarco_sarco_user_stdangles=getappdata(0,'sarco_sarco_user_stdangles');
    sarco_sarco_user_meansarco_roi=getappdata(0,'sarco_sarco_user_meansarco_roi');
    sarco_sarco_user_stdsarco_roi=getappdata(0,'sarco_sarco_user_stdsarco_roi');
    sarco_sarco_user_stdangles_roi=getappdata(0,'sarco_sarco_user_stdangles_roi');
    
    %initialize
    sarco_para_user_d=cell(1,sarco_para_user_totnum);
    sarco_para_user_framerate=cell(1,sarco_para_user_totnum);
    sarco_para_user_Nframes=cell(1,sarco_para_user_totnum);
    sarco_para_user_delta=cell(1,sarco_para_user_totnum);
    sarco_para_user_meanalpha=cell(1,sarco_para_user_totnum);
    sarco_para_user_meandelta=cell(1,sarco_para_user_totnum);
    sarco_para_user_stdalpha=cell(1,sarco_para_user_totnum);
    sarco_para_user_stddelta=cell(1,sarco_para_user_totnum);
    sarco_para_user_stdangles=cell(1,sarco_para_user_totnum);
    sarco_para_user_stdsarco=cell(1,sarco_para_user_totnum);
    sarco_para_user_meansarco=cell(1,sarco_para_user_totnum);
    sarco_para_user_filenamestack=cell(1,sarco_para_user_totnum);
    sarco_para_user_relax=cell(1,sarco_para_user_totnum);
    sarco_para_user_outlinex=cell(1,sarco_para_user_totnum);
    sarco_para_user_outliney=cell(1,sarco_para_user_totnum);
    sarco_para_user_mask=cell(1,sarco_para_user_totnum);
    sarco_para_user_concentration=cell(1,sarco_para_user_totnum);
    Velocity=cell(1,sarco_para_user_totnum);
    dmax=cell(1,sarco_para_user_totnum);
    dmin=cell(1,sarco_para_user_totnum);
    dt=cell(1,sarco_para_user_totnum);
    vmax=cell(1,sarco_para_user_totnum);
    vmin=cell(1,sarco_para_user_totnum);
    y_fft=cell(1,sarco_para_user_totnum);
    freq=cell(1,sarco_para_user_totnum);
    sarco_para_user_meansarco_min=cell(1,sarco_para_user_totnum);
    sarco_para_user_meansarco_max=cell(1,sarco_para_user_totnum);
    
    %put displacements in right form, framerate, nframes, meanalpha, stdalpha,
    %meandelta, stddelta, filenamestack
    roiadd=0;
    for current_vid=1:sarco_init_user_Nfiles
        sarco_para_user_d{current_vid+roiadd}=[sarco_piv_user_meand{current_vid,:}];
        sarco_para_user_framerate{current_vid+roiadd}=sarco_init_user_framerate{current_vid};
        sarco_para_user_Nframes{current_vid+roiadd}=sarco_init_user_Nframes{current_vid};
        sarco_para_user_meanalpha{current_vid+roiadd}=[sarco_piv_user_meanalpha{current_vid,:}];
        sarco_para_user_meandelta{current_vid+roiadd}=[sarco_piv_user_meandelta{current_vid,:}];
        sarco_para_user_stdalpha{current_vid+roiadd}=[sarco_piv_user_stdalpha{current_vid,:}];
        sarco_para_user_stddelta{current_vid+roiadd}=[sarco_piv_user_stddelta{current_vid,:}];
        sarco_para_user_stdangles{current_vid+roiadd}=[sarco_sarco_user_stdangles{current_vid,:}];
        sarco_para_user_stdsarco{current_vid+roiadd}=[sarco_sarco_user_stdsarco{current_vid,:}]*1e-6;
        sarco_para_user_meansarco{current_vid+roiadd}=[sarco_sarco_user_meansarco{current_vid,:}];
        sarco_para_user_delta{current_vid+roiadd}=sarco_piv_user_delta{current_vid};
        sarco_para_user_filenamestack{current_vid+roiadd}=sarco_init_user_filenamestack{current_vid};
        sarco_para_user_relax{current_vid+roiadd}=sarco_piv_user_relax{current_vid};
        sarco_para_user_outlinex{current_vid+roiadd}=sarco_conc_user_outlinex{current_vid};
        sarco_para_user_outliney{current_vid+roiadd}=sarco_conc_user_outliney{current_vid};
        sarco_para_user_mask{current_vid+roiadd}=sarco_conc_user_binary1{current_vid};
        sarco_para_user_concentration{current_vid+roiadd}=sarco_conc_user_areasarco{current_vid}/(eps+sarco_conc_user_areacell{current_vid});
        
        if sarco_conc_user_counter_roi(current_vid)
            %loop over rois
            for roi=1:sarco_conc_user_number_roi(current_vid)
                sarco_para_user_d{current_vid+roiadd+roi}=[sarco_piv_user_meand_roi{current_vid,roi,:}];
                sarco_para_user_framerate{current_vid+roiadd+roi}=sarco_init_user_framerate{current_vid};
                sarco_para_user_Nframes{current_vid+roiadd+roi}=sarco_init_user_Nframes{current_vid};
                sarco_para_user_meanalpha{current_vid+roiadd+roi}=[sarco_piv_user_meanalpha_roi{current_vid,roi,:}];
                sarco_para_user_meandelta{current_vid+roiadd+roi}=[sarco_piv_user_meandelta_roi{current_vid,roi,:}];
                sarco_para_user_stdalpha{current_vid+roiadd+roi}=[sarco_piv_user_stdalpha_roi{current_vid,roi,:}];
                sarco_para_user_stddelta{current_vid+roiadd+roi}=[sarco_piv_user_stddelta_roi{current_vid,roi,:}];
                sarco_para_user_delta{current_vid+roiadd+roi}=sarco_piv_user_delta_roi{current_vid,roi,:};
                sarco_para_user_filenamestack{current_vid+roiadd+roi}=sarco_init_user_filenamestack{current_vid};
                sarco_para_user_relax{current_vid+roiadd+roi}=sarco_piv_user_relax{current_vid};
                sarco_para_user_outlinex{current_vid+roiadd+roi}=sarco_conc_user_outlinex_roi{roi,current_vid};
                sarco_para_user_outliney{current_vid+roiadd+roi}=sarco_conc_user_outliney_roi{roi,current_vid};
                sarco_para_user_mask{current_vid+roiadd+roi}=sarco_conc_user_binary1{current_vid};
                sarco_para_user_concentration{current_vid+roiadd+roi}=sarco_conc_user_areasarco_roi{roi,current_vid}/(eps+sarco_conc_user_areacell_roi{roi,current_vid});
                sarco_para_user_stdangles{current_vid+roiadd+roi}=[sarco_sarco_user_stdangles_roi{roi,current_vid,:}];
                sarco_para_user_stdsarco{current_vid+roiadd+roi}=[sarco_sarco_user_stdsarco_roi{roi,current_vid,:}]*1e-6;
                sarco_para_user_meansarco{current_vid+roiadd+roi}=[sarco_sarco_user_meansarco_roi{roi,current_vid,:}];
            end
            roiadd=roiadd+sarco_conc_user_number_roi(current_vid);
        end
    end
    
    %convert delta to sec.
    for current_vid=1:sarco_para_user_totnum
        sarco_para_user_meandelta{current_vid}=sarco_para_user_meandelta{current_vid}/sarco_para_user_framerate{current_vid};
        sarco_para_user_stddelta{current_vid}=sarco_para_user_stddelta{current_vid}/sarco_para_user_framerate{current_vid};
        sarco_para_user_delta{current_vid}=sarco_para_user_delta{current_vid}/sarco_para_user_framerate{current_vid};
    end
    
    
    %wavelet denoise d
    % for current_vid=1:sarco_para_user_totnum
    %     sarco_para_user_d{current_vid}=inpaint_nans(sarco_para_user_d{current_vid});
    %     [sarco_para_user_d{current_vid}, ~, ~] = wden(sarco_para_user_d{current_vid}, 'minimaxi', 's', 'sln', 2, 'db5');
    % end
    
    
    %calculate velocity
    for current_vid=1:sarco_para_user_totnum
        Velocity{current_vid}=zeros(1,sarco_para_user_Nframes{current_vid})*NaN;
        for frame=2:sarco_para_user_Nframes{current_vid}-1
            %velocities
            D1=sarco_para_user_d{current_vid}(frame-1);
            D2=sarco_para_user_d{current_vid}(frame+1);
            Velocity{current_vid}(frame)=(D2-D1)/2*sarco_para_user_framerate{current_vid};
        end
        
        %     Velocity{current_vid}=inpaint_nans(Velocity{current_vid});
        %     [Velocity{current_vid}, ~, ~] = wden(Velocity{current_vid}, 'minimaxi', 's', 'sln', 2, 'db5');
    end
    
    %guess peaks for displ./veloc/meansarco
    for current_vid=1:sarco_para_user_totnum
        %guess max/min. displ.
        [dmax{current_vid}, dmin{current_vid}] = peakdet(sarco_para_user_d{current_vid}, 0.5*(max(sarco_para_user_d{current_vid})-min(sarco_para_user_d{current_vid})));
        dt{current_vid}=(1:length(sarco_para_user_d{current_vid}))/sarco_para_user_framerate{current_vid};
        
        %veloc.
        [vmax{current_vid}, vmin{current_vid}] = peakdet(Velocity{current_vid}, 0.5*(max(Velocity{current_vid})-min(Velocity{current_vid})));
        
        %sarcomean min max
        [sarco_para_user_meansarco_max{current_vid}, sarco_para_user_meansarco_min{current_vid}] = peakdet(sarco_para_user_meansarco{current_vid}, 0.5*(max(sarco_para_user_meansarco{current_vid})-min(sarco_para_user_meansarco{current_vid})));
        
        %init
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
        if isempty(sarco_para_user_meansarco_min{current_vid})
            sarco_para_user_meansarco_min{current_vid}(:,1)=NaN; sarco_para_user_meansarco_min{current_vid}(:,2)=NaN;
        end
        if isempty(sarco_para_user_meansarco_max{current_vid})
            sarco_para_user_meansarco_max{current_vid}(:,1)=NaN; sarco_para_user_meansarco_max{current_vid}(:,2)=NaN;
        end
    end
    
    %frequency
    for current_vid=1:sarco_para_user_totnum
        %dt, sarco_para_user_d{current_vid}
        Nsamps = length(dt{current_vid});
        Fs=sarco_para_user_framerate{current_vid};
        %t = (1/Fs)*(1:Nsamps);
        %Do Fourier Transform
        y=sarco_para_user_d{current_vid};
        y(isnan(y))=0;
        y_fft0 = abs(fft(y));            %Retain Magnitude
        y_fft{current_vid} = y_fft0(1:ceil(Nsamps/2));      %Discard Half of Points
        freq{current_vid} = Fs*(0:ceil(Nsamps/2)-1)/Nsamps;   %Prepare freq data for plot
    end
    
    %plot 1st displ. in axes
    cla(h_para(1).axes_disp)
    axes(h_para(1).axes_disp)
    plot(dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(dmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},dmin{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(dmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},dmax{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %displ. in double peak
    cla(h_para(1).axes_dp2)
    axes(h_para(1).axes_dp2)
    plot(dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %plot 1st velocity. in axes
    cla(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(dt{sarco_para_user_counter},zeros(1,length(dt{sarco_para_user_counter})),'--k'), hold on;
    plot(dt{sarco_para_user_counter},Velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(vmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},vmin{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(vmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},vmax{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %%plot 1st velocity. in axes
    cla(h_para(1).axes_contr)
    axes(h_para(1).axes_contr)
    plot(dt{sarco_para_user_counter},Velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %sarcomean plot
    %plot 1st displ. in axes
    cla(h_para(1).axes_meansarco)
    axes(h_para(1).axes_meansarco)
    plot(dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %preview
    cla(h_para(1).axes_preview)
    axes(h_para(1).axes_preview)
    s=load(['vars_DO_NOT_DELETE/',sarco_para_user_filenamestack{1,sarco_para_user_counter},'/image',num2str(sarco_para_user_relax{sarco_para_user_counter}),'.mat'],'imagei');
    image=s.imagei;
    imagesc(image); hold on;
    
    set(h_para(1).axes_preview,'xtick',[],'ytick',[])
    colormap('gray')
    freezeColors
    xp_s=sarco_para_user_outlinex{sarco_para_user_counter};
    yp_s=sarco_para_user_outliney{sarco_para_user_counter};
    plot([xp_s;xp_s(1)],[yp_s;yp_s(1)],'r')
    axis image;
    
    %for delta check radiobutton: does user want heatmap or histogram?
    if get(h_para(1).radiobutton_heatmap,'Value')
        %plot heatmaps
        reset(h_para(1).axes_delta)
        axes(h_para(1).axes_delta)
        imagesc(sarco_para_user_delta{sarco_para_user_counter}); hold on;
        colormap('jet')
        colorbar
        caxis([sarco_para_user_meandelta{sarco_para_user_counter}-2*sarco_para_user_stddelta{sarco_para_user_counter}, sarco_para_user_meandelta{sarco_para_user_counter}+2*sarco_para_user_stddelta{sarco_para_user_counter}])
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        drawnow;
    elseif get(h_para(1).radiobutton_histogram,'Value')
        reset(h_para(1).axes_delta)
        axes(h_para(1).axes_delta)
        bdelta_vec = subsref(sarco_para_user_delta{sarco_para_user_counter}.', substruct('()', {':'})).';
        bdelta_vec(isnan(bdelta_vec))=[];
        hist(bdelta_vec,length(bdelta_vec))
        set(h_para(1).axes_delta, 'YTick', []);
    end
    
    
    %std movement angle
    cla(h_para(1).axes_stdangle)
    axes(h_para(1).axes_stdangle)
    plot(dt{sarco_para_user_counter},sarco_para_user_stdalpha{sarco_para_user_counter},'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %std orientation angle
    cla(h_para(1).axes_orient)
    axes(h_para(1).axes_orient)
    plot(dt{sarco_para_user_counter},sarco_para_user_stdangles{sarco_para_user_counter},'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %std sarco lengths
    cla(h_para(1).axes_stdsarco)
    axes(h_para(1).axes_stdsarco)
    plot(dt{sarco_para_user_counter},sarco_para_user_stdsarco{sarco_para_user_counter}*1e6,'-b'), hold on;
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
        cla(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(freq{sarco_para_user_counter},y_fft{sarco_para_user_counter},'-b'), hold on;
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
        cla(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
    end
    
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
    sarco_para_user_para_Deltad=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_vcontr=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_vrelax=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_tcontr=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_tdp=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_freq=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_freqy=cell(1,sarco_para_user_totnum);
    sarco_para_user_tcontr=cell(1,sarco_para_user_totnum);
    sarco_para_user_tdp=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_ratiop=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_ratiodp=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_freq2=cell(1,sarco_para_user_totnum);
    sarco_para_user_freq2=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_tagdp=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_tag=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_meansarco_mean=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_meansarco_max=cell(1,sarco_para_user_totnum);
    sarco_para_user_para_meansarco_min=cell(1,sarco_para_user_totnum);
    
    %para
    for current_vid=1:sarco_para_user_totnum
        sarco_para_user_para_Deltad{current_vid}=nanmean(dmax{current_vid}(:,2))-nanmean(dmin{current_vid}(:,2));
        sarco_para_user_para_vcontr{current_vid}=nanmean(vmax{current_vid}(:,2));
        sarco_para_user_para_vrelax{current_vid}=nanmean(vmin{current_vid}(:,2));
        sarco_para_user_para_meansarco_max{current_vid}=nanmean(sarco_para_user_meansarco_max{current_vid}(:,2))*1e-6;
        sarco_para_user_para_meansarco_min{current_vid}=nanmean(sarco_para_user_meansarco_min{current_vid}(:,2))*1e-6;
        sarco_para_user_para_tcontr{current_vid}=NaN;
        sarco_para_user_para_tdp{current_vid}=NaN;
        sarco_para_user_para_freq{current_vid}=NaN;
        sarco_para_user_para_freqy{current_vid}=NaN;
        sarco_para_user_tcontr{current_vid}=t_init;
        sarco_para_user_tdp{current_vid}=t_dp;
        sarco_para_user_para_ratiop{current_vid}=NaN;
        sarco_para_user_para_ratiodp{current_vid}=NaN;
        sarco_para_user_para_freq2{current_vid}=NaN;
        sarco_para_user_freq2{current_vid}=t_init;
        sarco_para_user_para_tagdp{current_vid}=0;
        sarco_para_user_para_tag{current_vid}=0;
        sarco_para_user_para_meansarco_mean{current_vid}=nanmean([sarco_para_user_meansarco{current_vid}])*1e-6;
    end
    
    
    %diplay
    set(h_para(1).text_disp,'String',['dcontr=',num2str(sarco_para_user_para_Deltad{sarco_para_user_counter},'%.2e'),' [m]']);
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(sarco_para_user_para_vcontr{sarco_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(sarco_para_user_para_vrelax{sarco_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_dp2_2,'String',['t=',num2str(NaN,'%.2e'),' [s]']);
    set(h_para(1).text_contr,'String',['tcontr=',num2str(NaN,'%.2e'),' [s]']);
    set(h_para(1).text_freq1,'String',['f=',num2str(NaN,'%.2e'),' [Hz]']);
    set(h_para(1).text_freq2,'String',['T=',num2str(NaN,'%.2e'),' [s]']);
    set(h_para(1).text_delta1,'String',['mean delta=',num2str(sarco_para_user_meandelta{sarco_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_delta2,'String',['std delta=',num2str(sarco_para_user_stddelta{sarco_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_stdangle,'String',['mean of the std of movement angles =',num2str(nanmean(sarco_para_user_stdalpha{sarco_para_user_counter}),'%.2e'),' [deg]']);
    set(h_para(1).text_conc,'String',['concentration = ',num2str(sarco_para_user_concentration{sarco_para_user_counter})]);
    set(h_para(1).text_orient,'String',['mean of the std of orientation angles =',num2str(nanmean(sarco_para_user_stdangles{sarco_para_user_counter}),'%.2e'),' [deg]']);
    set(h_para(1).text_stdsarco,'String',['mean of the std of sarcomeres =',num2str(nanmean(sarco_para_user_stdsarco{sarco_para_user_counter}),'%.2e'),' [m]']);
    set(h_para(1).text_meansarco2,'String',['av. short. =',num2str(sarco_para_user_para_meansarco_max{sarco_para_user_counter}-sarco_para_user_para_meansarco_min{sarco_para_user_counter},'%.2e'),' [m]']);
    set(h_para(1).text_meansarco1,'String',['mean ms =',num2str(sarco_para_user_para_meansarco_mean{sarco_para_user_counter},'%.2e'),' [m]']);
    
    set(h_para(1).edit_ratio,'String',[num2str(NaN,'%.2e')]);
    set(h_para(1).edit_dp2,'String',[num2str(NaN,'%.2e')]);
    
    %set texts to 1st vid
    set(h_para(1).text_whichvidname,'String',sarco_init_user_filenamestack{1,1});
    set(h_para(1).text_whichvid,'String',[num2str(1),'/',num2str(sarco_para_user_totnum)]);
    
    %displaz and enable/disable buttons and panels
    set(h_para(1).panel_ratio,'Visible','on');
    set(h_para(1).panel_disp,'Visible','on');
    set(h_para(1).panel_vel,'Visible','on');
    set(h_para(1).panel_freq,'Visible','on');
    set(h_para(1).panel_stdangle,'Visible','on');
    set(h_para(1).panel_delta,'Visible','on');
    set(h_para(1).panel_contr,'Visible','on');
    set(h_para(1).panel_conc,'Visible','on');
    set(h_para(1).panel_stdsarco,'Visible','on');
    set(h_para(1).panel_orient,'Visible','on');
    set(h_para(1).panel_dp,'Visible','on');
    set(h_para(1).panel_meansarco,'Visible','on');
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
    if sarco_para_user_counter==1
        set(h_para(1).button_backwards,'Enable','off');
    else
        set(h_para(1).button_backwards,'Enable','on');
    end
    if sarco_para_user_counter==sarco_para_user_totnum
        set(h_para(1).button_forwards,'Enable','off');
    else
        set(h_para(1).button_forwards,'Enable','on');
    end
    
    
    %save for shared use
    setappdata(0,'sarco_para_user_d',sarco_para_user_d);
    setappdata(0,'sarco_para_user_framerate',sarco_para_user_framerate);
    setappdata(0,'sarco_para_user_Nframes',sarco_para_user_Nframes);
    setappdata(0,'sarco_para_user_meanalpha',sarco_para_user_meanalpha);
    setappdata(0,'sarco_para_user_meandelta',sarco_para_user_meandelta);
    setappdata(0,'sarco_para_user_stdalpha',sarco_para_user_stdalpha);
    setappdata(0,'sarco_para_user_stddelta',sarco_para_user_stddelta);
    setappdata(0,'sarco_para_user_stdangles',sarco_para_user_stdangles);
    setappdata(0,'sarco_para_user_stdsarco',sarco_para_user_stdsarco);
    setappdata(0,'sarco_para_user_delta',sarco_para_user_delta);
    setappdata(0,'sarco_para_user_filenamestack',sarco_para_user_filenamestack);
    setappdata(0,'sarco_para_user_relax',sarco_para_user_relax);
    setappdata(0,'sarco_para_user_outlinex',sarco_para_user_outlinex);
    setappdata(0,'sarco_para_user_outliney',sarco_para_user_outliney);
    setappdata(0,'sarco_para_user_mask',sarco_para_user_mask);
    setappdata(0,'sarco_para_user_concentration',sarco_para_user_concentration);
    setappdata(0,'sarco_para_user_dmax',dmax);
    setappdata(0,'sarco_para_user_dmin',dmin);
    setappdata(0,'sarco_para_user_vmax',vmax);
    setappdata(0,'sarco_para_user_vmin',vmin);
    setappdata(0,'sarco_para_user_dt',dt);
    setappdata(0,'sarco_para_user_velocity',Velocity);
    setappdata(0,'sarco_para_user_para_Deltad',sarco_para_user_para_Deltad);
    setappdata(0,'sarco_para_user_para_vcontr',sarco_para_user_para_vcontr);
    setappdata(0,'sarco_para_user_para_vrelax',sarco_para_user_para_vrelax);
    setappdata(0,'sarco_para_user_tcontr',sarco_para_user_tcontr);
    setappdata(0,'sarco_para_user_para_tcontr',sarco_para_user_para_tcontr);
    setappdata(0,'sarco_para_user_tdp',sarco_para_user_tdp);
    setappdata(0,'sarco_para_user_para_tdp',sarco_para_user_para_tdp);
    setappdata(0,'sarco_para_user_freq2',sarco_para_user_freq2);
    setappdata(0,'sarco_para_user_para_freq2',sarco_para_user_para_freq2);
    setappdata(0,'sarco_para_user_para_freq',sarco_para_user_para_freq);
    setappdata(0,'sarco_para_user_para_freqy',sarco_para_user_para_freqy);
    setappdata(0,'sarco_para_user_freq',freq);
    setappdata(0,'sarco_para_user_y_fft',y_fft);
    setappdata(0,'sarco_para_user_para_ratiop',sarco_para_user_para_ratiop);
    setappdata(0,'sarco_para_user_para_ratiodp',sarco_para_user_para_ratiodp);
    setappdata(0,'sarco_para_user_para_tagdp',sarco_para_user_para_tagdp);
    setappdata(0,'sarco_para_user_para_tag',sarco_para_user_para_tag);
    setappdata(0,'sarco_para_user_meansarco',sarco_para_user_meansarco);
    setappdata(0,'sarco_para_user_meansarco_min',sarco_para_user_meansarco_min);
    setappdata(0,'sarco_para_user_meansarco_max',sarco_para_user_meansarco_max);
    setappdata(0,'sarco_para_user_para_meansarco_min',sarco_para_user_para_meansarco_min);
    setappdata(0,'sarco_para_user_para_meansarco_max',sarco_para_user_para_meansarco_max);
    setappdata(0,'sarco_para_user_para_meansarco_mean',sarco_para_user_para_meansarco_mean);
    
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
sarco_para_user_dmax=getappdata(0,'sarco_para_user_dmax');
sarco_para_user_dmin=getappdata(0,'sarco_para_user_dmin');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_Deltad=getappdata(0,'sarco_para_user_para_Deltad');

d_init=sarco_para_user_dmax{sarco_para_user_counter};
hf=figure;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter},'-b'), hold on;
i1=plot(sarco_para_user_dmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmin{sarco_para_user_counter}(:,2),'.r'); hold on;
i2=plot(sarco_para_user_dmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmax{sarco_para_user_counter}(:,2),'.g'); hold on;
title('Add new maximum pt.')
[~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

d_add(:,1)=x*sarco_para_user_framerate{sarco_para_user_counter};
d_add(:,2)=y;
d_new(:,1)=[d_init(:,1);d_add(:,1)];
d_new(:,2)=[d_init(:,2);d_add(:,2)];
%plot new in axes
cla(h_para(1).axes_disp)
axes(h_para(1).axes_disp)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_dmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmin{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
plot(d_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},d_new(:,2)*1e6,'.g'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);
%
sarco_para_user_dmax{sarco_para_user_counter}=d_new;

%update para
sarco_para_user_para_Deltad{sarco_para_user_counter}=nanmean(sarco_para_user_dmax{sarco_para_user_counter}(:,2))-nanmean(sarco_para_user_dmin{sarco_para_user_counter}(:,2));
set(h_para(1).text_disp,'String',['dcontr=',num2str(sarco_para_user_para_Deltad{sarco_para_user_counter},'%.2e'),' [m]']);

%save for shared use
setappdata(0,'sarco_para_user_dmax',sarco_para_user_dmax);
setappdata(0,'sarco_para_user_para_Deltad',sarco_para_user_para_Deltad);

catch
end

function para_push_disp_addmin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_dmax=getappdata(0,'sarco_para_user_dmax');
sarco_para_user_dmin=getappdata(0,'sarco_para_user_dmin');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_Deltad=getappdata(0,'sarco_para_user_para_Deltad');

d_init=sarco_para_user_dmin{sarco_para_user_counter};
hf=figure;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter},'-b'), hold on;
i1=plot(sarco_para_user_dmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmin{sarco_para_user_counter}(:,2),'.r'); hold on;
i2=plot(sarco_para_user_dmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmax{sarco_para_user_counter}(:,2),'.g'); hold on;
title('Add new mainimum pt.')
[~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

d_add(:,1)=x*sarco_para_user_framerate{sarco_para_user_counter};
d_add(:,2)=y;
d_new(:,1)=[d_init(:,1);d_add(:,1)];
d_new(:,2)=[d_init(:,2);d_add(:,2)];
%plot new in axes
cla(h_para(1).axes_disp)
axes(h_para(1).axes_disp)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_dmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmax{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
plot(d_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},d_new(:,2)*1e6,'.r'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);

sarco_para_user_dmin{sarco_para_user_counter}=d_new;

%update para
sarco_para_user_para_Deltad{sarco_para_user_counter}=nanmean(sarco_para_user_dmax{sarco_para_user_counter}(:,2))-nanmean(sarco_para_user_dmin{sarco_para_user_counter}(:,2));
set(h_para(1).text_disp,'String',['dcontr=',num2str(sarco_para_user_para_Deltad{sarco_para_user_counter},'%.2e'),' [m]']);

%save for shared use
setappdata(0,'sarco_para_user_dmin',sarco_para_user_dmin);
setappdata(0,'sarco_para_user_para_Deltad',sarco_para_user_para_Deltad);

catch
end

function para_push_disp_removemax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_dmax=getappdata(0,'sarco_para_user_dmax');
sarco_para_user_dmin=getappdata(0,'sarco_para_user_dmin');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_Deltad=getappdata(0,'sarco_para_user_para_Deltad');

d_init=sarco_para_user_dmax{sarco_para_user_counter};
hf=figure;
i1=plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter},'-b'); hold on;
i2=plot(sarco_para_user_dmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmin{sarco_para_user_counter}(:,2),'.r'); hold on;
plot(sarco_para_user_dmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmax{sarco_para_user_counter}(:,2),'.g'), hold on;
title('Delete maximum pt.')
[p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

d_new(:,1)=d_init(:,1);
d_new(:,2)=d_init(:,2);
d_new(p,:)=[];


%plot new in axes
cla(h_para(1).axes_disp)
axes(h_para(1).axes_disp)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_dmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmin{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
plot(d_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},d_new(:,2)*1e6,'.g'), hold on;

set(gca, 'XTick', []);
set(gca, 'YTick', []);

sarco_para_user_dmax{sarco_para_user_counter}=d_new;

%update para
sarco_para_user_para_Deltad{sarco_para_user_counter}=nanmean(sarco_para_user_dmax{sarco_para_user_counter}(:,2))-nanmean(sarco_para_user_dmin{sarco_para_user_counter}(:,2));
set(h_para(1).text_disp,'String',['dcontr=',num2str(sarco_para_user_para_Deltad{sarco_para_user_counter},'%.2e'),' [m]']);

%save for shared use
setappdata(0,'sarco_para_user_dmax',sarco_para_user_dmax);
setappdata(0,'sarco_para_user_para_Deltad',sarco_para_user_para_Deltad);

catch
end

function para_push_disp_removemin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_dmax=getappdata(0,'sarco_para_user_dmax');
sarco_para_user_dmin=getappdata(0,'sarco_para_user_dmin');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_Deltad=getappdata(0,'sarco_para_user_para_Deltad');

d_init=sarco_para_user_dmin{sarco_para_user_counter};
hf=figure;
i1=plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter},'-b'); hold on;
plot(sarco_para_user_dmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmin{sarco_para_user_counter}(:,2),'.r'); hold on;
i2=plot(sarco_para_user_dmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmax{sarco_para_user_counter}(:,2),'.g'); hold on;
title('Delete minimum pt.')

[p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

d_new(:,1)=d_init(:,1);
d_new(:,2)=d_init(:,2);
d_new(p,:)=[];


%plot new in axes
cla(h_para(1).axes_disp)
axes(h_para(1).axes_disp)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_dmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_dmax{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
plot(d_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},d_new(:,2)*1e6,'.r'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);

sarco_para_user_dmin{sarco_para_user_counter}=d_new;

%update para
sarco_para_user_para_Deltad{sarco_para_user_counter}=nanmean(sarco_para_user_dmax{sarco_para_user_counter}(:,2))-nanmean(sarco_para_user_dmin{sarco_para_user_counter}(:,2));
set(h_para(1).text_disp,'String',['dcontr=',num2str(sarco_para_user_para_Deltad{sarco_para_user_counter},'%.2e'),' [m]']);

%save for shared use
setappdata(0,'sarco_para_user_dmin',sarco_para_user_dmin);
setappdata(0,'sarco_para_user_para_Deltad',sarco_para_user_para_Deltad);

catch
end

function para_push_disp_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_dmax=getappdata(0,'sarco_para_user_dmax');
sarco_para_user_dmin=getappdata(0,'sarco_para_user_dmin');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_para_Deltad=getappdata(0,'sarco_para_user_para_Deltad');

%plot new in axes
cla(h_para(1).axes_disp)
axes(h_para(1).axes_disp)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);

%delte dmin and dmax
sarco_para_user_dmin{sarco_para_user_counter}(:,1)=NaN;
sarco_para_user_dmin{sarco_para_user_counter}(:,2)=NaN;
sarco_para_user_dmax{sarco_para_user_counter}(:,1)=NaN;
sarco_para_user_dmax{sarco_para_user_counter}(:,2)=NaN;

%update para
sarco_para_user_para_Deltad{sarco_para_user_counter}=nanmean(sarco_para_user_dmax{sarco_para_user_counter}(:,2))-nanmean(sarco_para_user_dmin{sarco_para_user_counter}(:,2));
set(h_para(1).text_disp,'String',['dcontr=',num2str(sarco_para_user_para_Deltad{sarco_para_user_counter},'%.2e'),' [m]']);

%save for shared use
setappdata(0,'sarco_para_user_dmin',sarco_para_user_dmin);
setappdata(0,'sarco_para_user_dmax',sarco_para_user_dmax);
setappdata(0,'sarco_para_user_para_Deltad',sarco_para_user_para_Deltad);

catch
end

function para_push_vel_addmax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_vmax=getappdata(0,'sarco_para_user_vmax');
sarco_para_user_vmin=getappdata(0,'sarco_para_user_vmin');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_velocity=getappdata(0,'sarco_para_user_velocity');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_vcontr=getappdata(0,'sarco_para_user_para_vcontr');
sarco_para_user_para_vrelax=getappdata(0,'sarco_para_user_para_vrelax');

v_init=sarco_para_user_vmax{sarco_para_user_counter};
hf=figure;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter},'-b'), hold on;
i1=plot(sarco_para_user_vmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmin{sarco_para_user_counter}(:,2),'.r'); hold on;
i2=plot(sarco_para_user_vmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmax{sarco_para_user_counter}(:,2),'.g'); hold on;
title('Add new maximum pt.')
[~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

v_add(:,1)=x*sarco_para_user_framerate{sarco_para_user_counter};
v_add(:,2)=y;
v_new(:,1)=[v_init(:,1);v_add(:,1)];
v_new(:,2)=[v_init(:,2);v_add(:,2)];
%plot new in axes
cla(h_para(1).axes_vel)
axes(h_para(1).axes_vel)
plot(sarco_para_user_dt{sarco_para_user_counter},zeros(1,length(sarco_para_user_dt{sarco_para_user_counter})),'--k'), hold on;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_vmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmin{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
plot(v_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},v_new(:,2)*1e6,'.g'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);

sarco_para_user_vmax{sarco_para_user_counter}=v_new;

%upate para
sarco_para_user_para_vcontr{sarco_para_user_counter}=nanmean(sarco_para_user_vmax{sarco_para_user_counter}(:,2));
sarco_para_user_para_vrelax{sarco_para_user_counter}=nanmean(sarco_para_user_vmin{sarco_para_user_counter}(:,2));
set(h_para(1).text_vel1,'String',['vcontr=',num2str(sarco_para_user_para_vcontr{sarco_para_user_counter},'%.2e'),' [m/s]']);
set(h_para(1).text_vel2,'String',['vrelax=',num2str(sarco_para_user_para_vrelax{sarco_para_user_counter},'%.2e'),' [m/s]']);

%save for shared use
setappdata(0,'sarco_para_user_vmax',sarco_para_user_vmax);
setappdata(0,'sarco_para_user_para_vcontr',sarco_para_user_para_vcontr);
setappdata(0,'sarco_para_user_para_vrelax',sarco_para_user_para_vrelax);

catch
end

function para_push_vel_addmin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_vmax=getappdata(0,'sarco_para_user_vmax');
sarco_para_user_vmin=getappdata(0,'sarco_para_user_vmin');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_velocity=getappdata(0,'sarco_para_user_velocity');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_vcontr=getappdata(0,'sarco_para_user_para_vcontr');
sarco_para_user_para_vrelax=getappdata(0,'sarco_para_user_para_vrelax');

v_init=sarco_para_user_vmin{sarco_para_user_counter};
hf=figure;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter},'-b'), hold on;
i1=plot(sarco_para_user_vmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmin{sarco_para_user_counter}(:,2),'.r'); hold on;
i2=plot(sarco_para_user_vmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmax{sarco_para_user_counter}(:,2),'.g'); hold on;
title('Add new minimum pt.')
[~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

v_add(:,1)=x*sarco_para_user_framerate{sarco_para_user_counter};
v_add(:,2)=y;
v_new(:,1)=[v_init(:,1);v_add(:,1)];
v_new(:,2)=[v_init(:,2);v_add(:,2)];
%plot new in axes
cla(h_para(1).axes_vel)
axes(h_para(1).axes_vel)
plot(sarco_para_user_dt{sarco_para_user_counter},zeros(1,length(sarco_para_user_dt{sarco_para_user_counter})),'--k'), hold on;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_vmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmax{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
plot(v_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},v_new(:,2)*1e6,'.r'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);

sarco_para_user_vmin{sarco_para_user_counter}=v_new;

%upate para
sarco_para_user_para_vcontr{sarco_para_user_counter}=nanmean(sarco_para_user_vmax{sarco_para_user_counter}(:,2));
sarco_para_user_para_vrelax{sarco_para_user_counter}=nanmean(sarco_para_user_vmin{sarco_para_user_counter}(:,2));
set(h_para(1).text_vel1,'String',['vcontr=',num2str(sarco_para_user_para_vcontr{sarco_para_user_counter},'%.2e'),' [m/s]']);
set(h_para(1).text_vel2,'String',['vrelax=',num2str(sarco_para_user_para_vrelax{sarco_para_user_counter},'%.2e'),' [m/s]']);

%save for shared use
setappdata(0,'sarco_para_user_vmin',sarco_para_user_vmin);
setappdata(0,'sarco_para_user_para_vcontr',sarco_para_user_para_vcontr);
setappdata(0,'sarco_para_user_para_vrelax',sarco_para_user_para_vrelax);

catch
end

function para_push_vel_removemax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_vmax=getappdata(0,'sarco_para_user_vmax');
sarco_para_user_vmin=getappdata(0,'sarco_para_user_vmin');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_velocity=getappdata(0,'sarco_para_user_velocity');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_vcontr=getappdata(0,'sarco_para_user_para_vcontr');
sarco_para_user_para_vrelax=getappdata(0,'sarco_para_user_para_vrelax');

v_init=sarco_para_user_vmax{sarco_para_user_counter};
hf=figure;
i1=plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter},'-b'); hold on;
i2=plot(sarco_para_user_vmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmin{sarco_para_user_counter}(:,2),'.r'); hold on;
plot(sarco_para_user_vmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmax{sarco_para_user_counter}(:,2),'.g'), hold on;
title('Delete maximum pt.')
[p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

v_new(:,1)=v_init(:,1);
v_new(:,2)=v_init(:,2);
v_new(p,:)=[];


%plot new in axes
cla(h_para(1).axes_vel)
axes(h_para(1).axes_vel)
plot(sarco_para_user_dt{sarco_para_user_counter},zeros(1,length(sarco_para_user_dt{sarco_para_user_counter})),'--k'), hold on;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_vmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmin{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
plot(v_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},v_new(:,2)*1e6,'.g'), hold on;

set(gca, 'XTick', []);
set(gca, 'YTick', []);

sarco_para_user_vmax{sarco_para_user_counter}=v_new;

%upate para
sarco_para_user_para_vcontr{sarco_para_user_counter}=nanmean(sarco_para_user_vmax{sarco_para_user_counter}(:,2));
sarco_para_user_para_vrelax{sarco_para_user_counter}=nanmean(sarco_para_user_vmin{sarco_para_user_counter}(:,2));
set(h_para(1).text_vel1,'String',['vcontr=',num2str(sarco_para_user_para_vcontr{sarco_para_user_counter},'%.2e'),' [m/s]']);
set(h_para(1).text_vel2,'String',['vrelax=',num2str(sarco_para_user_para_vrelax{sarco_para_user_counter},'%.2e'),' [m/s]']);

%save for shared use
setappdata(0,'sarco_para_user_vmax',sarco_para_user_vmax);
setappdata(0,'sarco_para_user_para_vcontr',sarco_para_user_para_vcontr);
setappdata(0,'sarco_para_user_para_vrelax',sarco_para_user_para_vrelax);

catch
end

function para_push_vel_removemin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_vmax=getappdata(0,'sarco_para_user_vmax');
sarco_para_user_vmin=getappdata(0,'sarco_para_user_vmin');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_velocity=getappdata(0,'sarco_para_user_velocity');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_vcontr=getappdata(0,'sarco_para_user_para_vcontr');
sarco_para_user_para_vrelax=getappdata(0,'sarco_para_user_para_vrelax');

v_init=sarco_para_user_vmin{sarco_para_user_counter};
hf=figure;
i1=plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter},'-b'); hold on;
plot(sarco_para_user_vmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmin{sarco_para_user_counter}(:,2),'.r'); hold on;
i2=plot(sarco_para_user_vmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmax{sarco_para_user_counter}(:,2),'.g'); hold on;
title('Delete minimum pt.')

[p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

v_new(:,1)=v_init(:,1);
v_new(:,2)=v_init(:,2);
v_new(p,:)=[];


%plot new in axes
cla(h_para(1).axes_vel)
axes(h_para(1).axes_vel)
plot(sarco_para_user_dt{sarco_para_user_counter},zeros(1,length(sarco_para_user_dt{sarco_para_user_counter})),'--k'), hold on;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_vmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_vmax{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
plot(v_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},v_new(:,2)*1e6,'.r'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);

sarco_para_user_vmin{sarco_para_user_counter}=v_new;

%upate para
sarco_para_user_para_vcontr{sarco_para_user_counter}=nanmean(sarco_para_user_vmax{sarco_para_user_counter}(:,2));
sarco_para_user_para_vrelax{sarco_para_user_counter}=nanmean(sarco_para_user_vmin{sarco_para_user_counter}(:,2));
set(h_para(1).text_vel1,'String',['vcontr=',num2str(sarco_para_user_para_vcontr{sarco_para_user_counter},'%.2e'),' [m/s]']);
set(h_para(1).text_vel2,'String',['vrelax=',num2str(sarco_para_user_para_vrelax{sarco_para_user_counter},'%.2e'),' [m/s]']);

%save for shared use
setappdata(0,'sarco_para_user_vmin',sarco_para_user_vmin);
setappdata(0,'sarco_para_user_para_vcontr',sarco_para_user_para_vcontr);
setappdata(0,'sarco_para_user_para_vrelax',sarco_para_user_para_vrelax);

catch
end

function para_push_vel_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_vmax=getappdata(0,'sarco_para_user_vmax');
sarco_para_user_vmin=getappdata(0,'sarco_para_user_vmin');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_velocity=getappdata(0,'sarco_para_user_velocity');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_para_vcontr=getappdata(0,'sarco_para_user_para_vcontr');
sarco_para_user_para_vrelax=getappdata(0,'sarco_para_user_para_vrelax');

%plot new in axes
cla(h_para(1).axes_vel)
axes(h_para(1).axes_vel)
plot(sarco_para_user_dt{sarco_para_user_counter},zeros(1,length(sarco_para_user_dt{sarco_para_user_counter})),'--k'), hold on;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);

%delte dmin and dmax
sarco_para_user_vmin{sarco_para_user_counter}(:,1)=NaN;
sarco_para_user_vmin{sarco_para_user_counter}(:,2)=NaN;
sarco_para_user_vmax{sarco_para_user_counter}(:,1)=NaN;
sarco_para_user_vmax{sarco_para_user_counter}(:,2)=NaN;

%upate para
sarco_para_user_para_vcontr{sarco_para_user_counter}=nanmean(sarco_para_user_vmax{sarco_para_user_counter}(:,2));
sarco_para_user_para_vrelax{sarco_para_user_counter}=nanmean(sarco_para_user_vmin{sarco_para_user_counter}(:,2));
set(h_para(1).text_vel1,'String',['vcontr=',num2str(sarco_para_user_para_vcontr{sarco_para_user_counter},'%.2e'),' [m/s]']);
set(h_para(1).text_vel2,'String',['vrelax=',num2str(sarco_para_user_para_vrelax{sarco_para_user_counter},'%.2e'),' [m/s]']);

%save for shared use
setappdata(0,'sarco_para_user_vmin',sarco_para_user_vmin);
setappdata(0,'sarco_para_user_vmax',sarco_para_user_vmax);
setappdata(0,'sarco_para_user_para_vcontr',sarco_para_user_para_vcontr);
setappdata(0,'sarco_para_user_para_vrelax',sarco_para_user_para_vrelax);

catch
end

function para_push_freq_add(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%add  pair
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_freq2=getappdata(0,'sarco_para_user_freq2');
sarco_para_user_para_freq2=getappdata(0,'sarco_para_user_para_freq2');

t_init=sarco_para_user_freq2{sarco_para_user_counter};

hf=figure;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter},'-b'), hold on;
i1=plot(t_init(:,1),t_init(:,3),'.r');
i2=plot(t_init(:,2),t_init(:,4),'.r');
title('Add new left side')
[~,x1,y1] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
cla;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter},'-b'), hold on;
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
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
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
sarco_para_user_freq2{sarco_para_user_counter}=t_new;
x=nanmean(dtcontr);

%display
set(h_para(1).text_freq1,'String',['f=',num2str(1/(x+eps),'%.2e'),' [Hz]']);
set(h_para(1).text_freq2,'String',['T=',num2str(x,'%.2e'),' [s]']);

sarco_para_user_para_freq2{sarco_para_user_counter}=1/(x+eps);

%save for shared use
setappdata(0,'sarco_para_user_freq2',sarco_para_user_freq2);
setappdata(0,'sarco_para_user_para_freq2',sarco_para_user_para_freq2);

catch
end

function para_push_freq_addfft(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try

sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_freq=getappdata(0,'sarco_para_user_freq');
sarco_para_user_para_freq=getappdata(0,'sarco_para_user_para_freq');
sarco_para_user_para_freqy=getappdata(0,'sarco_para_user_para_freqy');
sarco_para_user_y_fft=getappdata(0,'sarco_para_user_y_fft');

%
freq=sarco_para_user_freq;
y_fft=sarco_para_user_y_fft;

hf=figure;
plot(freq{sarco_para_user_counter},y_fft{sarco_para_user_counter},'-b'), hold on;
title('Pick peak')
[~,x,y] = selectdata('SelectionMode','closest');
close(hf);

%plot
cla(h_para(1).axes_freq)
axes(h_para(1).axes_freq)
plot(freq{sarco_para_user_counter},y_fft{sarco_para_user_counter},'-b'), hold on;
plot(x,y,'.g')
set(gca, 'XTick', []);
set(gca, 'YTick', []);

%display
set(h_para(1).text_freq1,'String',['f=',num2str(x,'%.2e'),' [Hz]']);
set(h_para(1).text_freq2,'String',['T=',num2str(1/x,'%.2e'),' [s]']);

sarco_para_user_para_freq{sarco_para_user_counter}=x;
sarco_para_user_para_freqy{sarco_para_user_counter}=y;

%save for shared use
setappdata(0,'sarco_para_user_para_freq',sarco_para_user_para_freq);
setappdata(0,'sarco_para_user_para_freqy',sarco_para_user_para_freqy);
%setappdata(0,'sarco_para_user_para_vcontr',sarco_para_user_para_vcontr);
%setappdata(0,'sarco_para_user_para_vrelax',sarco_para_user_para_vrelax);

catch
end

function para_push_freq_remove(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_freq2=getappdata(0,'sarco_para_user_freq2');
sarco_para_user_para_freq2=getappdata(0,'sarco_para_user_para_freq2');

t_init=sarco_para_user_freq2{sarco_para_user_counter};

hf=figure;
i1=plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter},'-b'); hold on;
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
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
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
sarco_para_user_freq2{sarco_para_user_counter}=t_new;
x=nanmean(dtcontr);

%display
set(h_para(1).text_freq1,'String',['f=',num2str(1/(x+eps),'%.2e'),' [Hz]']);
set(h_para(1).text_freq2,'String',['T=',num2str(x,'%.2e'),' [s]']);

sarco_para_user_para_freq2{sarco_para_user_counter}=1/(x+eps);

%save for shared use
setappdata(0,'sarco_para_user_freq2',sarco_para_user_freq2);
setappdata(0,'sarco_para_user_para_freq2',sarco_para_user_para_freq2);

catch
end

function para_push_freq_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%remove all
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_freq2=getappdata(0,'sarco_para_user_freq2');
sarco_para_user_para_freq2=getappdata(0,'sarco_para_user_para_freq2');

t_new(:,1)=NaN;
t_new(:,2)=NaN;
t_new(:,3)=NaN;
t_new(:,4)=NaN;

cla(h_para(1).axes_freq)
axes(h_para(1).axes_freq)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
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
sarco_para_user_freq2{sarco_para_user_counter}=t_new;
sarco_para_user_para_freq2{sarco_para_user_counter}=nanmean(dtcontr);
x=sarco_para_user_para_freq2{sarco_para_user_counter};

%display
set(h_para(1).text_freq1,'String',['f=',num2str(1/(x+eps),'%.2e'),' [Hz]']);
set(h_para(1).text_freq2,'String',['T=',num2str(x,'%.2e'),' [s]']);

%save for shared use
setappdata(0,'sarco_para_user_freq2',sarco_para_user_freq2);
setappdata(0,'sarco_para_user_para_freq2',sarco_para_user_para_freq2);

catch
end

function para_push_meansarco_addmax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_meansarco_max=getappdata(0,'sarco_para_user_meansarco_max');
sarco_para_user_meansarco_min=getappdata(0,'sarco_para_user_meansarco_min');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_meansarco=getappdata(0,'sarco_para_user_meansarco');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_meansarco_min=getappdata(0,'sarco_para_user_para_meansarco_min');
sarco_para_user_para_meansarco_max=getappdata(0,'sarco_para_user_para_meansarco_max');

d_init=sarco_para_user_meansarco_max{sarco_para_user_counter};
hf=figure;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter},'-b'), hold on;
i1=plot(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2),'.r'); hold on;
i2=plot(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2),'.g'); hold on;
title('Add new maximum pt.')
[~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

d_add(:,1)=x*sarco_para_user_framerate{sarco_para_user_counter};
d_add(:,2)=y;
d_new(:,1)=[d_init(:,1);d_add(:,1)];
d_new(:,2)=[d_init(:,2);d_add(:,2)];
%plot new in axes
cla(h_para(1).axes_meansarco)
axes(h_para(1).axes_meansarco)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
plot(d_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},d_new(:,2)*1e6,'.g'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);
%
sarco_para_user_meansarco_max{sarco_para_user_counter}=d_new;

%update para
sarco_para_user_para_meansarco_max{sarco_para_user_counter}=nanmean(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2))*1e-6;
sarco_para_user_para_meansarco_min{sarco_para_user_counter}=nanmean(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2))*1e-6;
set(h_para(1).text_meansarco2,'String',['av. short. =',num2str(sarco_para_user_para_meansarco_max{sarco_para_user_counter}-sarco_para_user_para_meansarco_min{sarco_para_user_counter},'%.2e'),' [m]']);

%save for shared use
setappdata(0,'sarco_para_user_meansarco_max',sarco_para_user_meansarco_max);
setappdata(0,'sarco_para_user_para_meansarco_max',sarco_para_user_para_meansarco_max);
setappdata(0,'sarco_para_user_para_meansarco_min',sarco_para_user_para_meansarco_min);

catch
end

function para_push_meansarco_addmin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_meansarco_max=getappdata(0,'sarco_para_user_meansarco_max');
sarco_para_user_meansarco_min=getappdata(0,'sarco_para_user_meansarco_min');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_meansarco=getappdata(0,'sarco_para_user_meansarco');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_meansarco_min=getappdata(0,'sarco_para_user_para_meansarco_min');
sarco_para_user_para_meansarco_max=getappdata(0,'sarco_para_user_para_meansarco_max');

d_init=sarco_para_user_meansarco_min{sarco_para_user_counter};
hf=figure;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter},'-b'), hold on;
i1=plot(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2),'.r'); hold on;
i2=plot(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2),'.g'); hold on;
title('Add new minimum pt.')
[~,x,y] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

d_add(:,1)=x*sarco_para_user_framerate{sarco_para_user_counter};
d_add(:,2)=y;
d_new(:,1)=[d_init(:,1);d_add(:,1)];
d_new(:,2)=[d_init(:,2);d_add(:,2)];
%plot new in axes
cla(h_para(1).axes_meansarco)
axes(h_para(1).axes_meansarco)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
plot(d_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},d_new(:,2)*1e6,'.r'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);

sarco_para_user_meansarco_min{sarco_para_user_counter}=d_new;

%update para
sarco_para_user_para_meansarco_max{sarco_para_user_counter}=nanmean(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2))*1e-6;
sarco_para_user_para_meansarco_min{sarco_para_user_counter}=nanmean(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2))*1e-6;
set(h_para(1).text_meansarco2,'String',['av. short. =',num2str(sarco_para_user_para_meansarco_max{sarco_para_user_counter}-sarco_para_user_para_meansarco_min{sarco_para_user_counter},'%.2e'),' [m]']);

%save for shared use
setappdata(0,'sarco_para_user_meansarco_min',sarco_para_user_meansarco_min);
setappdata(0,'sarco_para_user_para_meansarco_max',sarco_para_user_para_meansarco_max);
setappdata(0,'sarco_para_user_para_meansarco_min',sarco_para_user_para_meansarco_min);


catch
end

function para_push_meansarco_removemax(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_meansarco_max=getappdata(0,'sarco_para_user_meansarco_max');
sarco_para_user_meansarco_min=getappdata(0,'sarco_para_user_meansarco_min');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_meansarco=getappdata(0,'sarco_para_user_meansarco');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_meansarco_min=getappdata(0,'sarco_para_user_para_meansarco_min');
sarco_para_user_para_meansarco_max=getappdata(0,'sarco_para_user_para_meansarco_max');


d_init=sarco_para_user_meansarco_max{sarco_para_user_counter};
hf=figure;
i1=plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter},'-b'); hold on;
i2=plot(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2),'.r'); hold on;
plot(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2),'.g'), hold on;
title('Delete maximum pt.')
[p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

d_new(:,1)=d_init(:,1);
d_new(:,2)=d_init(:,2);
d_new(p,:)=[];


%plot new in axes
cla(h_para(1).axes_meansarco)
axes(h_para(1).axes_meansarco)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
plot(d_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},d_new(:,2)*1e6,'.g'), hold on;

set(gca, 'XTick', []);
set(gca, 'YTick', []);

sarco_para_user_meansarco_max{sarco_para_user_counter}=d_new;

%update para
sarco_para_user_para_meansarco_max{sarco_para_user_counter}=nanmean(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2))*1e-6;
sarco_para_user_para_meansarco_min{sarco_para_user_counter}=nanmean(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2))*1e-6;
set(h_para(1).text_meansarco2,'String',['av. short. =',num2str(sarco_para_user_para_meansarco_max{sarco_para_user_counter}-sarco_para_user_para_meansarco_min{sarco_para_user_counter},'%.2e'),' [m]']);


%save for shared use
setappdata(0,'sarco_para_user_meansarco_max',sarco_para_user_meansarco_max);
setappdata(0,'sarco_para_user_para_meansarco_max',sarco_para_user_para_meansarco_max);
setappdata(0,'sarco_para_user_para_meansarco_min',sarco_para_user_para_meansarco_min);


catch
end

function para_push_meansarco_removemin(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_meansarco_max=getappdata(0,'sarco_para_user_meansarco_max');
sarco_para_user_meansarco_min=getappdata(0,'sarco_para_user_meansarco_min');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_meansarco=getappdata(0,'sarco_para_user_meansarco');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
sarco_para_user_para_meansarco_min=getappdata(0,'sarco_para_user_para_meansarco_min');
sarco_para_user_para_meansarco_max=getappdata(0,'sarco_para_user_para_meansarco_max');


d_init=sarco_para_user_meansarco_min{sarco_para_user_counter};
hf=figure;
i1=plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter},'-b'); hold on;
plot(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2),'.r'); hold on;
i2=plot(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2),'.g'); hold on;
title('Delete minimum pt.')

[p,~,~] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
close(hf);

d_new(:,1)=d_init(:,1);
d_new(:,2)=d_init(:,2);
d_new(p,:)=[];


%plot new in axes
cla(h_para(1).axes_meansarco)
axes(h_para(1).axes_meansarco)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter}*1e6,'-b'), hold on;
plot(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
plot(d_new(:,1)/sarco_para_user_framerate{sarco_para_user_counter},d_new(:,2)*1e6,'.r'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);

sarco_para_user_meansarco_min{sarco_para_user_counter}=d_new;

%update para
sarco_para_user_para_meansarco_max{sarco_para_user_counter}=nanmean(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2))*1e-6;
sarco_para_user_para_meansarco_min{sarco_para_user_counter}=nanmean(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2))*1e-6;
set(h_para(1).text_meansarco2,'String',['av. short. =',num2str(sarco_para_user_para_meansarco_max{sarco_para_user_counter}-sarco_para_user_para_meansarco_min{sarco_para_user_counter},'%.2e'),' [m]']);


%save for shared use
setappdata(0,'sarco_para_user_meansarco_min',sarco_para_user_meansarco_max);
setappdata(0,'sarco_para_user_para_meansarco_max',sarco_para_user_para_meansarco_max);
setappdata(0,'sarco_para_user_para_meansarco_min',sarco_para_user_para_meansarco_min);


catch
end

function para_push_meansarco_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
%load shared needed para
sarco_para_user_meansarco_max=getappdata(0,'sarco_para_user_meansarco_max');
sarco_para_user_meansarco_min=getappdata(0,'sarco_para_user_meansarco_min');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_meansarco=getappdata(0,'sarco_para_user_meansarco');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_para_meansarco_min=getappdata(0,'sarco_para_user_para_meansarco_min');
sarco_para_user_para_meansarco_max=getappdata(0,'sarco_para_user_para_meansarco_max');


%plot new in axes
cla(h_para(1).axes_meansarco)
axes(h_para(1).axes_meansarco)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter}*1e6,'-b'), hold on;
set(gca, 'XTick', []);
set(gca, 'YTick', []);

%delte dmin and dmax
sarco_para_user_meansarco_min{sarco_para_user_counter}(:,1)=NaN;
sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2)=NaN;
sarco_para_user_meansarco_max{sarco_para_user_counter}(:,1)=NaN;
sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2)=NaN;

%update para
sarco_para_user_para_meansarco_max{sarco_para_user_counter}=nanmean(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2))*1e-6;
sarco_para_user_para_meansarco_min{sarco_para_user_counter}=nanmean(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2))*1e-6;
set(h_para(1).text_meansarco2,'String',['av. short. =',num2str(sarco_para_user_para_meansarco_max{sarco_para_user_counter}-sarco_para_user_para_meansarco_min{sarco_para_user_counter},'%.2e'),' [m]']);

%save for shared use
setappdata(0,'sarco_para_user_meansarco_max',sarco_para_user_meansarco_max);
setappdata(0,'sarco_para_user_meansarco_min',sarco_para_user_meansarco_min);
setappdata(0,'sarco_para_user_para_meansarco_max',sarco_para_user_para_meansarco_max);
setappdata(0,'sarco_para_user_para_meansarco_min',sarco_para_user_para_meansarco_min);


catch
end

function para_push_contr_add(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_velocity=getappdata(0,'sarco_para_user_velocity');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_tcontr=getappdata(0,'sarco_para_user_tcontr');
sarco_para_user_para_tcontr=getappdata(0,'sarco_para_user_para_tcontr');

t_init=sarco_para_user_tcontr{sarco_para_user_counter};

hf=figure;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter},'-b'), hold on;
i1=plot(t_init(:,1),t_init(:,3),'.r');
i2=plot(t_init(:,2),t_init(:,4),'.r');
title('Add new maximum pt.')
[~,x1,y1] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
cla;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter},'-b'), hold on;
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
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
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
sarco_para_user_tcontr{sarco_para_user_counter}=t_new;
sarco_para_user_para_tcontr{sarco_para_user_counter}=nanmean(dtcontr);
set(h_para(1).text_contr,'String',['tcontr=',num2str(sarco_para_user_para_tcontr{sarco_para_user_counter},'%.2e'),' [s]']);

%save for shared use
setappdata(0,'sarco_para_user_tcontr',sarco_para_user_tcontr);
setappdata(0,'sarco_para_user_para_tcontr',sarco_para_user_para_tcontr);

catch
end

function para_push_contr_remove(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_velocity=getappdata(0,'sarco_para_user_velocity');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_tcontr=getappdata(0,'sarco_para_user_tcontr');
sarco_para_user_para_tcontr=getappdata(0,'sarco_para_user_para_tcontr');

t_init=sarco_para_user_tcontr{sarco_para_user_counter};

hf=figure;
i1=plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter},'-b'); hold on;
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
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
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
sarco_para_user_tcontr{sarco_para_user_counter}=t_new;
sarco_para_user_para_tcontr{sarco_para_user_counter}=nanmean(dtcontr);
set(h_para(1).text_contr,'String',['tcontr=',num2str(sarco_para_user_para_tcontr{sarco_para_user_counter},'%.2e'),' [s]']);

%save for shared use
setappdata(0,'sarco_para_user_tcontr',sarco_para_user_tcontr);
setappdata(0,'sarco_para_user_para_tcontr',sarco_para_user_para_tcontr);

catch
end

function para_push_contr_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_velocity=getappdata(0,'sarco_para_user_velocity');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_tcontr=getappdata(0,'sarco_para_user_tcontr');
sarco_para_user_para_tcontr=getappdata(0,'sarco_para_user_para_tcontr');

t_init=sarco_para_user_tcontr{sarco_para_user_counter};

t_new(:,1)=NaN;
t_new(:,2)=NaN;
t_new(:,3)=NaN;
t_new(:,4)=NaN;

%plot new in axes
cla(h_para(1).axes_contr)
axes(h_para(1).axes_contr)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_velocity{sarco_para_user_counter}*1e6,'-b'), hold on;

dtcontr=zeros(1,size(t_new,1));
for i=1:size(t_new,1)
    dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'r','LineWidth',5)
end
set(gca, 'XTick', []);
set(gca, 'YTick', []);
%save new pt vector
sarco_para_user_tcontr{sarco_para_user_counter}=t_new;
sarco_para_user_para_tcontr{sarco_para_user_counter}=nanmean(dtcontr);
set(h_para(1).text_contr,'String',['tcontr=',num2str(sarco_para_user_para_tcontr{sarco_para_user_counter},'%.2e'),' [s]']);

%save for shared use
setappdata(0,'sarco_para_user_tcontr',sarco_para_user_tcontr);
setappdata(0,'sarco_para_user_para_tcontr',sarco_para_user_para_tcontr);

catch
end

function para_push_dp2_add(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_tdp=getappdata(0,'sarco_para_user_tdp');
sarco_para_user_para_tdp=getappdata(0,'sarco_para_user_para_tdp');

t_init=sarco_para_user_tdp{sarco_para_user_counter};

hf=figure;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter},'-b'), hold on;
i1=plot(t_init(:,1),t_init(:,3),'.r');
i2=plot(t_init(:,2),t_init(:,4),'.r');
title('Add new primary peak')
[~,x1,y1] = selectdata('SelectionMode','closest','Ignore',[i1,i2]);
cla;
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter},'-b'), hold on;
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
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
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
sarco_para_user_tdp{sarco_para_user_counter}=t_new;
sarco_para_user_para_tdp{sarco_para_user_counter}=nanmean(dtcontr);
set(h_para(1).text_dp2_2,'String',['t=',num2str(sarco_para_user_para_tdp{sarco_para_user_counter},'%.2e'),' [s]']);

%save for shared use
setappdata(0,'sarco_para_user_tdp',sarco_para_user_tdp);
setappdata(0,'sarco_para_user_para_tdp',sarco_para_user_para_tdp);

catch
end

function para_push_dp2_remove(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_tdp=getappdata(0,'sarco_para_user_tdp');
sarco_para_user_para_tdp=getappdata(0,'sarco_para_user_para_tdp');

t_init=sarco_para_user_tdp{sarco_para_user_counter};

hf=figure;
i1=plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter},'-b'); hold on;
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
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
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
sarco_para_user_tdp{sarco_para_user_counter}=t_new;
sarco_para_user_para_tdp{sarco_para_user_counter}=nanmean(dtcontr);
set(h_para(1).text_dp2_2,'String',['t=',num2str(sarco_para_user_para_tdp{sarco_para_user_counter},'%.2e'),' [s]']);

%save for shared use
setappdata(0,'sarco_para_user_tdp',sarco_para_user_tdp);
setappdata(0,'sarco_para_user_para_tdp',sarco_para_user_para_tdp);

catch
end

function para_push_dp2_clearall(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_tdp=getappdata(0,'sarco_para_user_tdp');
sarco_para_user_para_tdp=getappdata(0,'sarco_para_user_para_tdp');

t_new(:,1)=NaN;
t_new(:,2)=NaN;
t_new(:,3)=NaN;
t_new(:,4)=NaN;

cla(h_para(1).axes_dp2)
axes(h_para(1).axes_dp2)
plot(sarco_para_user_dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;

dtcontr=zeros(1,size(t_new,1));
for i=1:size(t_new,1)
    dtcontr(1,i)=abs(t_new(i,2)-t_new(i,1));
plot(linspace(t_new(i,1),t_new(i,2),100),linspace(0,0,100),'r','LineWidth',5)
end
set(gca, 'XTick', []);
set(gca, 'YTick', []);
%save new pt vector
sarco_para_user_tdp{sarco_para_user_counter}=t_new;
sarco_para_user_para_tdp{sarco_para_user_counter}=nanmean(dtcontr);
set(h_para(1).text_dp2_2,'String',['t=',num2str(sarco_para_user_para_tdp{sarco_para_user_counter},'%.2e'),' [s]']);

%save for shared use
setappdata(0,'sarco_para_user_tdp',sarco_para_user_tdp);
setappdata(0,'sarco_para_user_para_tdp',sarco_para_user_para_tdp);

catch
end

function para_push_forwards(hObject, eventdata, h_para)
%disable figure during calculation
enableDisableFig(h_para(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_para(1).fig,1));


try
    %load what shared para we need
    sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
    sarco_para_user_d=getappdata(0,'sarco_para_user_d');
    sarco_para_user_totnum=getappdata(0,'sarco_para_user_totnum');
    sarco_para_user_filenamestack=getappdata(0,'sarco_para_user_filenamestack');
    sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
    dmax=getappdata(0,'sarco_para_user_dmax');
    dmin=getappdata(0,'sarco_para_user_dmin');
    vmax=getappdata(0,'sarco_para_user_vmax');
    vmin=getappdata(0,'sarco_para_user_vmin');
    dt=getappdata(0,'sarco_para_user_dt');
    Velocity=getappdata(0,'sarco_para_user_velocity');
    sarco_para_user_delta=getappdata(0,'sarco_para_user_delta');
    sarco_para_user_meandelta=getappdata(0,'sarco_para_user_meandelta');
    sarco_para_user_stddelta=getappdata(0,'sarco_para_user_stddelta');
    sarco_para_user_stdalpha=getappdata(0,'sarco_para_user_stdalpha');
    sarco_para_user_para_Deltad=getappdata(0,'sarco_para_user_para_Deltad');
    sarco_para_user_para_vcontr=getappdata(0,'sarco_para_user_para_vcontr');
    sarco_para_user_para_vrelax=getappdata(0,'sarco_para_user_para_vrelax');
    sarco_para_user_tcontr=getappdata(0,'sarco_para_user_tcontr');
    sarco_para_user_para_tcontr=getappdata(0,'sarco_para_user_para_tcontr');
    sarco_para_user_tdp=getappdata(0,'sarco_para_user_tdp');
    sarco_para_user_para_tdp=getappdata(0,'sarco_para_user_para_tdp');
    sarco_para_user_freq2=getappdata(0,'sarco_para_user_freq2');
    sarco_para_user_para_freq2=getappdata(0,'sarco_para_user_para_freq2');
    sarco_para_user_para_freq=getappdata(0,'sarco_para_user_para_freq');
    sarco_para_user_para_freqy=getappdata(0,'sarco_para_user_para_freqy');
    freq=getappdata(0,'sarco_para_user_freq');
    y_fft=getappdata(0,'sarco_para_user_y_fft');
    sarco_para_user_para_ratiop=getappdata(0,'sarco_para_user_para_ratiop');
    sarco_para_user_para_ratiodp=getappdata(0,'sarco_para_user_para_ratiodp');
    sarco_para_user_outlinex=getappdata(0,'sarco_para_user_outlinex');
    sarco_para_user_outliney=getappdata(0,'sarco_para_user_outliney');
    sarco_para_user_relax=getappdata(0,'sarco_para_user_relax');
    sarco_para_user_meansarco=getappdata(0,'sarco_para_user_meansarco');
    sarco_para_user_meansarco_min=getappdata(0,'sarco_para_user_meansarco_min');
    sarco_para_user_meansarco_max=getappdata(0,'sarco_para_user_meansarco_max');
    sarco_para_user_para_meansarco_min=getappdata(0,'sarco_para_user_para_meansarco_min');
    sarco_para_user_para_meansarco_max=getappdata(0,'sarco_para_user_para_meansarco_max');
    sarco_para_user_para_meansarco_mean=getappdata(0,'sarco_para_user_para_meansarco_mean');
    sarco_para_user_concentration=getappdata(0,'sarco_para_user_concentration');
    sarco_para_user_stdsarco=getappdata(0,'sarco_para_user_stdsarco');
    sarco_para_user_stdangles=getappdata(0,'sarco_para_user_stdangles');
    sarco_para_user_para_tagdp=getappdata(0,'sarco_para_user_para_tagdp');
    sarco_para_user_para_tag=getappdata(0,'sarco_para_user_para_tag');
    
    %save current stuff
    sarco_para_user_para_ratiop{sarco_para_user_counter}=str2double(get(h_para(1).edit_ratio,'String'));
    if sarco_para_user_para_tagdp{sarco_para_user_counter}
        sarco_para_user_para_ratiodp{sarco_para_user_counter}=str2double(get(h_para(1).edit_dp2,'String'));
    end
    
    %go to video before
    sarco_para_user_counter=sarco_para_user_counter+1;
    
    %set tags
    set(h_para(1).edit_ratio,'String',num2str(sarco_para_user_para_ratiop{sarco_para_user_counter}));
    if sarco_para_user_para_tagdp{sarco_para_user_counter}
        set(h_para(1).edit_dp2,'String',num2str(sarco_para_user_para_ratiodp{sarco_para_user_counter}));
    end
    %checkboxes
    if sarco_para_user_para_tag{sarco_para_user_counter}
        set(h_para(1).checkbox_tag,'Value',1)
    else
        set(h_para(1).checkbox_tag,'Value',0)
    end
    if sarco_para_user_para_tagdp{sarco_para_user_counter}
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
    plot(dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(dmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},dmin{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(dmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},dmax{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %displ. in double peak
    cla(h_para(1).axes_dp2)
    axes(h_para(1).axes_dp2)
    plot(dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(sarco_para_user_tdp{sarco_para_user_counter}(:,1),sarco_para_user_tdp{sarco_para_user_counter}(:,3)*1e6,'.r')
    plot(sarco_para_user_tdp{sarco_para_user_counter}(:,2),sarco_para_user_tdp{sarco_para_user_counter}(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(sarco_para_user_tdp{sarco_para_user_counter},1));
    for i=1:size(sarco_para_user_tdp{sarco_para_user_counter},1)
        dtcontr(1,i)=abs(sarco_para_user_tdp{sarco_para_user_counter}(i,2)-sarco_para_user_tdp{sarco_para_user_counter}(i,1));
        plot(linspace(sarco_para_user_tdp{sarco_para_user_counter}(i,1),sarco_para_user_tdp{sarco_para_user_counter}(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %plot 1st velocity. in axes
    cla(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(dt{sarco_para_user_counter},zeros(1,length(dt{sarco_para_user_counter})),'--k'), hold on;
    plot(dt{sarco_para_user_counter},Velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(vmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},vmin{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(vmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},vmax{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %%plot 1st velocity. in axes
    cla(h_para(1).axes_contr)
    axes(h_para(1).axes_contr)
    plot(dt{sarco_para_user_counter},Velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(sarco_para_user_tcontr{sarco_para_user_counter}(:,1),sarco_para_user_tcontr{sarco_para_user_counter}(:,3)*1e6,'.r')
    plot(sarco_para_user_tcontr{sarco_para_user_counter}(:,2),sarco_para_user_tcontr{sarco_para_user_counter}(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(sarco_para_user_tcontr{sarco_para_user_counter},1));
    for i=1:size(sarco_para_user_tcontr{sarco_para_user_counter},1)
        dtcontr(1,i)=abs(sarco_para_user_tcontr{sarco_para_user_counter}(i,2)-sarco_para_user_tcontr{sarco_para_user_counter}(i,1));
        plot(linspace(sarco_para_user_tcontr{sarco_para_user_counter}(i,1),sarco_para_user_tcontr{sarco_para_user_counter}(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %sarcomean plot
    %plot 1st displ. in axes
    cla(h_para(1).axes_meansarco)
    axes(h_para(1).axes_meansarco)
    plot(dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %preview
    cla(h_para(1).axes_preview)
    axes(h_para(1).axes_preview)
    s=load(['vars_DO_NOT_DELETE/',sarco_para_user_filenamestack{1,sarco_para_user_counter},'/image',num2str(sarco_para_user_relax{sarco_para_user_counter}),'.mat'],'imagei');
    image=s.imagei;
    imagesc(image); hold on;
    
    set(h_para(1).axes_preview,'xtick',[],'ytick',[])
    colormap('gray')
    freezeColors
    xp_s=sarco_para_user_outlinex{sarco_para_user_counter};
    yp_s=sarco_para_user_outliney{sarco_para_user_counter};
    plot([xp_s;xp_s(1)],[yp_s;yp_s(1)],'r')
    axis image;
    
    %for delta check radiobutton: does user want heatmap or histogram?
    if get(h_para(1).radiobutton_heatmap,'Value')
        %plot heatmaps
        reset(h_para(1).axes_delta)
        axes(h_para(1).axes_delta)
        imagesc(sarco_para_user_delta{sarco_para_user_counter}); hold on;
        colormap('jet')
        colorbar        
        caxis([sarco_para_user_meandelta{sarco_para_user_counter}-2*sarco_para_user_stddelta{sarco_para_user_counter}, sarco_para_user_meandelta{sarco_para_user_counter}+2*sarco_para_user_stddelta{sarco_para_user_counter}])
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        drawnow;
    elseif get(h_para(1).radiobutton_histogram,'Value')
        reset(h_para(1).axes_delta)
        axes(h_para(1).axes_delta)
        bdelta_vec = subsref(sarco_para_user_delta{sarco_para_user_counter}.', substruct('()', {':'})).';
        bdelta_vec(isnan(bdelta_vec))=[];
        hist(bdelta_vec,length(bdelta_vec))
        set(h_para(1).axes_delta, 'YTick', []);
    end
    
    
    %std movement angle
    cla(h_para(1).axes_stdangle)
    axes(h_para(1).axes_stdangle)
    plot(dt{sarco_para_user_counter},sarco_para_user_stdalpha{sarco_para_user_counter},'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %std orientation angle
    cla(h_para(1).axes_orient)
    axes(h_para(1).axes_orient)
    plot(dt{sarco_para_user_counter},sarco_para_user_stdangles{sarco_para_user_counter},'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %std sarco lengths
    cla(h_para(1).axes_stdsarco)
    axes(h_para(1).axes_stdsarco)
    plot(dt{sarco_para_user_counter},sarco_para_user_stdsarco{sarco_para_user_counter}*1e6,'-b'), hold on;
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
        x=sarco_para_user_para_freq{sarco_para_user_counter};
        y=sarco_para_user_para_freqy{sarco_para_user_counter};
        cla(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(freq{sarco_para_user_counter},y_fft{sarco_para_user_counter},'-b'), hold on;
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
        t_new=sarco_para_user_freq2{sarco_para_user_counter};
        x=1/(sarco_para_user_para_freq2{sarco_para_user_counter}+eps);
        cla(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
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
    set(h_para(1).text_disp,'String',['dcontr=',num2str(sarco_para_user_para_Deltad{sarco_para_user_counter},'%.2e'),' [m]']);
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(sarco_para_user_para_vcontr{sarco_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(sarco_para_user_para_vrelax{sarco_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_dp2_2,'String',['t=',num2str(sarco_para_user_para_tdp{sarco_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_contr,'String',['tcontr=',num2str(sarco_para_user_para_tcontr{sarco_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_delta1,'String',['mean delta=',num2str(sarco_para_user_meandelta{sarco_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_delta2,'String',['std delta=',num2str(sarco_para_user_stddelta{sarco_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_stdangle,'String',['mean of the std of movement angles =',num2str(nanmean(sarco_para_user_stdalpha{sarco_para_user_counter}),'%.2e'),' [deg]']);
    set(h_para(1).text_conc,'String',['concentration = ',num2str(sarco_para_user_concentration{sarco_para_user_counter})]);
    set(h_para(1).text_orient,'String',['mean of the std of orientation angles =',num2str(nanmean(sarco_para_user_stdangles{sarco_para_user_counter}),'%.2e'),' [deg]']);
    set(h_para(1).text_stdsarco,'String',['mean of the std of sarcomeres =',num2str(nanmean(sarco_para_user_stdsarco{sarco_para_user_counter}),'%.2e'),' [m]']);
    set(h_para(1).text_meansarco2,'String',['av. short. =',num2str(sarco_para_user_para_meansarco_max{sarco_para_user_counter}-sarco_para_user_para_meansarco_min{sarco_para_user_counter},'%.2e'),' [m]']);
    set(h_para(1).text_meansarco1,'String',['mean ms =',num2str(sarco_para_user_para_meansarco_mean{sarco_para_user_counter},'%.2e'),' [m]']);
    
    %set texts to 1st vid
    set(h_para(1).text_whichvidname,'String',sarco_para_user_filenamestack{1,sarco_para_user_counter});
    set(h_para(1).text_whichvid,'String',[num2str(sarco_para_user_counter),'/',num2str(sarco_para_user_totnum)]);
    
    
    %forward /backbutton
    if sarco_para_user_counter==1
        set(h_para(1).button_backwards,'Enable','off');
    else
        set(h_para(1).button_backwards,'Enable','on');
    end
    if sarco_para_user_counter==sarco_para_user_totnum
        set(h_para(1).button_forwards,'Enable','off');
    else
        set(h_para(1).button_forwards,'Enable','on');
    end
    
    %shared data
    setappdata(0,'sarco_para_user_para_ratiop',sarco_para_user_para_ratiop);
    setappdata(0,'sarco_para_user_para_ratiodp',sarco_para_user_para_ratiodp);
    setappdata(0,'sarco_para_user_counter',sarco_para_user_counter);
    
    
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
    sarco_para_user_framerate=getappdata(0,'sarco_para_user_framerate');
    sarco_para_user_d=getappdata(0,'sarco_para_user_d');
    sarco_para_user_totnum=getappdata(0,'sarco_para_user_totnum');
    sarco_para_user_filenamestack=getappdata(0,'sarco_para_user_filenamestack');
    sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
    dmax=getappdata(0,'sarco_para_user_dmax');
    dmin=getappdata(0,'sarco_para_user_dmin');
    vmax=getappdata(0,'sarco_para_user_vmax');
    vmin=getappdata(0,'sarco_para_user_vmin');
    dt=getappdata(0,'sarco_para_user_dt');
    Velocity=getappdata(0,'sarco_para_user_velocity');
    sarco_para_user_delta=getappdata(0,'sarco_para_user_delta');
    sarco_para_user_meandelta=getappdata(0,'sarco_para_user_meandelta');
    sarco_para_user_stddelta=getappdata(0,'sarco_para_user_stddelta');
    sarco_para_user_stdalpha=getappdata(0,'sarco_para_user_stdalpha');
    sarco_para_user_para_Deltad=getappdata(0,'sarco_para_user_para_Deltad');
    sarco_para_user_para_vcontr=getappdata(0,'sarco_para_user_para_vcontr');
    sarco_para_user_para_vrelax=getappdata(0,'sarco_para_user_para_vrelax');
    sarco_para_user_tcontr=getappdata(0,'sarco_para_user_tcontr');
    sarco_para_user_para_tcontr=getappdata(0,'sarco_para_user_para_tcontr');
    sarco_para_user_tdp=getappdata(0,'sarco_para_user_tdp');
    sarco_para_user_para_tdp=getappdata(0,'sarco_para_user_para_tdp');
    sarco_para_user_freq2=getappdata(0,'sarco_para_user_freq2');
    sarco_para_user_para_freq2=getappdata(0,'sarco_para_user_para_freq2');
    sarco_para_user_para_freq=getappdata(0,'sarco_para_user_para_freq');
    sarco_para_user_para_freqy=getappdata(0,'sarco_para_user_para_freqy');
    freq=getappdata(0,'sarco_para_user_freq');
    y_fft=getappdata(0,'sarco_para_user_y_fft');
    sarco_para_user_para_ratiop=getappdata(0,'sarco_para_user_para_ratiop');
    sarco_para_user_para_ratiodp=getappdata(0,'sarco_para_user_para_ratiodp');
    sarco_para_user_outlinex=getappdata(0,'sarco_para_user_outlinex');
    sarco_para_user_outliney=getappdata(0,'sarco_para_user_outliney');
    sarco_para_user_relax=getappdata(0,'sarco_para_user_relax');
    sarco_para_user_meansarco=getappdata(0,'sarco_para_user_meansarco');
    sarco_para_user_meansarco_min=getappdata(0,'sarco_para_user_meansarco_min');
    sarco_para_user_meansarco_max=getappdata(0,'sarco_para_user_meansarco_max');
    sarco_para_user_para_meansarco_min=getappdata(0,'sarco_para_user_para_meansarco_min');
    sarco_para_user_para_meansarco_max=getappdata(0,'sarco_para_user_para_meansarco_max');
    sarco_para_user_para_meansarco_mean=getappdata(0,'sarco_para_user_para_meansarco_mean');
    sarco_para_user_concentration=getappdata(0,'sarco_para_user_concentration');
    sarco_para_user_stdsarco=getappdata(0,'sarco_para_user_stdsarco');
    sarco_para_user_stdangles=getappdata(0,'sarco_para_user_stdangles');
    sarco_para_user_para_tagdp=getappdata(0,'sarco_para_user_para_tagdp');
    sarco_para_user_para_tag=getappdata(0,'sarco_para_user_para_tag');
    
    %save current stuff
    sarco_para_user_para_ratiop{sarco_para_user_counter}=str2double(get(h_para(1).edit_ratio,'String'));
    if sarco_para_user_para_tagdp{sarco_para_user_counter}
        sarco_para_user_para_ratiodp{sarco_para_user_counter}=str2double(get(h_para(1).edit_dp2,'String'));
    end
    
    %go to video before
    sarco_para_user_counter=sarco_para_user_counter-1;
    
    %set tags
    set(h_para(1).edit_ratio,'String',num2str(sarco_para_user_para_ratiop{sarco_para_user_counter}));
    if sarco_para_user_para_tagdp{sarco_para_user_counter}
        set(h_para(1).edit_dp2,'String',num2str(sarco_para_user_para_ratiodp{sarco_para_user_counter}));
    end
    %checkboxes
    if sarco_para_user_para_tag{sarco_para_user_counter}
        set(h_para(1).checkbox_tag,'Value',1)
    else
        set(h_para(1).checkbox_tag,'Value',0)
    end
    if sarco_para_user_para_tagdp{sarco_para_user_counter}
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
    plot(dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(dmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},dmin{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(dmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},dmax{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %displ. in double peak
    cla(h_para(1).axes_dp2)
    axes(h_para(1).axes_dp2)
    plot(dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(sarco_para_user_tdp{sarco_para_user_counter}(:,1),sarco_para_user_tdp{sarco_para_user_counter}(:,3)*1e6,'.r')
    plot(sarco_para_user_tdp{sarco_para_user_counter}(:,2),sarco_para_user_tdp{sarco_para_user_counter}(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(sarco_para_user_tdp{sarco_para_user_counter},1));
    for i=1:size(sarco_para_user_tdp{sarco_para_user_counter},1)
        dtcontr(1,i)=abs(sarco_para_user_tdp{sarco_para_user_counter}(i,2)-sarco_para_user_tdp{sarco_para_user_counter}(i,1));
        plot(linspace(sarco_para_user_tdp{sarco_para_user_counter}(i,1),sarco_para_user_tdp{sarco_para_user_counter}(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %plot 1st velocity. in axes
    cla(h_para(1).axes_vel)
    axes(h_para(1).axes_vel)
    plot(dt{sarco_para_user_counter},zeros(1,length(dt{sarco_para_user_counter})),'--k'), hold on;
    plot(dt{sarco_para_user_counter},Velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(vmin{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},vmin{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(vmax{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},vmax{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %%plot 1st velocity. in axes
    cla(h_para(1).axes_contr)
    axes(h_para(1).axes_contr)
    plot(dt{sarco_para_user_counter},Velocity{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(sarco_para_user_tcontr{sarco_para_user_counter}(:,1),sarco_para_user_tcontr{sarco_para_user_counter}(:,3)*1e6,'.r')
    plot(sarco_para_user_tcontr{sarco_para_user_counter}(:,2),sarco_para_user_tcontr{sarco_para_user_counter}(:,4)*1e6,'.r')
    %plot delta t
    dtcontr=zeros(1,size(sarco_para_user_tcontr{sarco_para_user_counter},1));
    for i=1:size(sarco_para_user_tcontr{sarco_para_user_counter},1)
        dtcontr(1,i)=abs(sarco_para_user_tcontr{sarco_para_user_counter}(i,2)-sarco_para_user_tcontr{sarco_para_user_counter}(i,1));
        plot(linspace(sarco_para_user_tcontr{sarco_para_user_counter}(i,1),sarco_para_user_tcontr{sarco_para_user_counter}(i,2),100),linspace(0,0,100),'r','LineWidth',5)
    end
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %sarcomean plot
    %plot 1st displ. in axes
    cla(h_para(1).axes_meansarco)
    axes(h_para(1).axes_meansarco)
    plot(dt{sarco_para_user_counter},sarco_para_user_meansarco{sarco_para_user_counter}*1e6,'-b'), hold on;
    plot(sarco_para_user_meansarco_min{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_min{sarco_para_user_counter}(:,2)*1e6,'.r'), hold on;
    plot(sarco_para_user_meansarco_max{sarco_para_user_counter}(:,1)/sarco_para_user_framerate{sarco_para_user_counter},sarco_para_user_meansarco_max{sarco_para_user_counter}(:,2)*1e6,'.g'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %preview
    cla(h_para(1).axes_preview)
    axes(h_para(1).axes_preview)
    s=load(['vars_DO_NOT_DELETE/',sarco_para_user_filenamestack{1,sarco_para_user_counter},'/image',num2str(sarco_para_user_relax{sarco_para_user_counter}),'.mat'],'imagei');
    image=s.imagei;
    imagesc(image); hold on;
    set(h_para(1).axes_preview,'xtick',[],'ytick',[])
    colormap('gray')
    freezeColors
    xp_s=sarco_para_user_outlinex{sarco_para_user_counter};
    yp_s=sarco_para_user_outliney{sarco_para_user_counter};
    plot([xp_s;xp_s(1)],[yp_s;yp_s(1)],'r')
    axis image;
    
    %for delta check radiobutton: does user want heatmap or histogram?
    if get(h_para(1).radiobutton_heatmap,'Value')
        %plot heatmaps
        reset(h_para(1).axes_delta)
        axes(h_para(1).axes_delta)
        imagesc(sarco_para_user_delta{sarco_para_user_counter}); hold on;
        colormap('jet')
        colorbar
        caxis([sarco_para_user_meandelta{sarco_para_user_counter}-2*sarco_para_user_stddelta{sarco_para_user_counter}, sarco_para_user_meandelta{sarco_para_user_counter}+2*sarco_para_user_stddelta{sarco_para_user_counter}])
        set(gca, 'XTick', []);
        set(gca, 'YTick', []);
        drawnow;
    elseif get(h_para(1).radiobutton_histogram,'Value')
        reset(h_para(1).axes_delta)
        axes(h_para(1).axes_delta)
        bdelta_vec = subsref(sarco_para_user_delta{sarco_para_user_counter}.', substruct('()', {':'})).';
        bdelta_vec(isnan(bdelta_vec))=[];
        hist(bdelta_vec,length(bdelta_vec))
        set(h_para(1).axes_delta, 'YTick', []);
    end
    
    
    %std movement angle
    cla(h_para(1).axes_stdangle)
    axes(h_para(1).axes_stdangle)
    plot(dt{sarco_para_user_counter},sarco_para_user_stdalpha{sarco_para_user_counter},'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %std orientation angle
    cla(h_para(1).axes_orient)
    axes(h_para(1).axes_orient)
    plot(dt{sarco_para_user_counter},sarco_para_user_stdangles{sarco_para_user_counter},'-b'), hold on;
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    %std sarco lengths
    cla(h_para(1).axes_stdsarco)
    axes(h_para(1).axes_stdsarco)
    plot(dt{sarco_para_user_counter},sarco_para_user_stdsarco{sarco_para_user_counter}*1e6,'-b'), hold on;
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
        x=sarco_para_user_para_freq{sarco_para_user_counter};
        y=sarco_para_user_para_freqy{sarco_para_user_counter};
        cla(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(freq{sarco_para_user_counter},y_fft{sarco_para_user_counter},'-b'), hold on;
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
        t_new=sarco_para_user_freq2{sarco_para_user_counter};
        x=1/(sarco_para_user_para_freq2{sarco_para_user_counter}+eps);
        cla(h_para(1).axes_freq)
        axes(h_para(1).axes_freq)
        plot(dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
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
    set(h_para(1).text_disp,'String',['dcontr=',num2str(sarco_para_user_para_Deltad{sarco_para_user_counter},'%.2e'),' [m]']);
    set(h_para(1).text_vel1,'String',['vcontr=',num2str(sarco_para_user_para_vcontr{sarco_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_vel2,'String',['vrelax=',num2str(sarco_para_user_para_vrelax{sarco_para_user_counter},'%.2e'),' [m/s]']);
    set(h_para(1).text_dp2_2,'String',['t=',num2str(sarco_para_user_para_tdp{sarco_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_contr,'String',['tcontr=',num2str(sarco_para_user_para_tcontr{sarco_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_delta1,'String',['mean delta=',num2str(sarco_para_user_meandelta{sarco_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_delta2,'String',['std delta=',num2str(sarco_para_user_stddelta{sarco_para_user_counter},'%.2e'),' [s]']);
    set(h_para(1).text_stdangle,'String',['mean of the std of movement angles =',num2str(nanmean(sarco_para_user_stdalpha{sarco_para_user_counter}),'%.2e'),' [deg]']);
    set(h_para(1).text_conc,'String',['concentration = ',num2str(sarco_para_user_concentration{sarco_para_user_counter})]);
    set(h_para(1).text_orient,'String',['mean of the std of orientation angles =',num2str(nanmean(sarco_para_user_stdangles{sarco_para_user_counter}),'%.2e'),' [deg]']);
    set(h_para(1).text_stdsarco,'String',['mean of the std of sarcomeres =',num2str(nanmean(sarco_para_user_stdsarco{sarco_para_user_counter}),'%.2e'),' [m]']);
    set(h_para(1).text_meansarco2,'String',['av. short. =',num2str(sarco_para_user_para_meansarco_max{sarco_para_user_counter}-sarco_para_user_para_meansarco_min{sarco_para_user_counter},'%.2e'),' [m]']);
    set(h_para(1).text_meansarco1,'String',['mean ms =',num2str(sarco_para_user_para_meansarco_mean{sarco_para_user_counter},'%.2e'),' [m]']);
    
    %set texts to 1st vid
    set(h_para(1).text_whichvidname,'String',sarco_para_user_filenamestack{1,sarco_para_user_counter});
    set(h_para(1).text_whichvid,'String',[num2str(sarco_para_user_counter),'/',num2str(sarco_para_user_totnum)]);
    
    
    
    %forward /backbutton
    if sarco_para_user_counter==1
        set(h_para(1).button_backwards,'Enable','off');
    else
        set(h_para(1).button_backwards,'Enable','on');
    end
    if sarco_para_user_counter==sarco_para_user_totnum
        set(h_para(1).button_forwards,'Enable','off');
    else
        set(h_para(1).button_forwards,'Enable','on');
    end
    
    %shared data
    setappdata(0,'sarco_para_user_para_ratiop',sarco_para_user_para_ratiop);
    setappdata(0,'sarco_para_user_para_ratiodp',sarco_para_user_para_ratiodp);
    setappdata(0,'sarco_para_user_counter',sarco_para_user_counter);
    
    
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
sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');
sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
sarco_init_user_pathnamestack=getappdata(0,'sarco_init_user_pathnamestack');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
sarco_para_user_para_ratiop=getappdata(0,'sarco_para_user_para_ratiop');
sarco_para_user_para_Deltad=getappdata(0,'sarco_para_user_para_Deltad');
sarco_para_user_para_vrelax=getappdata(0,'sarco_para_user_para_vrelax');
sarco_para_user_para_vcontr=getappdata(0,'sarco_para_user_para_vcontr');
sarco_para_user_stdalpha=getappdata(0,'sarco_para_user_stdalpha');
sarco_para_user_stddelta=getappdata(0,'sarco_para_user_stddelta');
sarco_para_user_para_tcontr=getappdata(0,'sarco_para_user_para_tcontr');
sarco_para_user_para_freq=getappdata(0,'sarco_para_user_para_freq');
sarco_para_user_para_freq2=getappdata(0,'sarco_para_user_para_freq2');
sarco_para_user_para_tag=getappdata(0,'sarco_para_user_para_tag');
sarco_para_user_para_tagdp=getappdata(0,'sarco_para_user_para_tagdp');
sarco_para_user_para_ratiodp=getappdata(0,'sarco_para_user_para_ratiodp');
sarco_para_user_para_tdp=getappdata(0,'sarco_para_user_para_tdp');
sarco_para_user_dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_delta=getappdata(0,'sarco_para_user_delta');
sarco_para_user_velocity=getappdata(0,'sarco_para_user_velocity');
sarco_conc_user_counter_roi=getappdata(0,'sarco_conc_user_counter_roi');
sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');
sarco_para_user_stdsarco=getappdata(0,'sarco_para_user_stdsarco');
sarco_para_user_stdangles=getappdata(0,'sarco_para_user_stdangles');
sarco_para_user_concentration=getappdata(0,'sarco_para_user_concentration');
sarco_para_user_para_meansarco_mean=getappdata(0,'sarco_para_user_para_meansarco_mean');
sarco_para_user_para_meansarco_max=getappdata(0,'sarco_para_user_para_meansarco_max');
sarco_para_user_para_meansarco_min=getappdata(0,'sarco_para_user_para_meansarco_min');
sarco_para_user_meansarco=getappdata(0,'sarco_para_user_meansarco');
sarco_para_user_meandelta=getappdata(0,'sarco_para_user_meandelta');

%save current stuff
sarco_para_user_para_ratiop{sarco_para_user_counter}=str2double(get(h_para(1).edit_ratio,'String'));
if sarco_para_user_para_tagdp{sarco_para_user_counter}
sarco_para_user_para_ratiodp{sarco_para_user_counter}=str2double(get(h_para(1).edit_dp2,'String'));
end 

%save para to excel
roiadd=0;
%loop over videos
for ivid=1:sarco_init_user_Nfiles
    %waitbar
    sb=statusbar(h_para(1).fig,['Saving parameters... ',num2str(floor(100*(ivid-1)/sum(sarco_init_user_Nfiles))), '%% done']);
    sb.getComponent(0).setForeground(java.awt.Color.red);
    %
    newfile=[sarco_init_user_pathnamestack{1,ivid},'/',sarco_init_user_filenamestack{1,ivid},'/Results/',sarco_init_user_filenamestack{1,ivid},'.xls'];
    A = {sarco_para_user_para_ratiop{ivid+roiadd},sarco_para_user_para_Deltad{ivid+roiadd},sarco_para_user_para_vrelax{ivid+roiadd},sarco_para_user_para_vcontr{ivid+roiadd}...
        sarco_para_user_para_tcontr{ivid+roiadd},sarco_para_user_para_freq{ivid+roiadd},sarco_para_user_para_freq2{ivid+roiadd},sarco_para_user_para_meansarco_max{ivid+roiadd}-sarco_para_user_para_meansarco_min{ivid+roiadd}...
        sarco_para_user_para_meansarco_mean{ivid+roiadd},nanmean(sarco_para_user_stdsarco{ivid+roiadd}),sarco_para_user_concentration{ivid+roiadd},nanmean(sarco_para_user_stdangles{ivid+roiadd}),nanmean(sarco_para_user_stdalpha{ivid+roiadd})...
        sarco_para_user_stddelta{ivid+roiadd},sarco_para_user_para_tag{ivid+roiadd},sarco_para_user_para_tagdp{ivid+roiadd},sarco_para_user_para_ratiodp{ivid+roiadd},sarco_para_user_para_tdp{ivid+roiadd}};
    sheet = 'Parameters';
    xlRange = 'A3';
    xlwrite(newfile,A,sheet,xlRange)
    
    %rois
    if sarco_conc_user_counter_roi(ivid)
        %loop over rois
        for roi=1:sarco_conc_user_number_roi(ivid)
            %new sheet, copy first 2 lines (titles)
            [~,txt,~]=xlsread(newfile,'Parameters','A1:R2');
            xlwrite(newfile,txt,['Parameters ROI',num2str(roi)],'A1:R2')
            %
            A = {sarco_para_user_para_ratiop{ivid+roiadd+roi},sarco_para_user_para_Deltad{ivid+roiadd+roi},sarco_para_user_para_vrelax{ivid+roiadd+roi},sarco_para_user_para_vcontr{ivid+roiadd+roi}...
                sarco_para_user_para_tcontr{ivid+roiadd+roi},sarco_para_user_para_freq{ivid+roiadd+roi},sarco_para_user_para_freq2{ivid+roiadd+roi},sarco_para_user_para_meansarco_max{ivid+roiadd+roi}-sarco_para_user_para_meansarco_min{ivid+roiadd+roi}...
                sarco_para_user_para_meansarco_mean{ivid+roiadd+roi},nanmean(sarco_para_user_stdsarco{ivid+roiadd+roi}),sarco_para_user_concentration{ivid+roiadd+roi},nanmean(sarco_para_user_stdangles{ivid+roiadd+roi}),nanmean(sarco_para_user_stdalpha{ivid+roiadd+roi})...
                sarco_para_user_stddelta{ivid+roiadd+roi},sarco_para_user_para_tag{ivid+roiadd+roi},sarco_para_user_para_tagdp{ivid+roiadd+roi},sarco_para_user_para_ratiodp{ivid+roiadd+roi},sarco_para_user_para_tdp{ivid+roiadd+roi}};
            sheet = ['Parameters ROI',num2str(roi)];
            xlRange = 'A3';
            xlwrite(newfile,A,sheet,xlRange)
        end
        roiadd=roiadd+sarco_conc_user_number_roi(ivid);
    end
    
end

%statusbar
sb=statusbar(h_para(1).fig,'Saving - Done !');
sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));

%save curve data
    roiadd=0;
    %loop over videos
    for ivid=1:sarco_init_user_Nfiles
        
            %waitbar
            sb=statusbar(h_para(1).fig,['Saving curve data... ',num2str(floor(100*(ivid-1)/sum(sarco_init_user_Nfiles))), '%% done']);
            sb.getComponent(0).setForeground(java.awt.Color.red);
            
            %file and sheet
            newfile=[sarco_init_user_pathnamestack{1,ivid},'/',sarco_init_user_filenamestack{1,ivid},'/Results/',sarco_init_user_filenamestack{1,ivid},'.xls'];
            sheet = 'Curves';
            %loop over time pts
            for ifr=1:sarco_init_user_Nframes{ivid}
                %displ.
                A = {sarco_para_user_dt{ivid+roiadd}(ifr),sarco_para_user_d{ivid+roiadd}(ifr)};
                xlRange = ['A',num2str(2+ifr)];
                xlwrite(newfile,A,sheet,xlRange)
                %veloc
                A = {sarco_para_user_dt{ivid+roiadd}(ifr),sarco_para_user_velocity{ivid+roiadd}(ifr)};
                xlRange = ['D',num2str(2+ifr)];
                xlwrite(newfile,A,sheet,xlRange)
                %mean sarco
                A = {sarco_para_user_dt{ivid+roiadd}(ifr),sarco_para_user_meansarco{ivid+roiadd}(ifr)};
                xlRange = ['G',num2str(2+ifr)];
                xlwrite(newfile,A,sheet,xlRange)
                %std sarco
                A = {sarco_para_user_dt{ivid+roiadd}(ifr),sarco_para_user_stdsarco{ivid+roiadd}(ifr)};
                xlRange = ['J',num2str(2+ifr)];
                xlwrite(newfile,A,sheet,xlRange)
                %std smyobril angle
                A = {sarco_para_user_dt{ivid+roiadd}(ifr),sarco_para_user_stdangles{ivid+roiadd}(ifr)};
                xlRange = ['M',num2str(2+ifr)];
                xlwrite(newfile,A,sheet,xlRange)
                %std displacement angle
                A = {sarco_para_user_dt{ivid+roiadd}(ifr),sarco_para_user_stdalpha{ivid+roiadd}(ifr)};
                xlRange = ['P',num2str(2+ifr)];
                xlwrite(newfile,A,sheet,xlRange)
            end
            
            %rois
            if sarco_conc_user_counter_roi(ivid)
                %loop over rois
                for roi=1:sarco_conc_user_number_roi(ivid)
                    %new sheet, copy first 2 lines (titles)
                    [~,txt,~]=xlsread(newfile,'Curves','A1:Q2');
                    xlwrite(newfile,txt,['Curves ROI',num2str(roi)],'A1:Q2')
                    %
                    %sheet
                    sheet = ['Curves ROI',num2str(roi)];
                    %loop over time pts
                    for ifr=1:sarco_init_user_Nframes{ivid+roiadd}
                        %displ.
                        A = {sarco_para_user_dt{ivid+roiadd+roi}(ifr),sarco_para_user_d{ivid+roiadd+roi}(ifr)};
                        xlRange = ['A',num2str(2+ifr)];
                        xlwrite(newfile,A,sheet,xlRange)
                        %veloc
                        A = {sarco_para_user_dt{ivid+roiadd+roi}(ifr),sarco_para_user_velocity{ivid+roiadd+roi}(ifr)};
                        xlRange = ['D',num2str(2+ifr)];
                        xlwrite(newfile,A,sheet,xlRange)
                        %mean sarco
                        A = {sarco_para_user_dt{ivid+roiadd+roi}(ifr),sarco_para_user_meansarco{ivid+roiadd+roi}(ifr)};
                        xlRange = ['G',num2str(2+ifr)];
                        xlwrite(newfile,A,sheet,xlRange)
                        %std sarco
                        A = {sarco_para_user_dt{ivid+roiadd+roi}(ifr),sarco_para_user_stdsarco{ivid+roiadd+roi}(ifr)};
                        xlRange = ['J',num2str(2+ifr)];
                        xlwrite(newfile,A,sheet,xlRange)
                        %std smyobril angle
                        A = {sarco_para_user_dt{ivid+roiadd+roi}(ifr),sarco_para_user_stdangles{ivid+roiadd+roi}(ifr)};
                        xlRange = ['M',num2str(2+ifr)];
                        xlwrite(newfile,A,sheet,xlRange)
                        %std displacement angle
                        A = {sarco_para_user_dt{ivid+roiadd+roi}(ifr),sarco_para_user_stdalpha{ivid+roiadd+roi}(ifr)};
                        xlRange = ['P',num2str(2+ifr)];
                        xlwrite(newfile,A,sheet,xlRange)
                    end
                end
                roiadd=roiadd+sarco_conc_user_number_roi(ivid);
            end
            
    end
    %statusbar
    sb=statusbar(h_para(1).fig,'Saving - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
        
    
    %check if user wants to save plotsa
    value = get(h_para(1).checkbox_save, 'Value');
    
    if value
        roiadd=0;
        %loop over videos
        for ivid=1:sarco_init_user_Nfiles
            if isequal(exist([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots'], 'dir'),7)
                rmdir([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots'],'s')
            end
            %make output folder for displacements
            mkdir([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots'])
            
            %waitbar
            sb=statusbar(h_para(1).fig,['Saving curve plots... ',num2str(floor(100*(ivid-1)/sum(sarco_init_user_Nfiles))), '%% done']);
            sb.getComponent(0).setForeground(java.awt.Color.red);
            
            %d
            sh=figure('Visible','off');
            plot(sarco_para_user_dt{ivid+roiadd},sarco_para_user_d{ivid+roiadd})
            title('Displacement')
            xlabel('Time [s]')
            ylabel('Average displacement [m]')
            %set(sh,'Visible','on')
            savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/displacement']);
            export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/displacement'],'-png','-m2',sh);
            close(sh);
            %vel
            sh=figure('Visible','off');
            plot(sarco_para_user_dt{ivid+roiadd},sarco_para_user_velocity{ivid+roiadd})
            title('Velocity')
            xlabel('Time [s]')
            ylabel('Velocity [m/s]')
            %set(sh,'Visible','on')
            savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/velocity']);
            export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/velocity'],'-png','-m2',sh);
            close(sh);
            
            %heatmaps
            sh=figure('Visible','off');
            imagesc(sarco_para_user_delta{ivid+roiadd}); hold on;
            colormap('jet')
            colorbar
            caxis([sarco_para_user_meandelta{ivid+roiadd}-2*sarco_para_user_stddelta{ivid+roiadd}, sarco_para_user_meandelta{ivid+roiadd}+2*sarco_para_user_stddelta{ivid+roiadd}])
            set(gca, 'XTick', []);
            set(gca, 'YTick', []);
            title('Synchronicity offset [s]')
            %set(sh,'Visible','on')
            savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/heatmap_delta']);
            export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/heatmap_delta'],'-png','-m2',sh);
            close(sh);
            
            %hist
            sh=figure('Visible','off');
            bdelta_vec = subsref(sarco_para_user_delta{ivid+roiadd}.', substruct('()', {':'})).';
            bdelta_vec(isnan(bdelta_vec))=[];
            hist(bdelta_vec,length(bdelta_vec))
            title('Synchronicity offset [s]')
            %set(sh,'Visible','on')
            savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/hist_delta']);
            export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/hist_delta'],'-png','-m2',sh);
            close(sh);
            
            %angle
            %std
            sh=figure('Visible','off');
            plot(sarco_para_user_dt{ivid+roiadd},sarco_para_user_stdalpha{ivid+roiadd},'-b'), hold on;
            title('Deviation movement angles')
            xlabel('Time [s]')
            ylabel('Angle [degrees]')
            %set(sh,'Visible','on')
            savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdangle']);
            export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdangle'],'-png','-m2',sh);
            close(sh);
            
            %meansarco
            sh=figure('Visible','off');
            plot(sarco_para_user_dt{ivid+roiadd},sarco_para_user_meansarco{ivid+roiadd},'-b'), hold on;
            title('Mean sarcomere length')
            xlabel('Time [s]')
            ylabel('Sarcomere length [micron]')
            %set(sh,'Visible','on')
            savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/meansarco']);
            export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/meansarco'],'-png','-m2',sh);
            close(sh);
            
            %stdsarco
            sh=figure('Visible','off');
            plot(sarco_para_user_dt{ivid+roiadd},sarco_para_user_stdsarco{ivid+roiadd},'-b'), hold on;
            title('Std sarcomere length')
            xlabel('Time [s]')
            ylabel('Deviation of sarcomere length [micron]')
            %set(sh,'Visible','on')
            savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdsarco']);
            export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdsarco'],'-png','-m2',sh);
            close(sh);
            
            %stdorient
            sh=figure('Visible','off');
            plot(sarco_para_user_dt{ivid+roiadd},sarco_para_user_stdangles{ivid+roiadd},'-b'), hold on;
            title('Deviation myofibril angles')
            xlabel('Time [s]')
            ylabel('Angle [degrees]')
            %set(sh,'Visible','on')
            savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdorient']);
            export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdorient'],'-png','-m2',sh);
            close(sh);
            
            if sarco_conc_user_counter_roi(ivid)
                %loop over rois
                for roi=1:sarco_conc_user_number_roi(ivid)
                    %d
                    sh=figure('Visible','off');
                    plot(sarco_para_user_dt{ivid+roiadd+roi},sarco_para_user_d{ivid+roiadd+roi})
                    title('Displacement')
                    xlabel('Time [s]')
                    ylabel('Average displacement [m]')
                    %set(sh,'Visible','on')
                    savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/displacement_roi',num2str(roi)]);
                    export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/displacement_roi',num2str(roi)],'-png','-m2',sh);
                    close(sh);
                    %vel
                    sh=figure('Visible','off');
                    plot(sarco_para_user_dt{ivid+roiadd+roi},sarco_para_user_velocity{ivid+roiadd+roi})
                    title('Velocity')
                    xlabel('Time [s]')
                    ylabel('Velocity [m/s]')
                    %set(sh,'Visible','on')
                    savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/velocity_roi',num2str(roi)]);
                    export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/velocity_roi',num2str(roi)],'-png','-m2',sh);
                    close(sh);
                    %heatmaps
                    sh=figure('Visible','off');
                    imagesc(sarco_para_user_delta{ivid+roiadd+roi}); hold on;
                    colormap('jet')
                    colorbar
                    caxis([sarco_para_user_meandelta{ivid+roiadd+roi}-2*sarco_para_user_stddelta{ivid+roiadd+roi}, sarco_para_user_meandelta{ivid+roiadd+roi}+2*sarco_para_user_stddelta{ivid+roiadd+roi}])
                    set(gca, 'XTick', []);
                    set(gca, 'YTick', []);
                    title('Synchronicity offset [s]')
                    %set(sh,'Visible','on')
                    savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/heatmap_delta_roi',num2str(roi)]);
                    export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/heatmap_delta_roi',num2str(roi)],'-png','-m2',sh);
                    close(sh);
                    
                    %hist
                    sh=figure('Visible','off');
                    bdelta_vec = subsref(sarco_para_user_delta{ivid+roiadd+roi}.', substruct('()', {':'})).';
                    bdelta_vec(isnan(bdelta_vec))=[];
                    hist(bdelta_vec,length(bdelta_vec))
                    title('Synchronicity offset [s]')
                    %set(sh,'Visible','on')
                    savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/hist_delta_roi',num2str(roi)]);
                    export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/hist_delta_roi',num2str(roi)],'-png','-m2',sh);
                    close(sh);
                    
                    %angle
                    %std
                    sh=figure('Visible','off');
                    plot(sarco_para_user_dt{ivid+roiadd+roi},sarco_para_user_stdalpha{ivid+roiadd+roi},'-b'), hold on;
                    title('Deviation movement angles')
                    xlabel('Time [s]')
                    ylabel('Angle [degrees]')
                    %set(sh,'Visible','on')
                    savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdangle_roi',num2str(roi)]);
                    export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdangle_roi',num2str(roi)],'-png','-m2',sh);
                    close(sh);
                    
                    %meansarco
                    sh=figure('Visible','off');
                    plot(sarco_para_user_dt{ivid+roiadd+roi},sarco_para_user_meansarco{ivid+roiadd+roi},'-b'), hold on;
                    title('Mean sarcomere length')
                    xlabel('Time [s]')
                    ylabel('Sarcomere length [micron]')
                    %set(sh,'Visible','on')
                    savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/meansarco_roi',num2str(roi)]);
                    export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/meansarco_roi',num2str(roi)],'-png','-m2',sh);
                    close(sh);
                    
                    %stdsarco
                    sh=figure('Visible','off');
                    plot(sarco_para_user_dt{ivid+roiadd+roi},sarco_para_user_stdsarco{ivid+roiadd+roi},'-b'), hold on;
                    title('Std sarcomere length')
                    xlabel('Time [s]')
                    ylabel('Deviation of sarcomere length [micron]')
                    %set(sh,'Visible','on')
                    savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdsarco_roi',num2str(roi)]);
                    export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdsarco_roi',num2str(roi)],'-png','-m2',sh);
                    close(sh);
                    
                    %stdorient
                    sh=figure('Visible','off');
                    plot(sarco_para_user_dt{ivid+roiadd+roi},sarco_para_user_stdangles{ivid+roiadd+roi},'-b'), hold on;
                    title('Deviation myofibril angles')
                    xlabel('Time [s]')
                    ylabel('Angle [degrees]')
                    %set(sh,'Visible','on')
                    savefig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdorient_roi',num2str(roi)]);
                    export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Curve Plots/stdorient_roi',num2str(roi)],'-png','-m2',sh);
                    close(sh);
                end
                roiadd=roiadd+sarco_conc_user_number_roi(ivid);
            end
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

%move main window to the side
movegui(h_main(1).fig,'center')

function para_buttongroup_freq(hObject, eventdata, h_para)
%load shared needed para
sarco_para_user_d=getappdata(0,'sarco_para_user_d');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');
freq=getappdata(0,'sarco_para_user_freq');
y_fft=getappdata(0,'sarco_para_user_y_fft');
dt=getappdata(0,'sarco_para_user_dt');
sarco_para_user_para_freq=getappdata(0,'sarco_para_user_para_freq');
sarco_para_user_para_freqy=getappdata(0,'sarco_para_user_para_freqy');
sarco_para_user_freq2=getappdata(0,'sarco_para_user_freq2');
sarco_para_user_para_freq2=getappdata(0,'sarco_para_user_para_freq2');

if get(h_para(1).radiobutton_fft,'Value')
    %make unwanted buttons invisible
    set(h_para(1).button_freq_add,'Visible','off');
    set(h_para(1).button_freq_remove,'Visible','off');
    set(h_para(1).button_freq_clearall,'Visible','off');
    %enable wanted button
    set(h_para(1).button_freq_addfft,'Visible','on');
    %plot frequency. in axes
    x=sarco_para_user_para_freq{sarco_para_user_counter};
    y=sarco_para_user_para_freqy{sarco_para_user_counter};
    cla(h_para(1).axes_freq)
    axes(h_para(1).axes_freq)
    plot(freq{sarco_para_user_counter},y_fft{sarco_para_user_counter},'-b'), hold on;
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
    t_new=sarco_para_user_freq2{sarco_para_user_counter};
    x2=1/(sarco_para_user_para_freq2{sarco_para_user_counter}+eps);
    
    cla(h_para(1).axes_freq)
    axes(h_para(1).axes_freq)
    plot(dt{sarco_para_user_counter},sarco_para_user_d{sarco_para_user_counter}*1e6,'-b'), hold on;
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
    
    %set correct strings
    set(h_para(1).text_freq1,'String',['f=',num2str(1/(x2+eps),'%.2e'),' [Hz]']);
    set(h_para(1).text_freq2,'String',['T=',num2str(x2,'%.2e'),' [s]']);
    
    %save new pt vector
    sarco_para_user_para_freq2{sarco_para_user_counter}=1/(x2+eps);
end

setappdata(0,'sarco_para_user_para_freq2',sarco_para_user_para_freq2);

function para_buttongroup_delta(hObject, eventdata, h_para)
%get shared
sarco_para_user_delta=getappdata(0,'sarco_para_user_delta');
sarco_para_user_meandelta=getappdata(0,'sarco_para_user_meandelta');
sarco_para_user_stddelta=getappdata(0,'sarco_para_user_stddelta');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');

%for delta check radiobutton: does user want heatmap or histogram?
if get(h_para(1).radiobutton_heatmap,'Value')
%plot heatmaps
reset(h_para(1).axes_delta)
axes(h_para(1).axes_delta)
imshow(sarco_para_user_delta{sarco_para_user_counter},[]); hold on;
colormap(h_para(1).axes_delta,'jet')
colorbar;
caxis([sarco_para_user_meandelta{sarco_para_user_counter}-2*sarco_para_user_stddelta{sarco_para_user_counter}, sarco_para_user_meandelta{sarco_para_user_counter}+2*sarco_para_user_stddelta{sarco_para_user_counter}])    
set(gca, 'XTick', []);
set(gca, 'YTick', []);
elseif get(h_para(1).radiobutton_histogram,'Value')
    bdelta_vec = subsref(sarco_para_user_delta{sarco_para_user_counter}.', substruct('()', {':'})).';
    bdelta_vec(isnan(bdelta_vec))=[];
    reset(h_para(1).axes_delta)
    axes(h_para(1).axes_delta)
    [h1, x1]=hist(bdelta_vec,length(bdelta_vec));
    bar(x1,h1);
    set(h_para(1).axes_delta,'xtick',[],'ytick',[])
end

function para_checkbox_dpyes(hObject, eventdata, h_para)
set(h_para(1).panel_dp2,'Visible','on');
set(h_para(1).checkbox_dpno,'Value',0);

sarco_para_user_para_tagdp=getappdata(0,'sarco_para_user_para_tagdp');
sarco_para_user_para_ratiodp=getappdata(0,'sarco_para_user_para_ratiodp');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');

%yes: tag dp
if get(h_para(1).checkbox_dpyes,'Value');
    sarco_para_user_para_tagdp{sarco_para_user_counter}=1;
else
    sarco_para_user_para_tagdp{sarco_para_user_counter}=0;
end
set(h_para(1).edit_dp2,'String',num2str(sarco_para_user_para_ratiodp{sarco_para_user_counter}))
setappdata(0,'sarco_para_user_para_tagdp',sarco_para_user_para_tagdp);

function para_checkbox_dpno(hObject, eventdata, h_para)
set(h_para(1).panel_dp2,'Visible','off');
set(h_para(1).checkbox_dpyes,'Value',0);

sarco_para_user_para_tagdp=getappdata(0,'sarco_para_user_para_tagdp');
sarco_para_user_counter=getappdata(0,'sarco_para_user_counter');

%yes: tag dp
if ~get(h_para(1).checkbox_dpno,'Value');
    sarco_para_user_para_tagdp{sarco_para_user_counter}=1;
else
    sarco_para_user_para_tagdp{sarco_para_user_counter}=0;
end
setappdata(0,'sarco_para_user_para_tagdp',sarco_para_user_para_tagdp);

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