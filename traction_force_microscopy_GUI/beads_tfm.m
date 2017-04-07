%beads_tfm.m ; part of the beads GUI: execute beads_main.m
%version 2.0
%written by O. Schwab (oschwab@stanford.edu)
%last change: 10/30/14

function beads_tfm(h_main)
%main function for the tfm window of beads gui

%create new window for tfm
%fig size
figsize=[450,800];
%get screen size
screensize = get(0,'ScreenSize');
%position fig on center of screen
xpos = ceil((screensize(3)-figsize(2))/2);
ypos = ceil((screensize(4)-figsize(1))/2);
%create fig; invisible at first
h_tfm(1).fig=figure(...
    'position',[xpos, ypos, figsize(2), figsize(1)],...
    'units','pixels',...
    'renderer','OpenGL',...
    'MenuBar','none',...
    'PaperPositionMode','auto',...
    'Name','Beads Traction Forces',...
    'NumberTitle','off',...
    'Resize','off',...
    'Color',[.94,.94,.94],...
    'visible','off');

%create uipanel for smartguess
%uipanel
h_tfm(1).panel_guess = uipanel('Parent',h_tfm(1).fig,'Title','Regularization','units','pixels','Position',[630,390,100,50]);
%button
h_tfm(1).button_guess = uicontrol('Parent',h_tfm(1).panel_guess,'style','pushbutton','position',[5,5,87,25],'string','Guess all');

%create uipanel for settings
%uipanel
h_tfm(1).panel_settings = uipanel('Parent',h_tfm(1).fig,'Title','Settings','units','pixels','Position',[20,335,605,105]);
%text: regul
h_tfm(1).text_regul = uicontrol('Parent',h_tfm(1).panel_settings,'style','text','position',[5,75,100,15],'string','Regularization','HorizontalAlignment','left');
%text: youngs
h_tfm(1).text_youngs = uicontrol('Parent',h_tfm(1).panel_settings,'style','text','position',[5,60,100,15],'string','Substrate Young"s','HorizontalAlignment','left');
%text: poisson
h_tfm(1).text_poisson = uicontrol('Parent',h_tfm(1).panel_settings,'style','text','position',[5,45,100,15],'string','Substrate Poisson"s','HorizontalAlignment','left');
%text:traction limits
h_tfm(1).text_limits = uicontrol('Parent',h_tfm(1).panel_settings,'style','text','position',[180,70,100,15],'string','Visualization limits','HorizontalAlignment','left');
%text:tmin
h_tfm(1).text_tmin = uicontrol('Parent',h_tfm(1).panel_settings,'style','text','position',[180,50,35,15],'string','T min.','HorizontalAlignment','left');
%text:tmax
h_tfm(1).text_tmax = uicontrol('Parent',h_tfm(1).panel_settings,'style','text','position',[230,50,35,15],'string','T max.','HorizontalAlignment','left');
%edit: regul
h_tfm(1).edit_regul = uicontrol('Parent',h_tfm(1).panel_settings,'style','edit','position',[105,75,40,15],'HorizontalAlignment','center');
%edit: youngs
h_tfm(1).edit_youngs = uicontrol('Parent',h_tfm(1).panel_settings,'style','edit','position',[105,60,40,15],'HorizontalAlignment','center','String','1e4');
%edit: poissons
h_tfm(1).edit_poisson = uicontrol('Parent',h_tfm(1).panel_settings,'style','edit','position',[105,45,40,15],'HorizontalAlignment','center','String','0.4');
%radiobuttongroup
h_tfm(1).buttongroup_constrain = uibuttongroup('Parent',h_tfm(1).panel_settings,'Units', 'pixels','Position',[5,5,142,40]);
%radiobutton 1: unconstrained
h_tfm(1).radiobutton_uncontrained = uicontrol('Parent',h_tfm(1).buttongroup_constrain,'style','radiobutton','position',[5,19,130,18],'string','unconstrained analysis','tag','radiobutton_unconstrained');
%radiobutton 1: constrained
h_tfm(1).radiobutton_constrained = uicontrol('Parent',h_tfm(1).buttongroup_constrain,'style','radiobutton','position',[5,1,130,18],'string','constrained analysis','tag','radiobutton_constrained');
%edit: tmin
h_tfm(1).edit_tmin = uicontrol('Parent',h_tfm(1).panel_settings,'style','edit','position',[180,35,35,15],'HorizontalAlignment','center');
%edit: tmax
h_tfm(1).edit_tmax = uicontrol('Parent',h_tfm(1).panel_settings,'style','edit','position',[230,35,35,15],'HorizontalAlignment','center');
%button: update
h_tfm(1).button_update = uicontrol('Parent',h_tfm(1).panel_settings,'style','pushbutton','position',[177,5,92,25],'string','Update preview');
%axes:
h_tfm(1).axes_settings = axes('Parent',h_tfm(1).panel_settings,'Units', 'pixels','Position',[285,5,200,85]);
%button: calculate all
h_tfm(1).button_calc = uicontrol('Parent',h_tfm(1).panel_settings,'style','pushbutton','position',[490,5,100,25],'string','Calculate all');
%button: forwards
h_tfm(1).button_forwards = uicontrol('Parent',h_tfm(1).panel_settings,'style','pushbutton','position',[515,67,25,25],'string','>');
%button: backwards
h_tfm(1).button_backwards = uicontrol('Parent',h_tfm(1).panel_settings,'style','pushbutton','position',[490,67,25,25],'string','<');
%text: show which video (i/n)
h_tfm(1).text_whichvid = uicontrol('Parent',h_tfm(1).panel_settings,'style','text','position',[545,75,25,15],'string','(1/1)','HorizontalAlignment','left');
%text: show which video (name)
h_tfm(1).text_whichvidname = uicontrol('Parent',h_tfm(1).panel_settings,'style','text','position',[490,50,100,15],'string','Experiment','HorizontalAlignment','left');

%uipanel for tfm calc preview
h_tfm(1).panel_tfm = uipanel('Parent',h_tfm(1).fig,'units','pixels','Position',[20,25,760,305]);
h_tfm(1).axes_tfm = axes('Parent',h_tfm(1).panel_tfm,'Units', 'pixels','Position',[10,10,737,285]);

%create ok button
h_tfm(1).button_ok = uicontrol('Parent',h_tfm(1).fig,'style','pushbutton','position',[735,413,45,20],'string','OK','visible','on');
%create matrix save checkbox
h_tfm(1).checkbox_matrix = uicontrol('Parent',h_tfm(1).fig,'style','checkbox','position',[630,335,160,15],'string','Save traction matrices','HorizontalAlignment','left');
%create heatmaps save checkbox
h_tfm(1).checkbox_heatmaps = uicontrol('Parent',h_tfm(1).fig,'style','checkbox','position',[630,355,160,15],'string','Save heatmaps','HorizontalAlignment','left');

%callbacks for buttons and buttongroup
set(h_tfm(1).button_guess,'callback',{@tfm_push_guess,h_tfm})
set(h_tfm(1).button_update,'callback',{@tfm_push_update,h_tfm})
set(h_tfm(1).button_calc,'callback',{@tfm_push_calc,h_tfm})
set(h_tfm(1).button_forwards,'callback',{@tfm_push_forwards,h_tfm})
set(h_tfm(1).button_backwards,'callback',{@tfm_push_backwards,h_tfm})
set(h_tfm(1).button_ok,'callback',{@tfm_push_ok,h_tfm,h_main})
set(h_tfm(1).buttongroup_constrain,'SelectionChangeFcn',{@tfm_buttongroup_constrain,h_tfm})

%upon window openeing: make elements visible?unvisible
set(h_tfm(1).panel_settings,'visible','off')
set(h_tfm(1).panel_tfm,'visible','off')
set(h_tfm(1).button_ok,'visible','off')
set(h_tfm(1).checkbox_matrix,'visible','off')
set(h_tfm(1).checkbox_heatmaps,'visible','off')

%initiate counter
tfm_tfm_user_counter=1;

%store everything for shared use
setappdata(0,'tfm_tfm_user_counter',tfm_tfm_user_counter)

%make fig visible
set(h_tfm(1).fig,'visible','on');

%move main window to the side
movegui(h_main(1).fig,'west')

function tfm_push_guess(hObject, eventdata, h_tfm)
%disable figure during calculation
enableDisableFig(h_tfm(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_tfm(1).fig,1));

try
    %load shared needed para
    tfm_init_user_conversion=getappdata(0,'tfm_init_user_conversion');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_init_user_Nframes=getappdata(0,'tfm_init_user_Nframes');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_tfm_user_counter=getappdata(0,'tfm_tfm_user_counter');
    tfm_init_user_binary1=getappdata(0,'tfm_init_user_binary1');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_piv_user_contr=getappdata(0,'tfm_piv_user_contr');
    
    %initial values
    E=str2double(get(h_tfm(1).edit_youngs,'String'));
    nu=str2double(get(h_tfm(1).edit_poisson,'String'));
    
    %initialize
    tfm_tfm_user_E=cell(1,tfm_init_user_Nfiles);
    tfm_tfm_user_nu=cell(1,tfm_init_user_Nfiles);
    tfm_tfm_user_lambda=cell(1,tfm_init_user_Nfiles);
    tfm_tfm_user_clims=cell(1,tfm_init_user_Nfiles);
    tfm_tfm_user_preview_V=cell(1,tfm_init_user_Nfiles);
    tfm_tfm_user_preview_x1=cell(1,tfm_init_user_Nfiles);
    tfm_tfm_user_preview_y1=cell(1,tfm_init_user_Nfiles);
    tfm_tfm_user_preview_u1_0=cell(1,tfm_init_user_Nfiles);
    tfm_tfm_user_preview_v1_0=cell(1,tfm_init_user_Nfiles);
    tfm_tfm_user_constraintval=ones(1,tfm_init_user_Nfiles);
    
    
    %waitbar
    %hf = waitbar(0,'SmartGuessing. Please wait...');
    for current_vid=1:tfm_init_user_Nfiles
        %hf=waitbar(current_vid/tfm_init_user_Nfiles,hf);
        %statusbar
        sb=statusbar(h_tfm(1).fig,['Calculating... ',num2str(floor(100*(current_vid-1)/tfm_init_user_Nfiles)), '%% done']);
        sb.getComponent(0).setForeground(java.awt.Color.red);
        
        %get displacmenets from calc. before        
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_x_1.mat'],'x');
            tfm_piv_user_xs=s.x;
            s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_y_1.mat'],'y');
        
        %mask
        %tfm_piv_user_dismask=double(tfm_init_user_binary1{current_vid}(tfm_piv_user_ys{1,1}(:,1) ,tfm_piv_user_xs{1,1}(1,:)));
        tfm_piv_user_dismask=ones(size(tfm_piv_user_xs));
        
        %
        contr=tfm_piv_user_contr{current_vid};
        relax=tfm_piv_user_relax{current_vid};
        
        %save inital values
        tfm_tfm_user_E{current_vid}=E;
        tfm_tfm_user_nu{current_vid}=nu;     
       
        %tfm between relax and contr
        [ ~,x1,y1,~,~,u1_0,v1_0,V,lambda,~,~] = calculate_tfm_regul(tfm_init_user_filenamestack{1,current_vid},relax,contr,contr,tfm_piv_user_dismask,E,nu,tfm_init_user_conversion{current_vid});
        
        %save for later use
        [Xqu,Yqu]=meshgrid(x1(1):x1(end),y1(1):y1(end));
        maskV=double(tfm_init_user_binary1{current_vid}(Yqu(:,1) ,Xqu(1,:)));
        tfm_tfm_user_preview_V{current_vid}=V;
        tfm_tfm_user_preview_x1{current_vid}=x1;
        tfm_tfm_user_preview_y1{current_vid}=y1;
        tfm_tfm_user_preview_u1_0{current_vid}=u1_0;
        tfm_tfm_user_preview_v1_0{current_vid}=v1_0;
        tfm_tfm_user_lambda{current_vid}=lambda;
        tfm_tfm_user_clims{current_vid}=[.2*max(max(V.*maskV)),.8*max(max(V.*maskV))];
        
    end
    %new statusbar text
    sb=statusbar(h_tfm(1).fig,'SmartGuessing - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %make second panel visible
    set(h_tfm(1).panel_settings,'Visible','on');
    
    %%now display this info for 1st video.
    set(h_tfm(1).edit_regul,'String',num2str(tfm_tfm_user_lambda{tfm_tfm_user_counter}));
    set(h_tfm(1).edit_tmin,'String',num2str(tfm_tfm_user_clims{tfm_tfm_user_counter}(1)));
    set(h_tfm(1).edit_tmax,'String',num2str(tfm_tfm_user_clims{tfm_tfm_user_counter}(2)));
        
    
    %plot heat plot
    axes(h_tfm(1).axes_settings);
    imagesc( tfm_tfm_user_preview_V{tfm_tfm_user_counter},tfm_tfm_user_clims{tfm_tfm_user_counter}); axis image; colormap jet; hold on;
    %quiver(tfm_tfm_user_preview_x1{1},tfm_tfm_user_preview_y1{1},tfm_tfm_user_preview_u1_0{1},tfm_tfm_user_preview_v1_0{1},'r');
    set(h_tfm(1).axes_settings, 'XTick', []);
    set(h_tfm(1).axes_settings, 'YTick', []);
    
    %disable backwards button
    set(h_tfm(1).button_backwards,'Enable','off');
    %if vid<vidtot, enable forward button
    if 1==tfm_init_user_Nfiles
        set(h_tfm(1).button_forwards,'Enable','off');
    end
    %disable regularization edit
    set(h_tfm(1).edit_regul,'Enable','off');
        
    %store everything for shared use
    setappdata(0,'tfm_tfm_user_E',tfm_tfm_user_E)
    setappdata(0,'tfm_tfm_user_nu',tfm_tfm_user_nu)
    setappdata(0,'tfm_tfm_user_lambda',tfm_tfm_user_lambda)
    setappdata(0,'tfm_tfm_user_clims',tfm_tfm_user_clims)
    setappdata(0,'tfm_tfm_user_preview_V',tfm_tfm_user_preview_V)
    setappdata(0,'tfm_tfm_user_preview_x1',tfm_tfm_user_preview_x1)
    setappdata(0,'tfm_tfm_user_preview_y1',tfm_tfm_user_preview_y1)
    setappdata(0,'tfm_tfm_user_preview_u1_0',tfm_tfm_user_preview_u1_0)
    setappdata(0,'tfm_tfm_user_preview_v1_0',tfm_tfm_user_preview_v1_0)
    setappdata(0,'tfm_tfm_user_constraintval',tfm_tfm_user_constraintval)
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function tfm_push_update(hObject, eventdata, h_tfm)
%disable figure during calculation
enableDisableFig(h_tfm(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_tfm(1).fig,1));

try
    %load shared needed para
    tfm_init_user_conversion=getappdata(0,'tfm_init_user_conversion');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_init_user_binary0=getappdata(0,'tfm_init_user_binary0');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_piv_user_contr=getappdata(0,'tfm_piv_user_contr');
    tfm_tfm_user_E=getappdata(0,'tfm_tfm_user_E');
    tfm_tfm_user_nu=getappdata(0,'tfm_tfm_user_nu');
    tfm_tfm_user_lambda=getappdata(0,'tfm_tfm_user_lambda');
    tfm_tfm_user_clims=getappdata(0,'tfm_tfm_user_clims');
    tfm_tfm_user_preview_V=getappdata(0,'tfm_tfm_user_preview_V');
    tfm_tfm_user_preview_x1=getappdata(0,'tfm_tfm_user_preview_x1');
    tfm_tfm_user_preview_y1=getappdata(0,'tfm_tfm_user_preview_y1');
    tfm_tfm_user_preview_u1_0=getappdata(0,'tfm_tfm_user_preview_u1_0');
    tfm_tfm_user_preview_v1_0=getappdata(0,'tfm_tfm_user_preview_v1_0');
    tfm_tfm_user_counter=getappdata(0,'tfm_tfm_user_counter');
    tfm_tfm_user_constraintval=getappdata(0,'tfm_tfm_user_constraintval');
    
    %statusbar
    sb=statusbar(h_tfm(1).fig,'Updating');
    sb.getComponent(0).setForeground(java.awt.Color(1,0,0));
    
    %which vid are we at?
    current_vid=tfm_tfm_user_counter;
    
    %read values
    E=str2double(get(h_tfm(1).edit_youngs,'String'));
    nu=str2double(get(h_tfm(1).edit_poisson,'String'));
    clims = [str2double(get(h_tfm(1).edit_tmin,'String')),str2double(get(h_tfm(1).edit_tmax,'String'))];
    
       
    s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_x_1.mat'],'x');
    tfm_piv_user_xs=s.x;
    s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,current_vid},'/piv_y_1.mat'],'y');
    tfm_piv_user_ys=s.y;
    
    
    %mask
    tfm_piv_user_dismask0=double(tfm_init_user_binary0{current_vid}(tfm_piv_user_ys(:,1) ,tfm_piv_user_xs(1,:)));
    mask_all=ones(size(tfm_piv_user_ys));
    %
    contr=tfm_piv_user_contr{current_vid};
    relax=tfm_piv_user_relax{current_vid};
    
    %save inital values
    tfm_tfm_user_E{current_vid}=E;
    tfm_tfm_user_nu{current_vid}=nu;
    tfm_tfm_user_clims{current_vid}=clims;
    
    %tfm between relax and contr
    if tfm_tfm_user_constraintval(tfm_tfm_user_counter)==1 %unconstrained
    [ ~,x1,y1,~,~,u1_0,v1_0,V,~,~,~,~,~,~,~] = calculate_tfm(tfm_init_user_filenamestack{1,current_vid},relax,contr,contr,mask_all,E,nu,tfm_tfm_user_lambda{current_vid},tfm_init_user_conversion{current_vid});
    elseif tfm_tfm_user_constraintval(tfm_tfm_user_counter)==2 %constrained
    [ ~,x1,y1,~,~,u1_0,v1_0,V,~,~,~,~,~,~,~] = calculate_tfm_constrain(tfm_init_user_filenamestack{1,current_vid},relax,contr,contr,mask_all,tfm_piv_user_dismask0,E,nu,tfm_init_user_conversion{current_vid}); 
    end
    
    %save for later use
    %[Xqu,Yqu]=meshgrid(x1(1):x1(end),y1(1):y1(end));
    %maskV=double(tfm_init_user_binary1{current_vid}(Yqu(:,1) ,Xqu(1,:)));
    tfm_tfm_user_preview_V{current_vid}=V;
    tfm_tfm_user_preview_x1{current_vid}=x1;
    tfm_tfm_user_preview_y1{current_vid}=y1;
    tfm_tfm_user_preview_u1_0{current_vid}=u1_0;
    tfm_tfm_user_preview_v1_0{current_vid}=v1_0;
    
    %new statusbar text
    sb=statusbar(h_tfm(1).fig,'Update - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %plot heat plot
    axes(h_tfm(1).axes_settings);
    imagesc( tfm_tfm_user_preview_V{tfm_tfm_user_counter},clims); axis image; colormap jet; hold on;
    %quiver(tfm_tfm_user_preview_x1{1},tfm_tfm_user_preview_y1{1},tfm_tfm_user_preview_u1_0{1},tfm_tfm_user_preview_v1_0{1},'r');
    set(h_tfm(1).axes_settings, 'XTick', []);
    set(h_tfm(1).axes_settings, 'YTick', []);
    
    if tfm_tfm_user_counter==1;
        set(h_tfm(1).button_backwards,'Enable','off');
    else
        set(h_tfm(1).button_backwards,'Enable','on');
    end
    if tfm_tfm_user_counter<tfm_init_user_Nfiles
        set(h_tfm(1).button_forwards,'Enable','on');
    else
        set(h_tfm(1).button_forwards,'Enable','off');
    end
    %disable regularization edit
    set(h_tfm(1).edit_regul,'Enable','off');
    
    %store everything for shared use
    setappdata(0,'tfm_tfm_user_E',tfm_tfm_user_E)
    setappdata(0,'tfm_tfm_user_nu',tfm_tfm_user_nu)
    
    
    setappdata(0,'tfm_tfm_user_clims',tfm_tfm_user_clims)
    setappdata(0,'tfm_tfm_user_preview_V',tfm_tfm_user_preview_V)
    setappdata(0,'tfm_tfm_user_preview_x1',tfm_tfm_user_preview_x1)
    setappdata(0,'tfm_tfm_user_preview_y1',tfm_tfm_user_preview_y1)
    setappdata(0,'tfm_tfm_user_preview_u1_0',tfm_tfm_user_preview_u1_0)
    setappdata(0,'tfm_tfm_user_preview_v1_0',tfm_tfm_user_preview_v1_0)
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function tfm_push_calc(hObject, eventdata, h_tfm)
%disable figure during calculation
enableDisableFig(h_tfm(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_tfm(1).fig,1));

try
    
    %load what shared para we need
    tfm_init_user_conversion=getappdata(0,'tfm_init_user_conversion');
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_init_user_Nframes=getappdata(0,'tfm_init_user_Nframes');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_tfm_user_E=getappdata(0,'tfm_tfm_user_E');
    tfm_tfm_user_nu=getappdata(0,'tfm_tfm_user_nu');
    tfm_tfm_user_lambda=getappdata(0,'tfm_tfm_user_lambda');
    tfm_tfm_user_clims=getappdata(0,'tfm_tfm_user_clims');
    tfm_piv_user_relax=getappdata(0,'tfm_piv_user_relax');
    tfm_piv_user_contr=getappdata(0,'tfm_piv_user_contr');
    tfm_init_user_binary0=getappdata(0,'tfm_init_user_binary0');
    tfm_tfm_user_constraintval=getappdata(0,'tfm_tfm_user_constraintval');
    tfm_init_user_pathnamestack=getappdata(0,'tfm_init_user_pathnamestack');
    tfm_init_user_outline2x=getappdata(0,'tfm_init_user_outline2x');
    tfm_init_user_outline2y=getappdata(0,'tfm_init_user_outline2y');
    
    w_i=0;
    for ivid=1:tfm_init_user_Nfiles
        %create folder to save disp.
        mkdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots'])
        mkdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Traction Heatmaps'])
        
        
        Num=tfm_init_user_Nframes{ivid};
        %
        s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_x_1.mat'],'x');
        tfm_piv_user_xs=s.x;
        s=load(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/piv_y_1.mat'],'y');
        tfm_piv_user_ys=s.y;
        for frame=1:Num
            %statusbar
            w_i=w_i+1;
            sb=statusbar(h_tfm(1).fig,['Calculating... ',num2str(floor(100*(w_i-1)/sum([tfm_init_user_Nframes{:}]))), '%% done']);
            sb.getComponent(0).setForeground(java.awt.Color.red);
            
            %get settings
            E=tfm_tfm_user_E{ivid};
            nu=tfm_tfm_user_nu{ivid};
            lambda=tfm_tfm_user_lambda{ivid};
            clims=tfm_tfm_user_clims{ivid};
            
            %mask
            tfm_piv_user_dismask0=double(tfm_init_user_binary0{ivid}(tfm_piv_user_ys(:,1) ,tfm_piv_user_xs(1,:)));
            mask_all=ones(size(tfm_piv_user_ys));
            
            %
            contr=tfm_piv_user_contr{ivid};
            relax=tfm_piv_user_relax{ivid};
            
            %tfm
            if tfm_tfm_user_constraintval(ivid)==1 %unconstrained
                [ ~,xr,yr,ur,vr,u1_0,v1_0,V,absd,Fx,Fy,F,Trx,Try,v] = calculate_tfm(tfm_init_user_filenamestack{1,ivid},tfm_piv_user_relax{ivid},tfm_piv_user_contr{ivid},frame,mask_all,E,nu,lambda,tfm_init_user_conversion{ivid});
            elseif tfm_tfm_user_constraintval(ivid)==2 %constrained
                [ ~,xr,yr,ur,vr,u1_0,v1_0,V,absd,Fx,Fy,F,Trx,Try,v] = calculate_tfm_constrain(tfm_init_user_filenamestack{1,ivid},relax,contr,frame,mask_all,tfm_piv_user_dismask0,E,nu,tfm_init_user_conversion{ivid});
            end
                        
            %save to mat
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_xr_',num2str(frame),'.mat'],'xr','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_yr_',num2str(frame),'.mat'],'yr','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_ur_',num2str(frame),'.mat'],'ur','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_vr_',num2str(frame),'.mat'],'vr','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_absd_',num2str(frame),'.mat'],'absd','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_Fx_',num2str(frame),'.mat'],'Fx','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_Fy_',num2str(frame),'.mat'],'Fy','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_F_',num2str(frame),'.mat'],'F','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_Trx_',num2str(frame),'.mat'],'Trx','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_Try_',num2str(frame),'.mat'],'Try','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_v_',num2str(frame),'.mat'],'v','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_V_',num2str(frame),'.mat'],'V','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_u1_0_',num2str(frame),'.mat'],'u1_0','-v7.3')
            save(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_v1_0_',num2str(frame),'.mat'],'v1_0','-v7.3')
                        
            %plot heat plot
            reset(h_tfm(1).axes_tfm)
            cla(h_tfm(1).axes_tfm)
            axes(h_tfm(1).axes_tfm);
            imagesc( V,clims); colormap jet;colorbar; hold on;
            plot(tfm_init_user_outline2x{ivid},tfm_init_user_outline2y{ivid},'g','LineWidth',1);
            %quiver(x1,y1,u1_0,v1_0,'r');
            set(h_tfm(1).axes_tfm, 'XTick', []);
            set(h_tfm(1).axes_tfm, 'YTick', []);
            set(h_tfm(1).panel_tfm,'visible','on')
            
            %save?
            p=figure('visible','off');
            imagesc( V,clims); colormap jet;colorbar; hold on;
            plot(tfm_init_user_outline2x{ivid},tfm_init_user_outline2y{ivid},'g','LineWidth',1);
            set(gca,'xtick',[],'ytick',[])
            axis image;
            export_fig([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Traction Heatmaps/heatmap',int2str(frame)],'-png','-m2',p);
            close(p)
        end
    end
    %statusbar
    sb=statusbar(h_tfm(1).fig,'Calculation - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %ok button and checkboxes
    set(h_tfm(1).button_ok,'Visible','on');
    set(h_tfm(1).checkbox_heatmaps,'Visible','on');
    set(h_tfm(1).checkbox_matrix,'Visible','on');
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function tfm_push_forwards(hObject, eventdata, h_tfm)
%disable figure during calculation
enableDisableFig(h_tfm(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_tfm(1).fig,1));

%load what shared para we need
tfm_tfm_user_counter=getappdata(0,'tfm_tfm_user_counter');
tfm_tfm_user_preview_V=getappdata(0,'tfm_tfm_user_preview_V');
tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
tfm_tfm_user_E=getappdata(0,'tfm_tfm_user_E');
tfm_tfm_user_nu=getappdata(0,'tfm_tfm_user_nu');
tfm_tfm_user_lambda=getappdata(0,'tfm_tfm_user_lambda');
tfm_tfm_user_clims=getappdata(0,'tfm_tfm_user_clims');
tfm_tfm_user_constraintval=getappdata(0,'tfm_tfm_user_constraintval');

%save current stuff
E=str2double(get(h_tfm(1).edit_youngs,'String'));
nu=str2double(get(h_tfm(1).edit_poisson,'String'));
clims = [str2double(get(h_tfm(1).edit_tmin,'String')),str2double(get(h_tfm(1).edit_tmax,'String'))];
tfm_tfm_user_E{tfm_tfm_user_counter}=E;
tfm_tfm_user_nu{tfm_tfm_user_counter}=nu;
tfm_tfm_user_clims{tfm_tfm_user_counter}=clims;

%go to video before
tfm_tfm_user_counter=tfm_tfm_user_counter+1;

%put the correct values for new count in boxes:
set(h_tfm(1).edit_youngs,'String',num2str(tfm_tfm_user_E{tfm_tfm_user_counter}));
set(h_tfm(1).edit_poisson,'String',num2str(tfm_tfm_user_nu{tfm_tfm_user_counter}));
set(h_tfm(1).edit_regul,'String',num2str(tfm_tfm_user_lambda{tfm_tfm_user_counter}));
set(h_tfm(1).edit_tmin,'String',num2str(tfm_tfm_user_clims{tfm_tfm_user_counter}(1)));
set(h_tfm(1).edit_tmax,'String',num2str(tfm_tfm_user_clims{tfm_tfm_user_counter}(2)));

%plot heat plot
axes(h_tfm(1).axes_settings);
cla(h_tfm(1).axes_settings)
imagesc( tfm_tfm_user_preview_V{tfm_tfm_user_counter},tfm_tfm_user_clims{tfm_tfm_user_counter}); axis image; colormap jet;colorbar; hold on;
set(h_tfm(1).axes_settings, 'XTick', []);
set(h_tfm(1).axes_settings, 'YTick', []);

%set texts to vid
set(h_tfm(1).text_whichvidname,'String',tfm_init_user_filenamestack{1,tfm_tfm_user_counter});
set(h_tfm(1).text_whichvid,'String',[num2str(tfm_tfm_user_counter),'/',num2str(tfm_init_user_Nfiles)]);

%constrained / unconstrained
if tfm_tfm_user_constraintval(tfm_tfm_user_counter)==1
        set(h_tfm(1).edit_regul,'visible','on')
        set(h_tfm(1).text_regul,'visible','on')
        set(h_tfm(1).radiobutton_uncontrained,'value',1)
elseif tfm_tfm_user_constraintval(tfm_tfm_user_counter)==2
        set(h_tfm(1).edit_regul,'visible','off')
        set(h_tfm(1).text_regul,'visible','off')
        set(h_tfm(1).radiobutton_uncontrained,'value',0)
end

if tfm_tfm_user_counter==1;
        set(h_tfm(1).button_backwards,'Enable','off');
    else
        set(h_tfm(1).button_backwards,'Enable','on');
    end
    if tfm_tfm_user_counter<tfm_init_user_Nfiles
        set(h_tfm(1).button_forwards,'Enable','on');
    else
        set(h_tfm(1).button_forwards,'Enable','off');
    end

%store everything for shared use
setappdata(0,'tfm_tfm_user_E',tfm_tfm_user_E)
setappdata(0,'tfm_tfm_user_nu',tfm_tfm_user_nu)
setappdata(0,'tfm_tfm_user_lambda',tfm_tfm_user_lambda)
setappdata(0,'tfm_tfm_user_clims',tfm_tfm_user_clims)
setappdata(0,'tfm_tfm_user_counter',tfm_tfm_user_counter)

function tfm_push_backwards(hObject, eventdata, h_tfm)
%disable figure during calculation
enableDisableFig(h_tfm(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_tfm(1).fig,1));

%load what shared para we need
tfm_tfm_user_counter=getappdata(0,'tfm_tfm_user_counter');
tfm_tfm_user_preview_V=getappdata(0,'tfm_tfm_user_preview_V');
tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
tfm_tfm_user_E=getappdata(0,'tfm_tfm_user_E');
tfm_tfm_user_nu=getappdata(0,'tfm_tfm_user_nu');
tfm_tfm_user_lambda=getappdata(0,'tfm_tfm_user_lambda');
tfm_tfm_user_clims=getappdata(0,'tfm_tfm_user_clims');
tfm_tfm_user_constraintval=getappdata(0,'tfm_tfm_user_constraintval');

%save current stuff
E=str2double(get(h_tfm(1).edit_youngs,'String'));
nu=str2double(get(h_tfm(1).edit_poisson,'String'));
clims = [str2double(get(h_tfm(1).edit_tmin,'String')),str2double(get(h_tfm(1).edit_tmax,'String'))];
tfm_tfm_user_E{tfm_tfm_user_counter}=E;
tfm_tfm_user_nu{tfm_tfm_user_counter}=nu;
tfm_tfm_user_clims{tfm_tfm_user_counter}=clims;

%go to video before
tfm_tfm_user_counter=tfm_tfm_user_counter-1;

%put the correct values for new count in boxes:
set(h_tfm(1).edit_youngs,'String',num2str(tfm_tfm_user_E{tfm_tfm_user_counter}));
set(h_tfm(1).edit_poisson,'String',num2str(tfm_tfm_user_nu{tfm_tfm_user_counter}));
set(h_tfm(1).edit_regul,'String',num2str(tfm_tfm_user_lambda{tfm_tfm_user_counter}));
set(h_tfm(1).edit_tmin,'String',num2str(tfm_tfm_user_clims{tfm_tfm_user_counter}(1)));
set(h_tfm(1).edit_tmax,'String',num2str(tfm_tfm_user_clims{tfm_tfm_user_counter}(2)));

%plot heat plot
axes(h_tfm(1).axes_settings);
cla(h_tfm(1).axes_settings)
imagesc( tfm_tfm_user_preview_V{tfm_tfm_user_counter},tfm_tfm_user_clims{tfm_tfm_user_counter}); axis image; colormap jet;colorbar; hold on;
set(h_tfm(1).axes_settings, 'XTick', []);
set(h_tfm(1).axes_settings, 'YTick', []);

%set texts to vid
set(h_tfm(1).text_whichvidname,'String',tfm_init_user_filenamestack{1,tfm_tfm_user_counter});
set(h_tfm(1).text_whichvid,'String',[num2str(tfm_tfm_user_counter),'/',num2str(tfm_init_user_Nfiles)]);

%constrained / unconstrained
if tfm_tfm_user_constraintval(tfm_tfm_user_counter)==1
        set(h_tfm(1).edit_regul,'visible','on')
        set(h_tfm(1).text_regul,'visible','on')
        set(h_tfm(1).radiobutton_uncontrained,'value',1)
elseif tfm_tfm_user_constraintval(tfm_tfm_user_counter)==2
        set(h_tfm(1).edit_regul,'visible','off')
        set(h_tfm(1).text_regul,'visible','off')
        set(h_tfm(1).radiobutton_uncontrained,'value',0)
end

if tfm_tfm_user_counter==1;
        set(h_tfm(1).button_backwards,'Enable','off');
    else
        set(h_tfm(1).button_backwards,'Enable','on');
    end
    if tfm_tfm_user_counter<tfm_init_user_Nfiles
        set(h_tfm(1).button_forwards,'Enable','on');
    else
        set(h_tfm(1).button_forwards,'Enable','off');
    end

%store everything for shared use
setappdata(0,'tfm_tfm_user_E',tfm_tfm_user_E)
setappdata(0,'tfm_tfm_user_nu',tfm_tfm_user_nu)
setappdata(0,'tfm_tfm_user_lambda',tfm_tfm_user_lambda)
setappdata(0,'tfm_tfm_user_clims',tfm_tfm_user_clims)
setappdata(0,'tfm_tfm_user_counter',tfm_tfm_user_counter)

function tfm_push_ok(hObject, eventdata, h_tfm, h_main)
%disable figure during calculation
enableDisableFig(h_tfm(1).fig,0);

try
    %load what shared para we need
    tfm_init_user_Nfiles=getappdata(0,'tfm_init_user_Nfiles');
    tfm_init_user_Nframes=getappdata(0,'tfm_init_user_Nframes');
    tfm_init_user_filenamestack=getappdata(0,'tfm_init_user_filenamestack');
    tfm_init_user_pathnamestack=getappdata(0,'tfm_init_user_pathnamestack');
     
    %check if user wants to save
    value = get(h_tfm(1).checkbox_matrix, 'Value');
    
    if value
        w_i=0;
        %loop over videos
        for ivid=1:tfm_init_user_Nfiles
            %make output folder for displacements
            if ~isequal(exist([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Traction Forces'], 'dir'),7)
                mkdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Traction Forces'])
            end
            
            %loop over frames
            for ifr=1:tfm_init_user_Nframes{ivid}
                %waitbar
                w_i=w_i+1;
                sb=statusbar(h_tfm(1).fig,['Saving full fields... ',num2str(floor(100*(w_i-1)/sum([tfm_init_user_Nframes{:}]))), '%% done']);
                sb.getComponent(0).setForeground(java.awt.Color.red);
                %copy displacements
                copyfile(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_xr_',num2str(ifr),'.mat'],[tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Traction Forces/tfm_xr_',num2str(ifr),'.mat']);
                copyfile(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_yr_',num2str(ifr),'.mat'],[tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Traction Forces/tfm_yr_',num2str(ifr),'.mat']);
                copyfile(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_Trx_',num2str(ifr),'.mat'],[tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Traction Forces/tfm_Trx_',num2str(ifr),'.mat']);
                copyfile(['vars_DO_NOT_DELETE/',tfm_init_user_filenamestack{1,ivid},'/tfm_Try_',num2str(ifr),'.mat'],[tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Datasets/Traction Forces/tfm_Try_',num2str(ifr),'.mat']);
            end
        end
        %statusbar
        sb=statusbar(h_tfm(1).fig,'Saving - Done !');
        sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    end
    
    %check if user wants to save heatmaps
    value = get(h_tfm(1).checkbox_heatmaps, 'Value');
    
    if ~value
        for ivid=1:tfm_init_user_Nfiles
        rmdir([tfm_init_user_pathnamestack{1,ivid},tfm_init_user_filenamestack{1,ivid},'/Plots/Traction Heatmaps'],'s')
        end
    end
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

%enable fig
enableDisableFig(h_tfm(1).fig,1)

%change main windows 3. button status
set(h_main(1).button_tfm,'ForegroundColor',[0 .5 0]);
set(h_main(1).button_para,'Enable','on');

%close window
close(h_tfm(1).fig);

%move main window to the side
movegui(h_main(1).fig,'center')

function tfm_buttongroup_constrain(hObject, eventdata, h_tfm)
%load
tfm_tfm_user_counter=getappdata(0,'tfm_tfm_user_counter');
tfm_tfm_user_constraintval=getappdata(0,'tfm_tfm_user_constraintval');

switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'radiobutton_unconstrained'
        tfm_tfm_user_constraintval(tfm_tfm_user_counter)=1;
        set(h_tfm(1).edit_regul,'visible','on')
        set(h_tfm(1).text_regul,'visible','on')
    case 'radiobutton_constrained'
        tfm_tfm_user_constraintval(tfm_tfm_user_counter)=2;
        set(h_tfm(1).edit_regul,'visible','off')
        set(h_tfm(1).text_regul,'visible','off')
end
setappdata(0,'tfm_tfm_user_constraintval',tfm_tfm_user_constraintval)