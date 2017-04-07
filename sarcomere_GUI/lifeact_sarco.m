%lifeact_sarco.m ; part of the Lifeact GUI: execute lifeact_main.m
%version 2.0
%written by O. Schwab (oschwab@stanford.edu)
%last change: 10/27/14

function lifeact_sarco(h_main)
%main function for the sarcomere analysis window of lifeact gui

%create new window for sarcomere analysis
%fig size
figsize=[450,800];
%get screen size
screensize = get(0,'ScreenSize');
%position fig on center of screen
xpos = ceil((screensize(3)-figsize(2))/2);
ypos = ceil((screensize(4)-figsize(1))/2);
%create fig; invisible at first
h_sarco(1).fig=figure(...
    'position',[xpos, ypos, figsize(2), figsize(1)],...
    'units','pixels',...
    'renderer','OpenGL',...
    'MenuBar','none',...
    'PaperPositionMode','auto',...
    'Name','Lifeact Sarcomere Analysis',...
    'NumberTitle','off',...
    'Resize','off',...
    'Color',[.94,.94,.94],...
    'visible','off');

%create uipanel for preliminary calc
%uipanel:
h_sarco(1).panel_prelim = uipanel('Parent',h_sarco(1).fig,'Title','Preliminary calculations','units','pixels','Position',[20,390,150,50]);
%button
h_sarco(1).button_prelim = uicontrol('Parent',h_sarco(1).panel_prelim,'style','pushbutton','position',[5,5,137,25],'string','Initial guess');

%create panel for sarcomere bounds
%uipanel:
h_sarco(1).panel_sarco = uipanel('Parent',h_sarco(1).fig,'Title','Sarcomere bounds','units','pixels','Position',[180,250,455,190]);
%button: open preview
h_sarco(1).button_openpreview = uicontrol('Parent',h_sarco(1).panel_sarco,'style','pushbutton','position',[5,5,137,25],'string','Open preview window');
%button: update preview
h_sarco(1).button_update = uicontrol('Parent',h_sarco(1).panel_sarco,'style','pushbutton','position',[5,30,137,25],'string','Update preview window');
%axes:
h_sarco(1).axes_sarco = axes('Parent',h_sarco(1).panel_sarco,'Units', 'pixels','Position',[145,5,300,170],'box','on');
%test: expected length
h_sarco(1).text_expected = uicontrol('Parent',h_sarco(1).panel_sarco,'style','text','position',[5,145,137,15],'string','Expected sarcomere length');
%test: micron
h_sarco(1).text_micron = uicontrol('Parent',h_sarco(1).panel_sarco,'style','text','position',[100,110,40,15],'string','micron');
%test: min
h_sarco(1).text_min = uicontrol('Parent',h_sarco(1).panel_sarco,'style','text','position',[10,125,40,15],'string','min');
%test: max
h_sarco(1).text_max = uicontrol('Parent',h_sarco(1).panel_sarco,'style','text','position',[50,125,40,15],'string','max');
%edit: min
h_sarco(1).edit_min = uicontrol('Parent',h_sarco(1).panel_sarco,'style','edit','position',[10,110,40,15],'string','1.5');
%edit: max
h_sarco(1).edit_max = uicontrol('Parent',h_sarco(1).panel_sarco,'style','edit','position',[50,110,40,15],'string','2.4');


%create panel for sarcomere overlay
%uipanel:
h_sarco(1).panel_overlay = uipanel('Parent',h_sarco(1).fig,'Title','Evaluate how well the blue and red skeletons match','units','pixels','Position',[20,30,765,215]);
%axes: left
h_sarco(1).axes_openleft = axes('Parent',h_sarco(1).panel_overlay,'Units', 'pixels','Position',[5,5,300,170],'box','on');
%axes: right
h_sarco(1).axes_openright = axes('Parent',h_sarco(1).panel_overlay,'Units', 'pixels','Position',[310,5,300,170],'box','on');
%button: open left
h_sarco(1).button_openleft = uicontrol('Parent',h_sarco(1).panel_overlay,'style','pushbutton','position',[5,175,300,25],'string','Open left overlay in new window');
%button: open right
h_sarco(1).button_openright = uicontrol('Parent',h_sarco(1).panel_overlay,'style','pushbutton','position',[310,175,300,25],'string','Open right overlay in new window');
%radiobutton group for user eval
h_sarco(1).buttongroup = uibuttongroup('Parent',h_sarco(1).panel_overlay,'Units', 'pixels','Position',[620,100,135,75]);
%radiobutton 1: good match
h_sarco(1).radiobutton_good = uicontrol('Parent',h_sarco(1).buttongroup,'style','radiobutton','position',[5,40,125,30],'string','<html>Good match:<br>Master skeleton','tag','radiobutton_good');
%radiobutton 1: good match
h_sarco(1).radiobutton_bad = uicontrol('Parent',h_sarco(1).buttongroup,'style','radiobutton','position',[5,5,125,30],'string','<html>Bad match:<br>Regular skeleton','tag','radiobutton_bad');

%button: calculate all
h_sarco(1).button_calc = uicontrol('Parent',h_sarco(1).fig,'style','pushbutton','position',[20,250,147,25],'string','Calculate all');
%button: forwards
h_sarco(1).button_forwards = uicontrol('Parent',h_sarco(1).fig,'style','pushbutton','position',[45,312,25,25],'string','>');
%button: backwards
h_sarco(1).button_backwards = uicontrol('Parent',h_sarco(1).fig,'style','pushbutton','position',[20,312,25,25],'string','<');
%text: show which video (i/n)
h_sarco(1).text_whichvid = uicontrol('Parent',h_sarco(1).fig,'style','text','position',[75,320,25,15],'string','(1/1)','HorizontalAlignment','left');
%text: show which video (name)
h_sarco(1).text_whichvidname = uicontrol('Parent',h_sarco(1).fig,'style','text','position',[20,295,100,15],'string','Experiment','HorizontalAlignment','left');

%create ok button
h_sarco(1).button_ok = uicontrol('Parent',h_sarco(1).fig,'style','pushbutton','position',[740,415,45,20],'string','OK','visible','on');
%create skeleton save checkbox
h_sarco(1).checkbox_skeleton = uicontrol('Parent',h_sarco(1).fig,'style','checkbox','position',[640,400,100,15],'string','Save skeleton','HorizontalAlignment','left');
%create heatmaps save checkbox
h_sarco(1).checkbox_heatmaps = uicontrol('Parent',h_sarco(1).fig,'style','checkbox','position',[640,385,100,15],'string','Save heatmaps','HorizontalAlignment','left');

%callbacks for buttons and buttongroup
set(h_sarco(1).button_prelim,'callback',{@sarco_push_prelim,h_sarco})
set(h_sarco(1).button_update,'callback',{@sarco_push_update,h_sarco})
set(h_sarco(1).button_openpreview,'callback',{@sarco_push_openpreview,h_sarco})
set(h_sarco(1).button_openleft,'callback',{@sarco_push_openleft,h_sarco})
set(h_sarco(1).button_openright,'callback',{@sarco_push_openright,h_sarco})
set(h_sarco(1).button_ok,'callback',{@sarco_push_ok,h_sarco,h_main})
set(h_sarco(1).button_backwards,'callback',{@sarco_push_backwards,h_sarco})
set(h_sarco(1).button_forwards,'callback',{@sarco_push_forwards,h_sarco})
set(h_sarco(1).button_calc,'callback',{@sarco_push_calc,h_sarco})
set(h_sarco(1).buttongroup,'SelectionChangeFcn',{@sarco_buttongroup,h_sarco})

%set buttongroup to empty
set(h_sarco(1).buttongroup,'SelectedObject',[])

%populate figure on launch
%load what shared para we need
sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');
sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');
sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');

%turn off buttons and panel
set(h_sarco(1).panel_sarco,'Visible','off');
set(h_sarco(1).panel_overlay,'Visible','off');
set(h_sarco(1).checkbox_skeleton,'Visible','off');
set(h_sarco(1).checkbox_heatmaps,'Visible','off');
set(h_sarco(1).text_whichvid,'Visible','off');
set(h_sarco(1).text_whichvidname,'Visible','off');
set(h_sarco(1).button_ok,'Visible','off');
set(h_sarco(1).button_backwards,'Visible','off');
set(h_sarco(1).button_forwards,'Visible','off');
set(h_sarco(1).button_calc,'Visible','off');

%set texts to 1st vid
set(h_sarco(1).text_whichvidname,'String',sarco_init_user_filenamestack{1,1});
set(h_sarco(1).text_whichvid,'String',[num2str(1),'/',num2str(sarco_init_user_Nfiles)]);

%fill min & max sarco range cells with intial values
sarco_sarco_user_minS=cell(1,sarco_init_user_Nfiles);
sarco_sarco_user_maxS=cell(1,sarco_init_user_Nfiles);
for ivid=1:sarco_init_user_Nfiles
    sarco_sarco_user_minS{ivid}=str2double(get(h_sarco(1).edit_min,'String'));
    sarco_sarco_user_maxS{ivid}=str2double(get(h_sarco(1).edit_max,'String'));
end

%preview cells for skeletons
sarco_sarco_user_preview1=cell(1,sarco_init_user_Nfiles);
sarco_sarco_user_preview2=cell(1,sarco_init_user_Nfiles);
sarco_sarco_user_preview3=cell(1,sarco_init_user_Nfiles);

%evaluation vector
sarco_sarco_user_evaluation=NaN*ones(1,sarco_init_user_Nfiles);

%cells for mean/std sarco, std angles
sarco_sarco_user_meansarco=cell(sarco_init_user_Nfiles,max([sarco_init_user_Nframes{:}]));
sarco_sarco_user_stdsarco=cell(sarco_init_user_Nfiles,max([sarco_init_user_Nframes{:}]));
sarco_sarco_user_stdangles=cell(sarco_init_user_Nfiles,max([sarco_init_user_Nframes{:}]));
sarco_sarco_user_meansarco_roi=cell(max(sarco_conc_user_number_roi),sarco_init_user_Nfiles,max([sarco_init_user_Nframes{:}]));
sarco_sarco_user_stdsarco_roi=cell(max(sarco_conc_user_number_roi),sarco_init_user_Nfiles,max([sarco_init_user_Nframes{:}]));
sarco_sarco_user_stdangles_roi=cell(max(sarco_conc_user_number_roi),sarco_init_user_Nfiles,max([sarco_init_user_Nframes{:}]));

%initiate counter
sarco_sarco_user_counter=1;

%store everything for shared use
setappdata(0,'sarco_sarco_user_counter',sarco_sarco_user_counter)
setappdata(0,'sarco_sarco_user_evaluation',sarco_sarco_user_evaluation)
setappdata(0,'sarco_sarco_user_minS',sarco_sarco_user_minS)
setappdata(0,'sarco_sarco_user_maxS',sarco_sarco_user_maxS)
setappdata(0,'sarco_sarco_user_preview1',sarco_sarco_user_preview1);
setappdata(0,'sarco_sarco_user_preview2',sarco_sarco_user_preview2);
setappdata(0,'sarco_sarco_user_preview3',sarco_sarco_user_preview3);
setappdata(0,'sarco_sarco_user_meansarco',sarco_sarco_user_meansarco);
setappdata(0,'sarco_sarco_user_stdsarco',sarco_sarco_user_stdsarco);
setappdata(0,'sarco_sarco_user_stdangles',sarco_sarco_user_stdangles);
setappdata(0,'sarco_sarco_user_meansarco_roi',sarco_sarco_user_meansarco_roi);
setappdata(0,'sarco_sarco_user_stdsarco_roi',sarco_sarco_user_stdsarco_roi);
setappdata(0,'sarco_sarco_user_stdangles_roi',sarco_sarco_user_stdangles_roi);

%make fig visible
set(h_sarco(1).fig,'visible','on');

%move main window to the side
movegui(h_main(1).fig,'west')

function sarco_push_prelim(hObject, eventdata, h_sarco)
%disable figure during calculation
enableDisableFig(h_sarco(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_sarco(1).fig,1));


try
    %load what shared para we need
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_sarco_user_minS=getappdata(0,'sarco_sarco_user_minS');
    sarco_sarco_user_maxS=getappdata(0,'sarco_sarco_user_maxS');
    sarco_sarco_user_counter=getappdata(0,'sarco_sarco_user_counter');
    sarco_sarco_user_preview1=getappdata(0,'sarco_sarco_user_preview1');
    sarco_sarco_user_preview2=getappdata(0,'sarco_sarco_user_preview2');
    sarco_sarco_user_preview3=getappdata(0,'sarco_sarco_user_preview3');
    sarco_conc_user_binarysarc=getappdata(0,'sarco_conc_user_binarysarc');
    sarco_conc_user_binary1=getappdata(0,'sarco_conc_user_binary1');
    sarco_piv_user_relax=getappdata(0,'sarco_piv_user_relax');
    sarco_piv_user_contr=getappdata(0,'sarco_piv_user_contr');
    
    %loop over videos
    for ivid=1:sarco_init_user_Nfiles
        %statusbar for calcs
        sb=statusbar(h_sarco(1).fig,['Preliminary calculations... ',num2str(floor(100*(ivid-1)/sarco_init_user_Nfiles)), '%% done']);
        sb.getComponent(0).setForeground(java.awt.Color.red);
        
        %initial values for parz from openingfct
        minS=floor(sarco_sarco_user_minS{ivid}/(sarco_init_user_conversion{ivid}));
        maxS=ceil(sarco_sarco_user_maxS{ivid}/(sarco_init_user_conversion{ivid}));
        
        %caluclate ridges for 1st frame
        file_vid=sarco_init_user_filenamestack{1,ivid};
        mask=sarco_conc_user_binarysarc{1,ivid}.*sarco_conc_user_binary1{1,ivid};
        sarco_sarco_user_preview1{ivid} = mask.* preview_ridges( file_vid, 1, minS, maxS );
        
        %caluclate ridges for relaxed frame
        BW_relax = preview_ridges( file_vid, sarco_piv_user_relax{ivid}, minS, maxS );
        
        %caluclate ridges for contracted frame
        BW_contr = preview_ridges( file_vid, sarco_piv_user_contr{ivid}, minS, maxS );
        
        %overlay 2 skeletons for preview2 and 3.
        %load the piv data between 1&relax
        s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_u_',num2str(sarco_piv_user_relax{ivid}),'.mat'],'fu');
        us_relax=s.fu;
        s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_v_',num2str(sarco_piv_user_relax{ivid}),'.mat'],'fv');
        vs_relax=s.fv;
        s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_x_',num2str(sarco_piv_user_relax{ivid}),'.mat'],'x');
        xs_relax=s.x;
        s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_y_',num2str(sarco_piv_user_relax{ivid}),'.mat'],'y');
        ys_relax=s.y;
        %load the piv data between 1&contracted
        s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_u_',num2str(sarco_piv_user_contr{ivid}),'.mat'],'fu');
        us_contr=s.fu;
        s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_v_',num2str(sarco_piv_user_contr{ivid}),'.mat'],'fv');
        vs_contr=s.fv;
        s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_x_',num2str(sarco_piv_user_contr{ivid}),'.mat'],'x');
        xs_contr=s.x;
        s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_y_',num2str(sarco_piv_user_contr{ivid}),'.mat'],'y');
        ys_contr=s.y;
        %new meshgrid for every pixel.
        [Xqu,Yqu]=meshgrid(1:size(sarco_sarco_user_preview1{ivid},2),1:size(sarco_sarco_user_preview1{ivid},1));
        Vt_relax = interp2(xs_relax,ys_relax,vs_relax,Xqu,Yqu,'linear');
        Ut_relax = interp2(xs_relax,ys_relax,us_relax,Xqu,Yqu,'linear');
        Vt_contr = interp2(xs_contr,ys_contr,vs_contr,Xqu,Yqu,'linear');
        Ut_contr = interp2(xs_contr,ys_contr,us_contr,Xqu,Yqu,'linear');
        %maxima locations
        [r_relax,c_relax]=find(BW_relax==1);
        [r_contr,c_contr]=find(BW_contr==1);
        %delete old maxima
        BW_relax(BW_relax==1)=0;
        BW_contr(BW_contr==1)=0;
        %calculate new maxima
        for i=1:length(r_relax)
            xxr=c_relax(i);
            yyr=r_relax(i);
            xxr=xxr-Ut_relax(round(yyr),round(xxr));
            yyr=yyr-Vt_relax(round(yyr),round(xxr));
            BW_relax(round(yyr),round(xxr))=1;
        end
        for i=1:length(r_contr)
            xxr=c_contr(i);
            yyr=r_contr(i);
            xxr=xxr-Ut_contr(round(yyr),round(xxr));
            yyr=yyr-Vt_contr(round(yyr),round(xxr));
            BW_contr(round(yyr),round(xxr))=1;
        end
        sarco_sarco_user_preview2{ivid}=BW_relax.*mask;
        sarco_sarco_user_preview3{ivid}=BW_contr.*mask;
        
    end
    
    %display the previews in the axes foir 1st vid
    cla(h_sarco(1).axes_sarco)
    axes(h_sarco(1).axes_sarco)
    imshow(imoverlay(sarco_init_user_preview_frame1{1},sarco_sarco_user_preview1{1},[1,0,0]));
    %overlays in 3 and 4
    cla(h_sarco(1).axes_openleft)
    axes(h_sarco(1).axes_openleft)
    imshow(imoverlay(imoverlay(sarco_init_user_preview_frame1{1},sarco_sarco_user_preview1{1},[1,0,0]),sarco_sarco_user_preview2{1},[0,0,1]));
    cla(h_sarco(1).axes_openright)
    axes(h_sarco(1).axes_openright)
    imshow(imoverlay(imoverlay(sarco_init_user_preview_frame1{1},sarco_sarco_user_preview1{1},[1,0,0]),sarco_sarco_user_preview3{1},[0,0,1]));
    
    %save
    setappdata(0,'sarco_sarco_user_preview1',sarco_sarco_user_preview1);
    setappdata(0,'sarco_sarco_user_preview2',sarco_sarco_user_preview2);
    setappdata(0,'sarco_sarco_user_preview3',sarco_sarco_user_preview3);
    
    %statusbar
    sb=statusbar(h_sarco(1).fig,'Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

%enable uipanel and make evrything visibel
set(h_sarco(1).panel_sarco,'Visible','on');
set(h_sarco(1).panel_overlay,'Visible','on');
set(h_sarco(1).text_whichvid,'Visible','on');
set(h_sarco(1).text_whichvidname,'Visible','on');
set(h_sarco(1).button_backwards,'Visible','on');
set(h_sarco(1).button_forwards,'Visible','on');
set(h_sarco(1).button_calc,'Visible','on');
%forward/back
if sarco_sarco_user_counter>1
    set(h_sarco(1).button_backwards,'Enable','on');
else
    set(h_sarco(1).button_backwards,'Enable','off');
end
if sarco_sarco_user_counter==sarco_init_user_Nfiles
    set(h_sarco(1).button_forwards,'Enable','off');
else
    set(h_sarco(1).button_forwards,'Enable','on');
end

function sarco_push_update(hObject, eventdata, h_sarco)
%disable figure during calculation
enableDisableFig(h_sarco(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_sarco(1).fig,1));

try
    %load what shared para we need
    sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_sarco_user_minS=getappdata(0,'sarco_sarco_user_minS');
    sarco_sarco_user_maxS=getappdata(0,'sarco_sarco_user_maxS');
    sarco_sarco_user_preview1=getappdata(0,'sarco_sarco_user_preview1');
    sarco_sarco_user_preview2=getappdata(0,'sarco_sarco_user_preview2');
    sarco_sarco_user_preview3=getappdata(0,'sarco_sarco_user_preview3');
    sarco_sarco_user_counter=getappdata(0,'sarco_sarco_user_counter');
    sarco_conc_user_binarysarc=getappdata(0,'sarco_conc_user_binarysarc');
    sarco_conc_user_binary1=getappdata(0,'sarco_conc_user_binary1');
    sarco_piv_user_relax=getappdata(0,'sarco_piv_user_relax');
    sarco_piv_user_contr=getappdata(0,'sarco_piv_user_contr');
    
    %statusbar for calcs
    sb=statusbar(h_sarco(1).fig,'Updating... ');
    sb.getComponent(0).setForeground(java.awt.Color.red);
    
    %read in new range parameters
    sarco_sarco_user_minS{sarco_sarco_user_counter}=str2double(get(h_sarco(1).edit_min,'String'));
    sarco_sarco_user_maxS{sarco_sarco_user_counter}=str2double(get(h_sarco(1).edit_max,'String'));
    
    %initial values for parz from openingfct
    minS=floor(sarco_sarco_user_minS{sarco_sarco_user_counter}/(sarco_init_user_conversion{sarco_sarco_user_counter}));
    maxS=ceil(sarco_sarco_user_maxS{sarco_sarco_user_counter}/(sarco_init_user_conversion{sarco_sarco_user_counter}));
    
    %caluclate ridges for 1st frame
    file_vid=sarco_init_user_filenamestack{1,sarco_sarco_user_counter};
    mask=sarco_conc_user_binarysarc{1,sarco_sarco_user_counter}.*sarco_conc_user_binary1{1,sarco_sarco_user_counter};
    sarco_sarco_user_preview1{sarco_sarco_user_counter} = mask.* preview_ridges( file_vid, 1, minS, maxS );
    
    %caluclate ridges for relaxed frame
    BW_relax = preview_ridges( file_vid, sarco_piv_user_relax{sarco_sarco_user_counter}, minS, maxS );
    
    %caluclate ridges for contracted frame
    BW_contr = preview_ridges( file_vid, sarco_piv_user_contr{sarco_sarco_user_counter}, minS, maxS );
    
    %overlay 2 skeletons for preview2 and 3.
    %load the piv data between 1&relax
    s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_u_',num2str(sarco_piv_user_relax{sarco_sarco_user_counter}),'.mat'],'fu');
    us_relax=s.fu;
    s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_v_',num2str(sarco_piv_user_relax{sarco_sarco_user_counter}),'.mat'],'fv');
    vs_relax=s.fv;
    s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_x_',num2str(sarco_piv_user_relax{sarco_sarco_user_counter}),'.mat'],'x');
    xs_relax=s.x;
    s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_y_',num2str(sarco_piv_user_relax{sarco_sarco_user_counter}),'.mat'],'y');
    ys_relax=s.y;
    %load the piv data between 1&contracted
    s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_u_',num2str(sarco_piv_user_contr{sarco_sarco_user_counter}),'.mat'],'fu');
    us_contr=s.fu;
    s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_v_',num2str(sarco_piv_user_contr{sarco_sarco_user_counter}),'.mat'],'fv');
    vs_contr=s.fv;
    s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_x_',num2str(sarco_piv_user_contr{sarco_sarco_user_counter}),'.mat'],'x');
    xs_contr=s.x;
    s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_y_',num2str(sarco_piv_user_contr{sarco_sarco_user_counter}),'.mat'],'y');
    ys_contr=s.y;
    %new meshgrid for every pixel.
    [Xqu,Yqu]=meshgrid(1:size(sarco_sarco_user_preview1{sarco_sarco_user_counter},2),1:size(sarco_sarco_user_preview1{sarco_sarco_user_counter},1));
    Vt_relax = interp2(xs_relax,ys_relax,vs_relax,Xqu,Yqu,'linear');
    Ut_relax = interp2(xs_relax,ys_relax,us_relax,Xqu,Yqu,'linear');
    Vt_contr = interp2(xs_contr,ys_contr,vs_contr,Xqu,Yqu,'linear');
    Ut_contr = interp2(xs_contr,ys_contr,us_contr,Xqu,Yqu,'linear');
    %maxima locations
    [r_relax,c_relax]=find(BW_relax==1);
    [r_contr,c_contr]=find(BW_contr==1);
    %delete old maxima
    BW_relax(BW_relax==1)=0;
    BW_contr(BW_contr==1)=0;
    %calculate new maxima
    for i=1:length(r_relax)
        xxr=c_relax(i);
        yyr=r_relax(i);
        xxr=xxr-Ut_relax(round(yyr),round(xxr));
        yyr=yyr-Vt_relax(round(yyr),round(xxr));
        BW_relax(round(yyr),round(xxr))=1;
    end
    for i=1:length(r_contr)
        xxr=c_contr(i);
        yyr=r_contr(i);
        xxr=xxr-Ut_contr(round(yyr),round(xxr));
        yyr=yyr-Vt_contr(round(yyr),round(xxr));
        BW_contr(round(yyr),round(xxr))=1;
    end
    sarco_sarco_user_preview2{sarco_sarco_user_counter}=BW_relax.*mask;
    sarco_sarco_user_preview3{sarco_sarco_user_counter}=BW_contr.*mask;
    
    
    %display the previews in the axes foir 1st vid
    cla(h_sarco(1).axes_sarco)
    axes(h_sarco(1).axes_sarco)
    imshow(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]));
    %overlays in 3 and 4
    cla(h_sarco(1).axes_openleft)
    axes(h_sarco(1).axes_openleft)
    imshow(imoverlay(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]),sarco_sarco_user_preview2{sarco_sarco_user_counter},[0,0,1]));
    cla(h_sarco(1).axes_openright)
    axes(h_sarco(1).axes_openright)
    imshow(imoverlay(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]),sarco_sarco_user_preview3{sarco_sarco_user_counter},[0,0,1]));
    
    %save
    setappdata(0,'sarco_sarco_user_preview1',sarco_sarco_user_preview1);
    setappdata(0,'sarco_sarco_user_preview2',sarco_sarco_user_preview2);
    setappdata(0,'sarco_sarco_user_preview3',sarco_sarco_user_preview3);
    setappdata(0,'sarco_sarco_user_minS',sarco_sarco_user_minS);
    setappdata(0,'sarco_sarco_user_maxS',sarco_sarco_user_maxS);
    
    %statusbar
    sb=statusbar(h_sarco(1).fig,'Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end


function sarco_push_openpreview(hObject, eventdata, h_sarco)
%disable figure during calculation
enableDisableFig(h_sarco(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_sarco(1).fig,1));


try
    %load stuff
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_sarco_user_preview1=getappdata(0,'sarco_sarco_user_preview1');
    sarco_sarco_user_counter=getappdata(0,'sarco_sarco_user_counter');
    
    %display the previews new fig
    figure,
    imshow(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]));
catch
end

function sarco_push_openleft(hObject, eventdata, h_sarco)
%disable figure during calculation
enableDisableFig(h_sarco(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_sarco(1).fig,1));


try
    %load stuff
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_sarco_user_preview1=getappdata(0,'sarco_sarco_user_preview1');
    sarco_sarco_user_preview2=getappdata(0,'sarco_sarco_user_preview2');
    sarco_sarco_user_counter=getappdata(0,'sarco_sarco_user_counter');
    
    %display the previews new fig
    figure,
    imshow(imoverlay(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]),sarco_sarco_user_preview2{sarco_sarco_user_counter},[0,0,1]));
    
catch
end

function sarco_push_openright(hObject, eventdata, h_sarco)
%disable figure during calculation
enableDisableFig(h_sarco(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_sarco(1).fig,1));


try
    %load stuff
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_sarco_user_preview1=getappdata(0,'sarco_sarco_user_preview1');
    sarco_sarco_user_preview3=getappdata(0,'sarco_sarco_user_preview3');
    sarco_sarco_user_counter=getappdata(0,'sarco_sarco_user_counter');
    
    %display the previews new fig
    figure,
    imshow(imoverlay(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]),sarco_sarco_user_preview3{sarco_sarco_user_counter},[0,0,1]));
    
catch
end

function sarco_push_ok(hObject, eventdata, h_sarco, h_main)

try
    %load
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_pathnamestack=getappdata(0,'sarco_init_user_pathnamestack');
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    
    %check if user wants to save
    value = get(h_sarco(1).checkbox_skeleton, 'Value');
    if ~value
        for ivid=1:sarco_init_user_Nfiles
            rmdir([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Sarcomere Skeleton'],'s')
        end
    end
    
    value = get(h_sarco(1).checkbox_heatmaps, 'Value');
    if ~value
        for ivid=1:sarco_init_user_Nfiles
            rmdir([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Sarcomere Heatmaps'],'s')
        end
    end
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

%change main windows 4. button status
set(h_main(1).button_sarco,'ForegroundColor',[0 .5 0]);
set(h_main(1).button_para,'Enable','on');

%close window
close(h_sarco(1).fig);

%move main window to the side
movegui(h_main(1).fig,'center')

function sarco_push_backwards(hObject, eventdata, h_sarco)
%disable figure during calculation
enableDisableFig(h_sarco(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_sarco(1).fig,1));


try
    %load what shared para we need
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_sarco_user_minS=getappdata(0,'sarco_sarco_user_minS');
    sarco_sarco_user_maxS=getappdata(0,'sarco_sarco_user_maxS');
    sarco_sarco_user_preview1=getappdata(0,'sarco_sarco_user_preview1');
    sarco_sarco_user_preview2=getappdata(0,'sarco_sarco_user_preview2');
    sarco_sarco_user_preview3=getappdata(0,'sarco_sarco_user_preview3');
    sarco_sarco_user_counter=getappdata(0,'sarco_sarco_user_counter');
    sarco_sarco_user_evaluation=getappdata(0,'sarco_sarco_user_evaluation');
    
    %update counter
    sarco_sarco_user_counter=sarco_sarco_user_counter-1;
    
    %set correct range parameters
    set(h_sarco(1).edit_min,'String',num2str(sarco_sarco_user_minS{sarco_sarco_user_counter}));
    set(h_sarco(1).edit_max,'String',num2str(sarco_sarco_user_maxS{sarco_sarco_user_counter}));
    
    %set texts to curr vid
    set(h_sarco(1).text_whichvidname,'String',sarco_init_user_filenamestack{1,sarco_sarco_user_counter});
    set(h_sarco(1).text_whichvid,'String',[num2str(sarco_sarco_user_counter),'/',num2str(sarco_init_user_Nfiles)]);
    
    %display the previews in the axes foir 1st vid
    cla(h_sarco(1).axes_sarco)
    axes(h_sarco(1).axes_sarco)
    imshow(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]));
    %overlays in 3 and 4
    cla(h_sarco(1).axes_openleft)
    axes(h_sarco(1).axes_openleft)
    imshow(imoverlay(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]),sarco_sarco_user_preview2{sarco_sarco_user_counter},[0,0,1]));
    cla(h_sarco(1).axes_openright)
    axes(h_sarco(1).axes_openright)
    imshow(imoverlay(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]),sarco_sarco_user_preview3{sarco_sarco_user_counter},[0,0,1]));
    
    %user choice tag?
    if sarco_sarco_user_evaluation(sarco_sarco_user_counter)==1
        set(h_sarco(1).radiobutton_good,'Value',0);
        set(h_sarco(1).radiobutton_bad,'Value',1);
    elseif sarco_sarco_user_evaluation(sarco_sarco_user_counter)==2
        set(h_sarco(1).radiobutton_good,'Value',1);
        set(h_sarco(1).radiobutton_bad,'Value',0);
    else
        set(h_sarco(1).radiobutton_good,'Value',0);
        set(h_sarco(1).radiobutton_bad,'Value',0);
    end
    
    %forward/back
    if sarco_sarco_user_counter>1
        set(h_sarco(1).button_backwards,'Enable','on');
    else
        set(h_sarco(1).button_backwards,'Enable','off');
    end
    if sarco_sarco_user_counter==sarco_init_user_Nfiles
        set(h_sarco(1).button_forwards,'Enable','off');
    else
        set(h_sarco(1).button_forwards,'Enable','on');
    end
    
    %set new counter
    setappdata(0,'sarco_sarco_user_counter',sarco_sarco_user_counter);
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function sarco_push_forwards(hObject, eventdata, h_sarco)
%disable figure during calculation
enableDisableFig(h_sarco(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_sarco(1).fig,1));


try
    %load what shared para we need
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_sarco_user_evaluation=getappdata(0,'sarco_sarco_user_evaluation');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_sarco_user_minS=getappdata(0,'sarco_sarco_user_minS');
    sarco_sarco_user_maxS=getappdata(0,'sarco_sarco_user_maxS');
    sarco_sarco_user_preview1=getappdata(0,'sarco_sarco_user_preview1');
    sarco_sarco_user_preview2=getappdata(0,'sarco_sarco_user_preview2');
    sarco_sarco_user_preview3=getappdata(0,'sarco_sarco_user_preview3');
    sarco_sarco_user_counter=getappdata(0,'sarco_sarco_user_counter');
    
    %update counter
    sarco_sarco_user_counter=sarco_sarco_user_counter+1;
    
    %set correct range parameters
    set(h_sarco(1).edit_min,'String',num2str(sarco_sarco_user_minS{sarco_sarco_user_counter}));
    set(h_sarco(1).edit_max,'String',num2str(sarco_sarco_user_maxS{sarco_sarco_user_counter}));
    
    %set texts to curr vid
    set(h_sarco(1).text_whichvidname,'String',sarco_init_user_filenamestack{1,sarco_sarco_user_counter});
    set(h_sarco(1).text_whichvid,'String',[num2str(sarco_sarco_user_counter),'/',num2str(sarco_init_user_Nfiles)]);
    
    
    %display the previews in the axes foir 1st vid
    cla(h_sarco(1).axes_sarco)
    axes(h_sarco(1).axes_sarco)
    imshow(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]));
    %overlays in 3 and 4
    cla(h_sarco(1).axes_openleft)
    axes(h_sarco(1).axes_openleft)
    imshow(imoverlay(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]),sarco_sarco_user_preview2{sarco_sarco_user_counter},[0,0,1]));
    cla(h_sarco(1).axes_openright)
    axes(h_sarco(1).axes_openright)
    imshow(imoverlay(imoverlay(sarco_init_user_preview_frame1{sarco_sarco_user_counter},sarco_sarco_user_preview1{sarco_sarco_user_counter},[1,0,0]),sarco_sarco_user_preview3{sarco_sarco_user_counter},[0,0,1]));
    
    %user choice tag?
    if sarco_sarco_user_evaluation(sarco_sarco_user_counter)==1
        set(h_sarco(1).radiobutton_good,'Value',0);
        set(h_sarco(1).radiobutton_bad,'Value',1);
    elseif sarco_sarco_user_evaluation(sarco_sarco_user_counter)==2
        set(h_sarco(1).radiobutton_good,'Value',1);
        set(h_sarco(1).radiobutton_bad,'Value',0);
    else
        set(h_sarco(1).radiobutton_good,'Value',0);
        set(h_sarco(1).radiobutton_bad,'Value',0);
    end
    
    %forward/back
    if sarco_sarco_user_counter>1
        set(h_sarco(1).button_backwards,'Enable','on');
    else
        set(h_sarco(1).button_backwards,'Enable','off');
    end
    if sarco_sarco_user_counter==sarco_init_user_Nfiles
        set(h_sarco(1).button_forwards,'Enable','off');
    else
        set(h_sarco(1).button_forwards,'Enable','on');
    end
    
    %set new counter
    setappdata(0,'sarco_sarco_user_counter',sarco_sarco_user_counter);
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function sarco_push_calc(hObject, eventdata, h_sarco)
%disable figure during calculation
enableDisableFig(h_sarco(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_sarco(1).fig,1));


try
    %load shared
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_pathnamestack=getappdata(0,'sarco_init_user_pathnamestack');
    sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');
    sarco_sarco_user_evaluation=getappdata(0,'sarco_sarco_user_evaluation');
    sarco_sarco_user_minS=getappdata(0,'sarco_sarco_user_minS');
    sarco_sarco_user_maxS=getappdata(0,'sarco_sarco_user_maxS');
    sarco_conc_user_binarysarc=getappdata(0,'sarco_conc_user_binarysarc');
    sarco_conc_user_binary1=getappdata(0,'sarco_conc_user_binary1');
    sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');
    sarco_conc_user_binary_roi=getappdata(0,'sarco_conc_user_binary_roi');
    sarco_sarco_user_meansarco=getappdata(0,'sarco_sarco_user_meansarco');
    sarco_sarco_user_stdsarco=getappdata(0,'sarco_sarco_user_stdsarco');
    sarco_sarco_user_stdangles=getappdata(0,'sarco_sarco_user_stdangles');
    sarco_sarco_user_meansarco_roi=getappdata(0,'sarco_sarco_user_meansarco_roi');
    sarco_sarco_user_stdsarco_roi=getappdata(0,'sarco_sarco_user_stdsarco_roi');
    sarco_sarco_user_stdangles_roi=getappdata(0,'sarco_sarco_user_stdangles_roi');
    
    %first check: has user entered all cell outlines
    if ~isempty(find(isnan(sarco_sarco_user_evaluation)))
        errordlg('Please make all mandatory choices.','Error');
        return;
    end
    
    %%loop overs vids
    %single or master?
    %single: ridges for every image + idea2
    %loop over videos
    for ivid=1:sarco_init_user_Nfiles
        %heatmap save folder
        if ~isequal(exist([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'Plots'], 'dir'),7)
                mkdir([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots'])
        end
        if ~isequal(exist([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'Plots/Sarcomere Skeleton'], 'dir'),7)
                mkdir([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Sarcomere Skeleton'])
        end
        if ~isequal(exist([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'Plots/Sarcomere Heatmaps'], 'dir'),7)
                mkdir([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Sarcomere Heatmaps'])
        end
        
        %initial values for parz from openingfct
        minS=floor(sarco_sarco_user_minS{ivid}/(sarco_init_user_conversion{ivid}));
        maxS=ceil(sarco_sarco_user_maxS{ivid}/(sarco_init_user_conversion{ivid}));
        
        %masks and vid file
        file_vid=sarco_init_user_filenamestack{1,ivid};
        path_vid=sarco_init_user_pathnamestack{1,ivid};
        mask=sarco_conc_user_binarysarc{1,ivid}.*sarco_conc_user_binary1{1,ivid};
        
        if sarco_sarco_user_evaluation(ivid)==1
            %case 1: regular analysis
            %loop over frames
            for ifr=1:sarco_init_user_Nframes{ivid}
                %statusbar for calcs
                sb=statusbar(h_sarco(1).fig,['Regular analysis for video (',num2str(ivid),'/',num2str(sarco_init_user_Nfiles),')...',num2str(floor(100*(ifr-1)/sarco_init_user_Nframes{ivid})), '%% done']);
                sb.getComponent(0).setForeground(java.awt.Color.red);
                
                %calculate ridges for current image
                [ BW ,orientim] = ridges_and_orient( file_vid, ifr, minS, maxS );
                
                %save skeleton
                %load image
                s=load(['vars_DO_NOT_DELETE/',file_vid,'/image',num2str(ifr),'.mat'],'imagei');
                image=s.imagei;
                sh=figure('visible','off');
                imshow(imoverlay(normalise(image),BW.*mask,[0 0 1]))
                export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Sarcomere Skeleton/skeleton',int2str(ifr)],'-png','-m2',sh);
                close(sh);
                %todo....update deformed mask
                
                %calculate distances
                    %inside cell
                    [ sarco_sarco_user_meansarco{ivid,ifr},sarco_sarco_user_stdsarco{ivid,ifr},sarco_sarco_user_stdangles{ivid,ifr} ] = sarco_dist( path_vid,file_vid,ifr,BW.*mask,orientim.*mask,sarco_sarco_user_minS{ivid},sarco_sarco_user_maxS{ivid},sarco_init_user_conversion{ivid},0,0);
                    %in rois
                    if sarco_conc_user_number_roi(ivid)>0
                        for iroi=1:sarco_conc_user_number_roi(ivid)
                            mask_roi=sarco_conc_user_binary_roi{iroi,ivid};
                            [ sarco_sarco_user_meansarco_roi{iroi,ivid,ifr},sarco_sarco_user_stdsarco_roi{iroi,ivid,ifr},sarco_sarco_user_stdangles_roi{iroi,ivid,ifr} ] = sarco_dist_roi( path_vid,file_vid,ifr,BW.*mask_roi,orientim.*mask_roi,sarco_sarco_user_minS{ivid},sarco_sarco_user_maxS{ivid},sarco_init_user_conversion{ivid},0,0);
                        end
                    end
            end
        elseif sarco_sarco_user_evaluation(ivid)==2
            %case 2 master skeleton
            
            %initialize combined binary
            BW_comb=zeros(size(sarco_init_user_preview_frame1{ivid},1),size(sarco_init_user_preview_frame1{ivid},2));
            %loop over frames to build a master skeleton
            for ifr=1:sarco_init_user_Nframes{ivid}
                %statusbar for calcs
                sb=statusbar(h_sarco(1).fig,['Master analysis for video (',num2str(ivid),'/',num2str(sarco_init_user_Nfiles),'); Generating master skeleton...',num2str(floor(100*(ifr-1)/sarco_init_user_Nframes{ivid})), '%% done']);
                sb.getComponent(0).setForeground(java.awt.Color.red);
                %ridges for curr frames
                [ BW ,~] = ridges_and_orient( file_vid, ifr, minS, maxS );
                %load the piv data between 1&frame
                s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_u_',num2str(ifr),'.mat'],'fu');
                us=s.fu;
                s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_v_',num2str(ifr),'.mat'],'fv');
                vs=s.fv;
                s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_x_',num2str(ifr),'.mat'],'x');
                xs=s.x;
                s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_y_',num2str(ifr),'.mat'],'y');
                ys=s.y;
                
                %new meshgrid for every pixel.
                [Xqu,Yqu]=meshgrid(1:size(BW,2),1:size(BW,1));
                Vt = interp2(xs,ys,vs,Xqu,Yqu,'linear');
                Ut = interp2(xs,ys,us,Xqu,Yqu,'linear');
                
                %maxima locations
                [r,c]=find(BW==1);
                
                %delete old maxima
                BW(BW==1)=0;
                
                %calculate new maxima
                for i=1:length(r)
                    xxr=c(i);
                    yyr=r(i);
                    xxr=xxr-Ut(round(yyr),round(xxr));
                    yyr=yyr-Vt(round(yyr),round(xxr));
                    BW(round(yyr),round(xxr))=1;
                end
                BW_comb=BW_comb+BW;
            end
            
            %set thresh and thin
            BW_comb=BW_comb/sarco_init_user_Nframes{ivid};
            BW_final=BW_comb>.3;
            BW_final=bwmorph(BW_final,'thin',Inf);
            
            %mask is the one for 1 all times...
            BW_final=BW_final.*mask;
                       
            %  calculate deformed skeleton
            %with displacements, loop over frames
            for ifr=1:sarco_init_user_Nframes{ivid}
                %statusbar for calcs
                sb=statusbar(h_sarco(1).fig,['Master analysis for video (',num2str(ivid),'/',num2str(sarco_init_user_Nfiles),'); Calculating sarcomeres...',num2str(floor(100*(ifr-1)/sarco_init_user_Nframes{ivid})), '%% done']);
                sb.getComponent(0).setForeground(java.awt.Color.red);
                %deformed master skel
                %load the piv data between 1&frame
                s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_u_',num2str(ifr),'.mat'],'fu');
                us=s.fu;
                s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_v_',num2str(ifr),'.mat'],'fv');
                vs=s.fv;
                s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_x_',num2str(ifr),'.mat'],'x');
                xs=s.x;
                s=load(['vars_DO_NOT_DELETE/',file_vid,'/piv_y_',num2str(ifr),'.mat'],'y');
                ys=s.y;
                
                %new meshgrid for every pixel.
                [Xqu,Yqu]=meshgrid(1:size(BW_final,2),1:size(BW_final,1));
                Vt = interp2(xs,ys,vs,Xqu,Yqu,'linear');
                Ut = interp2(xs,ys,us,Xqu,Yqu,'linear');
                
                %maxima locations
                BW_curr=BW_final;
                [r,c]=find(BW_curr==1);
                
                %delete old maxima
                BW_curr(BW_curr==1)=0;
                
                %calculate new maxima
                for i=1:length(r)
                    xxr=c(i);
                    yyr=r(i);
                    xxr=xxr+Ut(round(yyr),round(xxr));
                    yyr=yyr+Vt(round(yyr),round(xxr));
                    BW_curr(round(yyr),round(xxr))=1;
                end
                
                %save skeleton
                %load image
                s=load(['vars_DO_NOT_DELETE/',file_vid,'/image',num2str(ifr),'.mat'],'imagei');
                image=s.imagei;
                sh=figure('visible','off');
                imshow(imoverlay(normalise(image),BW_curr.*mask,[0 0 1]))
                export_fig([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Plots/Sarcomere Skeleton/skeleton',int2str(ifr)],'-png','-m2',sh);
                close(sh);
                
                %calculate orientations
                [ orientim] = orient( file_vid, ifr );
                
                %calculate and display distances
                    %inside cell
                    [ sarco_sarco_user_meansarco{ivid,ifr},sarco_sarco_user_stdsarco{ivid,ifr},sarco_sarco_user_stdangles{ivid,ifr} ] = sarco_dist( path_vid,file_vid,ifr,BW_curr.*mask,orientim.*mask,sarco_sarco_user_minS{ivid},sarco_sarco_user_maxS{ivid},sarco_init_user_conversion{ivid},0,0);
                    %inside roi
                    %in rois
                    if sarco_conc_user_number_roi(ivid)>0
                        for iroi=1:sarco_conc_user_number_roi(ivid)
                            mask_roi=sarco_conc_user_binary_roi{iroi,ivid};
                            [ sarco_sarco_user_meansarco_roi{iroi,ivid,ifr},sarco_sarco_user_stdsarco_roi{iroi,ivid,ifr},sarco_sarco_user_stdangles_roi{iroi,ivid,ifr} ] = sarco_dist_roi( path_vid,file_vid,ifr,BW_curr.*mask_roi,orientim.*mask_roi,sarco_sarco_user_minS{ivid},sarco_sarco_user_maxS{ivid},sarco_init_user_conversion{ivid},0,0);
                        end
                    end
           
            end
        end
    end
    %master: ridges for every image -> translation to one master -> calculate
    %virtual ridges + idea 2
    
    %share para
    setappdata(0,'sarco_sarco_user_meansarco',sarco_sarco_user_meansarco);
    setappdata(0,'sarco_sarco_user_stdsarco',sarco_sarco_user_stdsarco);
    setappdata(0,'sarco_sarco_user_stdangles',sarco_sarco_user_stdangles);
    setappdata(0,'sarco_sarco_user_meansarco_roi',sarco_sarco_user_meansarco_roi);
    setappdata(0,'sarco_sarco_user_stdsarco_roi',sarco_sarco_user_stdsarco_roi);
    setappdata(0,'sarco_sarco_user_stdangles_roi',sarco_sarco_user_stdangles_roi);
    
    %statusbar
    sb=statusbar(h_sarco(1).fig,'Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %enable ok button
    set(h_sarco(1).button_ok,'Visible','on');
    set(h_sarco(1).checkbox_skeleton,'Visible','on');
set(h_sarco(1).checkbox_heatmaps,'Visible','on');
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end



function sarco_buttongroup(hObject, eventdata, h_sarco)
%load
sarco_sarco_user_evaluation=getappdata(0,'sarco_sarco_user_evaluation');
sarco_sarco_user_counter=getappdata(0,'sarco_sarco_user_counter');

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton_good'%master
        sarco_sarco_user_evaluation(sarco_sarco_user_counter)=2;
        % Code for when radiobutton1 is selected.
    case 'radiobutton_bad'%single
        sarco_sarco_user_evaluation(sarco_sarco_user_counter)=1;
end

setappdata(0,'sarco_sarco_user_evaluation',sarco_sarco_user_evaluation);
