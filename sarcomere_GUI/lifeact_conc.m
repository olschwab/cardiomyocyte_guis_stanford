%lifeact_conc.m ; part of the Lifeact GUI: execute lifeact_main.m
%version 2.0
%written by O. Schwab (oschwab@stanford.edu)
%last change: 10/26/14

function lifeact_conc(h_main)
%main function for the outline&concentration window of lifeact gui

%create new window for outline&concentration
%fig size
figsize=[450,800];
%get screen size
screensize = get(0,'ScreenSize');
%position fig on center of screen
xpos = ceil((screensize(3)-figsize(2))/2);
ypos = ceil((screensize(4)-figsize(1))/2);
%create fig; invisible at first
h_conc(1).fig=figure(...
    'position',[xpos, ypos, figsize(2), figsize(1)],...
    'units','pixels',...
    'renderer','OpenGL',...
    'MenuBar','none',...
    'PaperPositionMode','auto',...
    'Name','Lifeact Outline & Concentration',...
    'NumberTitle','off',...
    'Resize','off',...
    'Color',[.94,.94,.94],...
    'visible','off');

%create uipanel for cell outline & draw button
%uipanel:
h_conc(1).panel_outline = uipanel('Parent',h_conc(1).fig,'Title','Cell outline','units','pixels','Position',[20,190,350,250]);
%button: draw outline
h_conc(1).button_draw = uicontrol('Parent',h_conc(1).panel_outline,'style','pushbutton','position',[5,15,75,25],'string','Draw outline');
%axes: display first frame of current
h_conc(1).axes_outline = axes('Parent',h_conc(1).panel_outline,'Units', 'pixels','Position',[5,55,335,175]);
%text: minor
h_conc(1).text_minor = uicontrol('Parent',h_conc(1).panel_outline,'style','text','position',[90,30,75,15],'string','Minor axis [px]','HorizontalAlignment','left');
%text: major
h_conc(1).text_major = uicontrol('Parent',h_conc(1).panel_outline,'style','text','position',[90,10,75,15],'string','Major axis [px]','HorizontalAlignment','left');
%text: ratio
h_conc(1).text_ratio = uicontrol('Parent',h_conc(1).panel_outline,'style','text','position',[235,30,75,15],'string','Ratio','HorizontalAlignment','left');
%text: angle
h_conc(1).text_angle = uicontrol('Parent',h_conc(1).panel_outline,'style','text','position',[235,10,75,15],'string','Angle [deg]','HorizontalAlignment','left');
%edit: minor
h_conc(1).edit_minor = uicontrol('Parent',h_conc(1).panel_outline,'style','edit','position',[170,30,40,15],'HorizontalAlignment','left');
%edit: major
h_conc(1).edit_major = uicontrol('Parent',h_conc(1).panel_outline,'style','edit','position',[170,10,40,15],'HorizontalAlignment','left');
%edit: ratio
h_conc(1).edit_ratio = uicontrol('Parent',h_conc(1).panel_outline,'style','edit','position',[300,30,40,15],'HorizontalAlignment','left');
%edit: angle
h_conc(1).edit_angle = uicontrol('Parent',h_conc(1).panel_outline,'style','edit','position',[300,10,40,15],'HorizontalAlignment','left');

%create uipanel for concentration
%uipanel:
h_conc(1).panel_conc = uipanel('Parent',h_conc(1).fig,'Title','Sarcomere concentration','units','pixels','Position',[380,190,400,250]);
%slider
h_conc(1).slider = uicontrol('Parent',h_conc(1).panel_conc,'style','slider','units','pixels','position',[50,195,170,15]);
%text: slide instructions
h_conc(1).text_slider = uicontrol('Parent',h_conc(1).panel_conc,'style','text','position',[50,215,200,15],'string','Slide until only myofibrils are visible','HorizontalAlignment','left');
%text: concentration
h_conc(1).text_concentration = uicontrol('Parent',h_conc(1).panel_conc,'style','text','position',[280,215,100,15],'string','Concentration','HorizontalAlignment','left');
%edit: concentration
h_conc(1).edit_concentration = uicontrol('Parent',h_conc(1).panel_conc,'style','edit','position',[280,195,70,15],'HorizontalAlignment','left');
%axes: concentration preview
h_conc(1).axes_concentration = axes('Parent',h_conc(1).panel_conc,'Units', 'pixels','Position',[5,5,385,180]);

%create uipanel for roi choice
%uipanel
h_conc(1).panel_roichoice = uipanel('Parent',h_conc(1).fig,'Title','Specify ROIs','units','pixels','Position',[270,25,100,40]);
%checkbox: roi choice
h_conc(1).checkbox = uicontrol('Parent',h_conc(1).panel_roichoice,'style','checkbox','position',[5,5,90,15],'string','Provide ROIs','HorizontalAlignment','left');

%create uipanel for roi
h_conc(1).panel_roi = uipanel('Parent',h_conc(1).fig,'Title','Regions of interest','units','pixels','Position',[380,25,400,160]);
%axes: roi
h_conc(1).axes_roi = axes('Parent',h_conc(1).panel_roi,'Units', 'pixels','Position',[5,5,315,135]);
%button: add roi
h_conc(1).button_addroi = uicontrol('Parent',h_conc(1).panel_roi,'style','pushbutton','position',[330,115,60,25],'string','Add ROI');
%button: clear roi
h_conc(1).button_clearroi = uicontrol('Parent',h_conc(1).panel_roi,'style','pushbutton','position',[330,85,60,25],'string','Clear');

%button: forwards
h_conc(1).button_forwards = uicontrol('Parent',h_conc(1).fig,'style','pushbutton','position',[45,150,25,25],'string','>');
%button: backwards
h_conc(1).button_backwards = uicontrol('Parent',h_conc(1).fig,'style','pushbutton','position',[20,150,25,25],'string','<');
%create ok button
h_conc(1).button_ok = uicontrol('Parent',h_conc(1).fig,'style','pushbutton','position',[20,25,45,20],'string','OK','visible','on');
%text: show which video (i/n)
h_conc(1).text_whichvid = uicontrol('Parent',h_conc(1).fig,'style','text','position',[80,165,25,15],'string','(1/1)','HorizontalAlignment','left');
%text: show which video (name)
h_conc(1).text_whichvidname = uicontrol('Parent',h_conc(1).fig,'style','text','position',[80,150,200,15],'string','Experiment','HorizontalAlignment','left');

%assign callbacks to buttons and slider & checkbox
%button 1
set(h_conc(1).button_draw,'callback',{@conc_push_draw,h_conc})
%button 2
set(h_conc(1).button_addroi,'callback',{@conc_push_addroi,h_conc})
%button 3
set(h_conc(1).button_clearroi,'callback',{@conc_push_clearroi,h_conc})
%button 4
set(h_conc(1).button_forwards,'callback',{@conc_push_forwards,h_conc})
%button 5
set(h_conc(1).button_backwards,'callback',{@conc_push_backwards,h_conc})
%button 6
set(h_conc(1).button_ok,'callback',{@conc_push_ok,h_conc,h_main})
%slider
set(h_conc(1).slider,'callback',{@conc_slider,h_conc})
%checkbox
set(h_conc(1).checkbox,'callback',{@conc_checkbox,h_conc})

%populate stuff when window first opens
try
    %load what shared para we need
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    
    %initiate counter (which video)
    sarco_conc_user_counter=1;
    %make a counter to find out what user selected (roi/conc)
    sarco_conc_user_counter_roi=zeros(1,sarco_init_user_Nfiles);
    %initialise parameter vectors for angle, minor, major and ratio
    sarco_conc_user_angle=NaN*ones(1,sarco_init_user_Nfiles);
    sarco_conc_user_minor=NaN*ones(1,sarco_init_user_Nfiles);
    sarco_conc_user_major=NaN*ones(1,sarco_init_user_Nfiles);
    %initialize cells for conc blobb and boundary coord.
    sarco_conc_user_outlinex=cell(1,sarco_init_user_Nfiles);
    sarco_conc_user_outliney=cell(1,sarco_init_user_Nfiles);
    sarco_conc_user_binary1=cell(1,sarco_init_user_Nfiles);
    sarco_conc_user_binarysarc=cell(1,sarco_init_user_Nfiles);
    %initalize for roi
    sarco_conc_user_number_roi=zeros(1,sarco_init_user_Nfiles);
    sarco_conc_user_outlinex_roi=cell(5,sarco_init_user_Nfiles); %inital. with 5 rois
    sarco_conc_user_outliney_roi=cell(5,sarco_init_user_Nfiles);
    sarco_conc_user_binary_roi=cell(5,sarco_init_user_Nfiles);
    %concentration
    sarco_conc_user_areacell=cell(1,sarco_init_user_Nfiles);
    sarco_conc_user_areacell_roi=cell(5,sarco_init_user_Nfiles);
    sarco_conc_user_areasarco=cell(1,sarco_init_user_Nfiles);
    sarco_conc_user_areasarco_roi=cell(5,sarco_init_user_Nfiles);
    %slider value
    sarco_conc_user_slider=cell(1,sarco_init_user_Nfiles);
    sarco_conc_user_slider_minT=cell(1,sarco_init_user_Nfiles);
    sarco_conc_user_slider_maxT=cell(1,sarco_init_user_Nfiles);
    
    %turn off visibility of panels
    set(h_conc(1).panel_outline,'Visible','on')
    set(h_conc(1).panel_conc,'Visible','on')
    set(h_conc(1).panel_roi,'Visible','off')
    set(h_conc(1).panel_roichoice,'Visible','on')
    
    %buttons
    if sarco_conc_user_counter>1
        set(h_conc(1).button_backwards,'Enable','on');
    else
        set(h_conc(1).button_backwards,'Enable','off');
    end
    if sarco_conc_user_counter==sarco_init_user_Nfiles
        set(h_conc(1).button_forwards,'Enable','off');
    else
        set(h_conc(1).button_forwards,'Enable','on');
    end
    
    %set texts to 1st vid
    set(h_conc(1).text_whichvidname,'String',sarco_init_user_filenamestack{1,sarco_conc_user_counter});
    set(h_conc(1).text_whichvid,'String',[num2str(sarco_conc_user_counter),'/',num2str(sarco_init_user_Nfiles)]);
    
    %display 1st frame of 1st vid in axes
    reset(h_conc(1).axes_outline)
    axes(h_conc(1).axes_outline)
    imshow(sarco_init_user_preview_frame1{sarco_conc_user_counter});hold on;
    
    %calulate slider values for all vids
    for ivid=1:sarco_init_user_Nfiles
        sarco_conc_user_slider_minT{ivid}=min(min(sarco_init_user_preview_frame1{ivid}));
        sarco_conc_user_slider_maxT{ivid}=max(max(sarco_init_user_preview_frame1{ivid}));
        sarco_conc_user_slider{ivid}=.5*(sarco_conc_user_slider_minT{ivid}+sarco_conc_user_slider_maxT{ivid});
    end
    
    %calculate and display bounds for binary threshold
    set(h_conc(1).slider,'Max',sarco_conc_user_slider_maxT{sarco_conc_user_counter});
    set(h_conc(1).slider,'Min',sarco_conc_user_slider_minT{sarco_conc_user_counter});
    set(h_conc(1).slider,'Value',sarco_conc_user_slider{sarco_conc_user_counter});
    set(h_conc(1).slider, 'SliderStep', [(sarco_conc_user_slider_maxT{sarco_conc_user_counter}-sarco_conc_user_slider_minT{sarco_conc_user_counter})/10, (sarco_conc_user_slider_maxT{sarco_conc_user_counter}-sarco_conc_user_slider_minT{sarco_conc_user_counter})/50]);
    
    
    %display binary 1st frame for this
    thresh=get(h_conc(1).slider,'Value');
    binary=sarco_init_user_preview_frame1{sarco_conc_user_counter}>thresh;
    sarco_conc_user_binarysarc{sarco_conc_user_counter} = imfill(binary, 'holes');
    measurements = regionprops(sarco_conc_user_binarysarc{sarco_conc_user_counter}, 'Area');
    sarco_conc_user_areasarco{sarco_conc_user_counter}=sum([measurements.Area]);
    
    %axes 4: colormapped binary ims
    %which parts are background:neither in binary1 nor in binarysarc
    if isempty(sarco_conc_user_binary1{sarco_conc_user_counter})
        bin_background=~sarco_conc_user_binarysarc{sarco_conc_user_counter};
        bin_cell=zeros(size(bin_background,1),size(bin_background,2));
        bin_sarco=sarco_conc_user_binarysarc{sarco_conc_user_counter};
    else
        bin_background=~(sarco_conc_user_binarysarc{sarco_conc_user_counter}|sarco_conc_user_binary1{sarco_conc_user_counter});
        bin_cell=sarco_conc_user_binary1{sarco_conc_user_counter};
        bin_sarco=sarco_conc_user_binarysarc{sarco_conc_user_counter};
    end
    rgbimage=cat(3,double(bin_sarco),double(bin_background),double(bin_cell));
    cla(h_conc(1).axes_concentration)
    axes(h_conc(1).axes_concentration)
    imshow(rgbimage)
    
    %calculate concentration
    if isempty(sarco_conc_user_areasarco{sarco_conc_user_counter})||isempty(sarco_conc_user_areacell{sarco_conc_user_counter})
        set(h_conc(1).edit_concentration,'String','NaN');
    else
        r2=regionprops(sarco_conc_user_binarysarc{sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter},'Area');
        sarco_conc_user_areasarco{sarco_conc_user_counter}=r2.Area;
        set(h_conc(1).edit_concentration,'String',num2str(sarco_conc_user_areasarco{sarco_conc_user_counter}/(eps+sarco_conc_user_areacell{sarco_conc_user_counter})))
    end
    
    %store everything for shared use
    setappdata(0,'sarco_conc_user_counter',sarco_conc_user_counter)
    setappdata(0,'sarco_conc_user_counter_roi',sarco_conc_user_counter_roi)
    setappdata(0,'sarco_conc_user_angle',sarco_conc_user_angle)
    setappdata(0,'sarco_conc_user_minor',sarco_conc_user_minor)
    setappdata(0,'sarco_conc_user_major',sarco_conc_user_major)
    setappdata(0,'sarco_conc_user_outlinex',sarco_conc_user_outlinex);
    setappdata(0,'sarco_conc_user_outliney',sarco_conc_user_outliney);
    setappdata(0,'sarco_conc_user_binary1',sarco_conc_user_binary1);
    setappdata(0,'sarco_conc_user_binarysarc',sarco_conc_user_binarysarc);
    setappdata(0,'sarco_conc_user_number_roi',sarco_conc_user_number_roi);
    setappdata(0,'sarco_conc_user_outlinex_roi',sarco_conc_user_outlinex_roi);
    setappdata(0,'sarco_conc_user_outliney_roi',sarco_conc_user_outliney_roi);
    setappdata(0,'sarco_conc_user_binary_roi',sarco_conc_user_binary_roi);
    setappdata(0,'sarco_conc_user_areacell',sarco_conc_user_areacell);
    setappdata(0,'sarco_conc_user_areacell_roi',sarco_conc_user_areacell_roi);
    setappdata(0,'sarco_conc_user_areasarco',sarco_conc_user_areasarco);
    setappdata(0,'sarco_conc_user_areasarco_roi',sarco_conc_user_areasarco_roi);
    setappdata(0,'sarco_conc_user_slider',sarco_conc_user_slider);
    setappdata(0,'sarco_conc_user_slider_minT',sarco_conc_user_slider_minT);
    setappdata(0,'sarco_conc_user_slider_maxT',sarco_conc_user_slider_maxT);
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

%make fig visible
set(h_conc(1).fig,'visible','on');

%move main window to the side
movegui(h_main(1).fig,'west')

function conc_push_draw(hObject, eventdata, h_conc)
%disable fig during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));


try
%load shared
sarco_conc_user_counter=getappdata(0,'sarco_conc_user_counter');
sarco_conc_user_angle=getappdata(0,'sarco_conc_user_angle');
sarco_conc_user_minor=getappdata(0,'sarco_conc_user_minor');
sarco_conc_user_major=getappdata(0,'sarco_conc_user_major');
sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');
sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
sarco_conc_user_outlinex=getappdata(0,'sarco_conc_user_outlinex');
sarco_conc_user_outliney=getappdata(0,'sarco_conc_user_outliney');
sarco_conc_user_binary1=getappdata(0,'sarco_conc_user_binary1');
sarco_conc_user_binarysarc=getappdata(0,'sarco_conc_user_binarysarc');
sarco_conc_user_areacell=getappdata(0,'sarco_conc_user_areacell');
sarco_conc_user_areacell_roi=getappdata(0,'sarco_conc_user_areacell_roi');
sarco_conc_user_areasarco=getappdata(0,'sarco_conc_user_areasarco');
sarco_conc_user_areasarco_roi=getappdata(0,'sarco_conc_user_areasarco_roi');
sarco_conc_user_binary_roi=getappdata(0,'sarco_conc_user_binary_roi');
sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');

%open preview frame
image=sarco_init_user_preview_frame1{sarco_conc_user_counter};

%show in new fig
hf=figure;
imshow(image);hold on;

%user drawn polynom conc
hFH=impoly;

%get cell blobb
binaryImage = hFH.createMask();
sarco_conc_user_binary1{sarco_conc_user_counter}=binaryImage;

%get position
pos = getPosition(hFH); %returns the current position of the freehand region h. The returned position, pos, is an N-by-2 array [X1 Y1;...;XN YN].
xp_s=pos(:,1);
yp_s=pos(:,2);

%close fig
close(hf);

%dislay boundary in axes
reset(h_conc(1).axes_outline)
axes(h_conc(1).axes_outline)
imshow(normalise(image));hold on;
plot([xp_s;xp_s(1)],[yp_s;yp_s(1)],'r')

%get new new para
r1=regionprops(binaryImage,'MajorAxisLength','MinorAxisLength','Orientation','Area');
m1=r1.MajorAxisLength*sarco_init_user_conversion{sarco_conc_user_counter};
O1=r1.Orientation;
b1=r1.MinorAxisLength*sarco_init_user_conversion{sarco_conc_user_counter};
sarco_conc_user_areacell{sarco_conc_user_counter}=r1.Area;

%display new para
set(h_conc(1).edit_angle,'String',num2str(O1))
set(h_conc(1).edit_minor,'String',num2str(b1))
set(h_conc(1).edit_major,'String',num2str(m1))
set(h_conc(1).edit_ratio,'String',num2str(m1/(b1+eps)))

%axes 4: colormapped binary ims
%which parts are background:neither in binary1 nor in binarysarc
if isempty(sarco_conc_user_binary1{sarco_conc_user_counter})
    bin_background=~sarco_conc_user_binarysarc{sarco_conc_user_counter};
    bin_cell=zeros(size(bin_background,1),size(bin_background,2));
    bin_sarco=sarco_conc_user_binarysarc{sarco_conc_user_counter};
else
    bin_background=~(sarco_conc_user_binarysarc{sarco_conc_user_counter}|sarco_conc_user_binary1{sarco_conc_user_counter});
    bin_cell=sarco_conc_user_binary1{sarco_conc_user_counter};
    bin_sarco=sarco_conc_user_binarysarc{sarco_conc_user_counter};
end
rgbimage=cat(3,double(bin_sarco),double(bin_background),double(bin_cell));
cla(h_conc(1).axes_concentration)
axes(h_conc(1).axes_concentration)
imshow(rgbimage)

%calculate concentration:only parts of sarco blobb inide cell are taken
%into account !
if isempty(sarco_conc_user_areasarco{sarco_conc_user_counter})||isempty(sarco_conc_user_areacell{sarco_conc_user_counter})
    set(h_conc(1).edit_concentration,'String','NaN');
elseif ~any(sarco_conc_user_binarysarc{sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter})
    set(h_conc(1).edit_concentration,'String','NaN');
else
    r2=regionprops(sarco_conc_user_binarysarc{sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter},'Area');
    sarco_conc_user_areasarco{sarco_conc_user_counter}=r2.Area;
    set(h_conc(1).edit_concentration,'String',num2str(sarco_conc_user_areasarco{sarco_conc_user_counter}/(eps+sarco_conc_user_areacell{sarco_conc_user_counter})))
end

%sarcomere area inside rois
if sarco_conc_user_number_roi(sarco_conc_user_counter)>0
    %sarcomere area inside selection
    if ~isempty(sarco_conc_user_binary_roi{sarco_conc_user_number_roi(sarco_conc_user_counter),sarco_conc_user_counter})&&~isempty(sarco_conc_user_binary1{sarco_conc_user_counter})&&~isempty(sarco_conc_user_binarysarc{sarco_conc_user_counter})
        r2=regionprops(sarco_conc_user_binary_roi{sarco_conc_user_number_roi(sarco_conc_user_counter),sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter}.*sarco_conc_user_binarysarc{sarco_conc_user_counter},'Area');
        sarco_conc_user_areasarco_roi{sarco_conc_user_number_roi(sarco_conc_user_counter),sarco_conc_user_counter}=r2.Area;
    end
end

%update para
sarco_conc_user_angle(sarco_conc_user_counter)=O1;
sarco_conc_user_minor(sarco_conc_user_counter)=b1;
sarco_conc_user_major(sarco_conc_user_counter)=m1;
sarco_conc_user_outlinex{sarco_conc_user_counter}=xp_s;
sarco_conc_user_outliney{sarco_conc_user_counter}=yp_s;

%save for shared use
setappdata(0,'sarco_conc_user_angle',sarco_conc_user_angle);
setappdata(0,'sarco_conc_user_minor',sarco_conc_user_minor);
setappdata(0,'sarco_conc_user_major',sarco_conc_user_major);
setappdata(0,'sarco_conc_user_outlinex',sarco_conc_user_outlinex);
setappdata(0,'sarco_conc_user_outliney',sarco_conc_user_outliney);
setappdata(0,'sarco_conc_user_binary1',sarco_conc_user_binary1);
setappdata(0,'sarco_conc_user_areacell',sarco_conc_user_areacell);
setappdata(0,'sarco_conc_user_areacell_roi',sarco_conc_user_areacell_roi);
setappdata(0,'sarco_conc_user_areasarco',sarco_conc_user_areasarco);
setappdata(0,'sarco_conc_user_areasarco_roi',sarco_conc_user_areasarco_roi);
catch
end

function conc_push_addroi(hObject, eventdata, h_conc)
%disable fig during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));

try
%load shared
sarco_conc_user_counter=getappdata(0,'sarco_conc_user_counter');
sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
sarco_conc_user_outlinex_roi=getappdata(0,'sarco_conc_user_outlinex_roi');
sarco_conc_user_outliney_roi=getappdata(0,'sarco_conc_user_outliney_roi');
sarco_conc_user_binary_roi=getappdata(0,'sarco_conc_user_binary_roi');
sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');
sarco_conc_user_areasarco_roi=getappdata(0,'sarco_conc_user_areasarco_roi');
sarco_conc_user_areacell_roi=getappdata(0,'sarco_conc_user_areacell_roi');
sarco_conc_user_binary1=getappdata(0,'sarco_conc_user_binary1');
sarco_conc_user_binarysarc=getappdata(0,'sarco_conc_user_binarysarc');

%load the relax frame image
image=sarco_init_user_preview_frame1{sarco_conc_user_counter};

%show in new fig
hf=figure;
imshow(image);hold on;
for i=1:sarco_conc_user_number_roi(sarco_conc_user_counter)
    plot([sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter};sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter}(1)],[sarco_conc_user_outliney_roi{i,sarco_conc_user_counter};sarco_conc_user_outliney_roi{i,sarco_conc_user_counter}(1)],'r')
end

%user drawn polynom conc
hFH=impoly;

%get cell blobb
binaryImage = hFH.createMask();
sarco_conc_user_binary_roi{sarco_conc_user_number_roi(sarco_conc_user_counter)+1,sarco_conc_user_counter}=binaryImage;

%get position
pos = getPosition(hFH); %returns the current position of the freehand region h. The returned position, pos, is an N-by-2 array [X1 Y1;...;XN YN].
xp_s=pos(:,1);
yp_s=pos(:,2);

%close fig
close(hf);

%dislay boundary in axes
reset(h_conc(1).axes_roi)
axes(h_conc(1).axes_roi)
imshow(image);hold on;
for i=1:sarco_conc_user_number_roi(sarco_conc_user_counter)
    plot([sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter};sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter}(1)],[sarco_conc_user_outliney_roi{i,sarco_conc_user_counter};sarco_conc_user_outliney_roi{i,sarco_conc_user_counter}(1)],'r')
end
plot([xp_s;xp_s(1)],[yp_s;yp_s(1)],'r')

%cell area inside selection
if ~isempty(sarco_conc_user_binary_roi{sarco_conc_user_number_roi(sarco_conc_user_counter)+1,sarco_conc_user_counter})&&~isempty(sarco_conc_user_binary1{sarco_conc_user_counter})
    r2=regionprops(sarco_conc_user_binary_roi{sarco_conc_user_number_roi(sarco_conc_user_counter)+1,sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter},'Area');
    sarco_conc_user_areacell_roi{sarco_conc_user_number_roi(sarco_conc_user_counter)+1,sarco_conc_user_counter}=r2.Area;
end

%sarcomere area inside
if ~isempty(sarco_conc_user_binary_roi{sarco_conc_user_number_roi(sarco_conc_user_counter)+1,sarco_conc_user_counter})&&~isempty(sarco_conc_user_binary1{sarco_conc_user_counter})&&~isempty(sarco_conc_user_binarysarc{sarco_conc_user_counter})
    r2=regionprops(sarco_conc_user_binary_roi{sarco_conc_user_number_roi(sarco_conc_user_counter)+1,sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter}.*sarco_conc_user_binarysarc{sarco_conc_user_counter},'Area');
    sarco_conc_user_areasarco_roi{sarco_conc_user_number_roi(sarco_conc_user_counter)+1,sarco_conc_user_counter}=r2.Area;
end

%update para
sarco_conc_user_number_roi(sarco_conc_user_counter)=sarco_conc_user_number_roi(sarco_conc_user_counter)+1;
sarco_conc_user_outlinex_roi{sarco_conc_user_number_roi(sarco_conc_user_counter),sarco_conc_user_counter}=xp_s;
sarco_conc_user_outliney_roi{sarco_conc_user_number_roi(sarco_conc_user_counter),sarco_conc_user_counter}=yp_s;

%save for shared use
setappdata(0,'sarco_conc_user_number_roi',sarco_conc_user_number_roi);
setappdata(0,'sarco_conc_user_outlinex_roi',sarco_conc_user_outlinex_roi);
setappdata(0,'sarco_conc_user_outliney_roi',sarco_conc_user_outliney_roi);
setappdata(0,'sarco_conc_user_binary_roi',sarco_conc_user_binary_roi);
setappdata(0,'sarco_conc_user_areasarco_roi',sarco_conc_user_areasarco_roi);
setappdata(0,'sarco_conc_user_areacell_roi',sarco_conc_user_areacell_roi);

catch
end

function conc_push_clearroi(hObject, eventdata, h_conc)
%disable fig during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));


try
%load shared
sarco_conc_user_counter=getappdata(0,'sarco_conc_user_counter');
sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
sarco_conc_user_outlinex_roi=getappdata(0,'sarco_conc_user_outlinex_roi');
sarco_conc_user_outliney_roi=getappdata(0,'sarco_conc_user_outliney_roi');
sarco_conc_user_binary_roi=getappdata(0,'sarco_conc_user_binary_roi');
sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');
sarco_conc_user_areasarco_roi=getappdata(0,'sarco_conc_user_areasarco_roi');
sarco_conc_user_areacell_roi=getappdata(0,'sarco_conc_user_areacell_roi');

%load the 1st frame image
image=sarco_init_user_preview_frame1{sarco_conc_user_counter};

%dislay boundary in axes
reset(h_conc(1).axes_roi)
axes(h_conc(1).axes_roi)
imshow(image);hold on;

%update para
for i=1:sarco_conc_user_number_roi(sarco_conc_user_counter)
    sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter}={};
    sarco_conc_user_outliney_roi{i,sarco_conc_user_counter}={};
    sarco_conc_user_binary_roi{i,sarco_conc_user_counter}={};
    sarco_conc_user_areasarco_roi{i,sarco_conc_user_counter}={};
    sarco_conc_user_areacell_roi{i,sarco_conc_user_counter}={};
end
sarco_conc_user_number_roi(sarco_conc_user_counter)=0;

%save for shared use
setappdata(0,'sarco_conc_user_number_roi',sarco_conc_user_number_roi);
setappdata(0,'sarco_conc_user_outlinex_roi',sarco_conc_user_outlinex_roi);
setappdata(0,'sarco_conc_user_outliney_roi',sarco_conc_user_outliney_roi);
setappdata(0,'sarco_conc_user_binary_roi',sarco_conc_user_binary_roi);
setappdata(0,'sarco_conc_user_areasarco_roi',sarco_conc_user_areasarco_roi);

catch
end

function conc_push_forwards(hObject, eventdata, h_conc)
%disable fig during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));


try
    %load what shared para we need
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_conc_user_counter=getappdata(0,'sarco_conc_user_counter');
    sarco_conc_user_angle=getappdata(0,'sarco_conc_user_angle');
    sarco_conc_user_minor=getappdata(0,'sarco_conc_user_minor');
    sarco_conc_user_major=getappdata(0,'sarco_conc_user_major');
    sarco_conc_user_outlinex=getappdata(0,'sarco_conc_user_outlinex');
    sarco_conc_user_outliney=getappdata(0,'sarco_conc_user_outliney');
    sarco_conc_user_outlinex_roi=getappdata(0,'sarco_conc_user_outlinex_roi');
    sarco_conc_user_outliney_roi=getappdata(0,'sarco_conc_user_outliney_roi');
    sarco_conc_user_counter_roi=getappdata(0,'sarco_conc_user_counter_roi');
    sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');
    sarco_conc_user_slider=getappdata(0,'sarco_conc_user_slider');
    sarco_conc_user_slider_maxT=getappdata(0,'sarco_conc_user_slider_maxT');
    sarco_conc_user_slider_minT=getappdata(0,'sarco_conc_user_slider_minT');
    sarco_conc_user_areacell=getappdata(0,'sarco_conc_user_areacell');
    sarco_conc_user_areasarco=getappdata(0,'sarco_conc_user_areasarco');
    sarco_conc_user_binary1=getappdata(0,'sarco_conc_user_binary1');
    sarco_conc_user_binarysarc=getappdata(0,'sarco_conc_user_binarysarc');
    
    %save current slider values
    sarco_conc_user_slider_maxT{sarco_conc_user_counter}=get(h_conc(1).slider,'Max');
    sarco_conc_user_slider_minT{sarco_conc_user_counter}=get(h_conc(1).slider,'Min'); 
    sarco_conc_user_slider{sarco_conc_user_counter}=get(h_conc(1).slider,'Value');
    
    %update counter
    sarco_conc_user_counter=sarco_conc_user_counter+1;
    
    %did user input rois for current?
    if sarco_conc_user_counter_roi(sarco_conc_user_counter)
        set(h_conc(1).checkbox,'Value',1);
    else
        set(h_conc(1).checkbox,'Value',0);
    end
    
    %preview image
    image=sarco_init_user_preview_frame1{sarco_conc_user_counter};
    
    %conc
    %set image
    reset(h_conc(1).axes_outline)
    axes(h_conc(1).axes_outline)
    imshow(image);hold on;
    %show boundary if it exists for current vid.
    xp_s=sarco_conc_user_outlinex{sarco_conc_user_counter};
    yp_s=sarco_conc_user_outliney{sarco_conc_user_counter};
    if ~isempty(xp_s) && ~isempty(yp_s)
        plot([xp_s;xp_s(1)],[yp_s;yp_s(1)],'r')
    end
    %set para
    set(h_conc(1).edit_angle,'String',num2str(sarco_conc_user_angle(sarco_conc_user_counter)));
    set(h_conc(1).edit_minor,'String',num2str(sarco_conc_user_minor(sarco_conc_user_counter)));
    set(h_conc(1).edit_major,'String',num2str(sarco_conc_user_major(sarco_conc_user_counter)));
    set(h_conc(1).edit_ratio,'String',num2str(sarco_conc_user_major(sarco_conc_user_counter)/(sarco_conc_user_minor(sarco_conc_user_counter)+eps)));
    
    
    if sarco_conc_user_counter_roi(sarco_conc_user_counter)
        %set image
        reset(h_conc(1).axes_roi)
        axes(h_conc(1).axes_roi)
        imshow(image);hold on;
        %show boundary if it exists for current vid.
        for i=1:sarco_conc_user_number_roi(sarco_conc_user_counter)
            if ~isempty(sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter}) && ~isempty(sarco_conc_user_outliney_roi{i,sarco_conc_user_counter})
                plot([sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter};sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter}(1)],[sarco_conc_user_outliney_roi{i,sarco_conc_user_counter};sarco_conc_user_outliney_roi{i,sarco_conc_user_counter}(1)],'r')
            end
        end
    end
    
    %change uipanel visibility accordingly
    if sarco_conc_user_counter_roi(sarco_conc_user_counter)
        set(h_conc(1).panel_roi,'Visible','on')
    else
        set(h_conc(1).panel_roi,'Visible','off')
    end
    
    
    %enable/disable forward/backward buttons
    if sarco_conc_user_counter<sarco_init_user_Nfiles
        set(h_conc(1).button_forwards,'Enable','on')
    else
        set(h_conc(1).button_forwards,'Enable','off')
    end
    if sarco_conc_user_counter>1
        set(h_conc(1).button_backwards,'Enable','on')
    else
        set(h_conc(1).button_backwards,'Enable','off')
    end
    
    %set texts to 1st vid
    set(h_conc(1).text_whichvidname,'String',sarco_init_user_filenamestack{1,sarco_conc_user_counter});
    set(h_conc(1).text_whichvid,'String',[num2str(sarco_conc_user_counter),'/',num2str(sarco_init_user_Nfiles)]);
    
    %display bounds for binary threshold
    set(h_conc(1).slider,'Max',sarco_conc_user_slider_maxT{sarco_conc_user_counter});
    set(h_conc(1).slider,'Min',sarco_conc_user_slider_minT{sarco_conc_user_counter});
    set(h_conc(1).slider,'Value',sarco_conc_user_slider{sarco_conc_user_counter});
    set(h_conc(1).slider, 'SliderStep', [(sarco_conc_user_slider_maxT{sarco_conc_user_counter}-sarco_conc_user_slider_minT{sarco_conc_user_counter})/10, (sarco_conc_user_slider_maxT{sarco_conc_user_counter}-sarco_conc_user_slider_minT{sarco_conc_user_counter})/50]);
    
    %display binary 1st frame for this
    thresh=get(h_conc(1).slider,'Value');
    binary=sarco_init_user_preview_frame1{sarco_conc_user_counter}>thresh;
    sarco_conc_user_binarysarc{sarco_conc_user_counter} = imfill(binary, 'holes');
    measurements = regionprops(sarco_conc_user_binarysarc{sarco_conc_user_counter}, 'Area');
    sarco_conc_user_areasarco{sarco_conc_user_counter}=sum([measurements.Area]);
    
    %axes 4: colormapped binary ims
    %which parts are background:neither in binary1 nor in binarysarc
    if isempty(sarco_conc_user_binary1{sarco_conc_user_counter})
        bin_background=~sarco_conc_user_binarysarc{sarco_conc_user_counter};
        bin_cell=zeros(size(bin_background,1),size(bin_background,2));
        bin_sarco=sarco_conc_user_binarysarc{sarco_conc_user_counter};
    else
        bin_background=~(sarco_conc_user_binarysarc{sarco_conc_user_counter}|sarco_conc_user_binary1{sarco_conc_user_counter});
        bin_cell=sarco_conc_user_binary1{sarco_conc_user_counter};
        bin_sarco=sarco_conc_user_binarysarc{sarco_conc_user_counter};
    end
    rgbimage=cat(3,double(bin_sarco),double(bin_background),double(bin_cell));
    cla(h_conc(1).axes_concentration)
    axes(h_conc(1).axes_concentration)
    imshow(rgbimage)
    
    %calculate concentration
    if isempty(sarco_conc_user_areasarco{sarco_conc_user_counter})||isempty(sarco_conc_user_areacell{sarco_conc_user_counter})
        set(h_conc(1).edit_concentration,'String','NaN');
    elseif ~any(sarco_conc_user_binarysarc{sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter})
        set(h_conc(1).edit_concentration,'String','NaN');
    else
        r2=regionprops(sarco_conc_user_binarysarc{sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter},'Area');
        sarco_conc_user_areasarco{sarco_conc_user_counter}=r2.Area;
        set(h_conc(1).edit_concentration,'String',num2str(sarco_conc_user_areasarco{sarco_conc_user_counter}/(eps+sarco_conc_user_areacell{sarco_conc_user_counter})))
    end
    
    %store everything for shared use
    setappdata(0,'sarco_conc_user_counter',sarco_conc_user_counter)
    setappdata(0,'sarco_conc_user_binarysarc',sarco_conc_user_binarysarc)
    setappdata(0,'sarco_conc_user_areasarco',sarco_conc_user_areasarco)
        setappdata(0,'sarco_conc_user_slider',sarco_conc_user_slider)
    setappdata(0,'sarco_conc_user_slider_minT',sarco_conc_user_slider_minT)
    setappdata(0,'sarco_conc_user_slider_maxT',sarco_conc_user_slider_maxT)
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function conc_push_backwards(hObject, eventdata, h_conc)
%disable fig during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));


try
    %load what shared para we need
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_conc_user_counter=getappdata(0,'sarco_conc_user_counter');
    sarco_conc_user_angle=getappdata(0,'sarco_conc_user_angle');
    sarco_conc_user_minor=getappdata(0,'sarco_conc_user_minor');
    sarco_conc_user_major=getappdata(0,'sarco_conc_user_major');
    sarco_conc_user_outlinex=getappdata(0,'sarco_conc_user_outlinex');
    sarco_conc_user_outliney=getappdata(0,'sarco_conc_user_outliney');
    sarco_conc_user_outlinex_roi=getappdata(0,'sarco_conc_user_outlinex_roi');
    sarco_conc_user_outliney_roi=getappdata(0,'sarco_conc_user_outliney_roi');
    sarco_conc_user_counter_roi=getappdata(0,'sarco_conc_user_counter_roi');
    sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');
    sarco_conc_user_slider=getappdata(0,'sarco_conc_user_slider');
    sarco_conc_user_slider_maxT=getappdata(0,'sarco_conc_user_slider_maxT');
    sarco_conc_user_slider_minT=getappdata(0,'sarco_conc_user_slider_minT');
    sarco_conc_user_areacell=getappdata(0,'sarco_conc_user_areacell');
    sarco_conc_user_areasarco=getappdata(0,'sarco_conc_user_areasarco');
    sarco_conc_user_binary1=getappdata(0,'sarco_conc_user_binary1');
    sarco_conc_user_binarysarc=getappdata(0,'sarco_conc_user_binarysarc');
    
    %save current slider values
    sarco_conc_user_slider_maxT{sarco_conc_user_counter}=get(h_conc(1).slider,'Max');
    sarco_conc_user_slider_minT{sarco_conc_user_counter}=get(h_conc(1).slider,'Min'); 
    sarco_conc_user_slider{sarco_conc_user_counter}=get(h_conc(1).slider,'Value');
        
    %update counter
    sarco_conc_user_counter=sarco_conc_user_counter-1;
    
    %did user input rois for current?
    if sarco_conc_user_counter_roi(sarco_conc_user_counter)
        set(h_conc(1).checkbox,'Value',1);
    else
        set(h_conc(1).checkbox,'Value',0);
    end
    
    %preview image
    image=sarco_init_user_preview_frame1{sarco_conc_user_counter};
    
    %conc
    %set image
    reset(h_conc(1).axes_outline)
    axes(h_conc(1).axes_outline)
    imshow(image);hold on;
    %show boundary if it exists for current vid.
    xp_s=sarco_conc_user_outlinex{sarco_conc_user_counter};
    yp_s=sarco_conc_user_outliney{sarco_conc_user_counter};
    if ~isempty(xp_s) && ~isempty(yp_s)
        plot([xp_s;xp_s(1)],[yp_s;yp_s(1)],'r')
    end
    %set para
    set(h_conc(1).edit_angle,'String',num2str(sarco_conc_user_angle(sarco_conc_user_counter)));
    set(h_conc(1).edit_minor,'String',num2str(sarco_conc_user_minor(sarco_conc_user_counter)));
    set(h_conc(1).edit_major,'String',num2str(sarco_conc_user_major(sarco_conc_user_counter)));
    set(h_conc(1).edit_ratio,'String',num2str(sarco_conc_user_major(sarco_conc_user_counter)/(sarco_conc_user_minor(sarco_conc_user_counter)+eps)));
    
    
    if sarco_conc_user_counter_roi(sarco_conc_user_counter)
        %set image
        reset(h_conc(1).axes_roi)
        axes(h_conc(1).axes_roi)
        imshow(image);hold on;
        %show boundary if it exists for current vid.
        for i=1:sarco_conc_user_number_roi(sarco_conc_user_counter)
            if ~isempty(sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter}) && ~isempty(sarco_conc_user_outliney_roi{i,sarco_conc_user_counter})
                plot([sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter};sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter}(1)],[sarco_conc_user_outliney_roi{i,sarco_conc_user_counter};sarco_conc_user_outliney_roi{i,sarco_conc_user_counter}(1)],'r')
            end
        end
    end
    
    %change uipanel visibility accordingly
    if sarco_conc_user_counter_roi(sarco_conc_user_counter)
        set(h_conc(1).panel_roi,'Visible','on')
    else
        set(h_conc(1).panel_roi,'Visible','off')
    end
    
    
    %enable/disable forward/backward buttons
    if sarco_conc_user_counter<sarco_init_user_Nfiles
        set(h_conc(1).button_forwards,'Enable','on')
    else
        set(h_conc(1).button_forwards,'Enable','off')
    end
    if sarco_conc_user_counter>1
        set(h_conc(1).button_backwards,'Enable','on')
    else
        set(h_conc(1).button_backwards,'Enable','off')
    end
    
    %set texts to 1st vid
    set(h_conc(1).text_whichvidname,'String',sarco_init_user_filenamestack{1,sarco_conc_user_counter});
    set(h_conc(1).text_whichvid,'String',[num2str(sarco_conc_user_counter),'/',num2str(sarco_init_user_Nfiles)]);
    
    %display bounds for binary threshold
    set(h_conc(1).slider,'Max',sarco_conc_user_slider_maxT{sarco_conc_user_counter});
    set(h_conc(1).slider,'Min',sarco_conc_user_slider_minT{sarco_conc_user_counter});
    set(h_conc(1).slider,'Value',sarco_conc_user_slider{sarco_conc_user_counter});
    set(h_conc(1).slider, 'SliderStep', [(sarco_conc_user_slider_maxT{sarco_conc_user_counter}-sarco_conc_user_slider_minT{sarco_conc_user_counter})/10, (sarco_conc_user_slider_maxT{sarco_conc_user_counter}-sarco_conc_user_slider_minT{sarco_conc_user_counter})/50]);
    
    %display binary 1st frame for this
    thresh=get(h_conc(1).slider,'Value');
    binary=sarco_init_user_preview_frame1{sarco_conc_user_counter}>thresh;
    sarco_conc_user_binarysarc{sarco_conc_user_counter} = imfill(binary, 'holes');
    measurements = regionprops(sarco_conc_user_binarysarc{sarco_conc_user_counter}, 'Area');
    sarco_conc_user_areasarco{sarco_conc_user_counter}=sum([measurements.Area]);
    
    %axes 4: colormapped binary ims
    %which parts are background:neither in binary1 nor in binarysarc
    if isempty(sarco_conc_user_binary1{sarco_conc_user_counter})
        bin_background=~sarco_conc_user_binarysarc{sarco_conc_user_counter};
        bin_cell=zeros(size(bin_background,1),size(bin_background,2));
        bin_sarco=sarco_conc_user_binarysarc{sarco_conc_user_counter};
    else
        bin_background=~(sarco_conc_user_binarysarc{sarco_conc_user_counter}|sarco_conc_user_binary1{sarco_conc_user_counter});
        bin_cell=sarco_conc_user_binary1{sarco_conc_user_counter};
        bin_sarco=sarco_conc_user_binarysarc{sarco_conc_user_counter};
    end
    rgbimage=cat(3,double(bin_sarco),double(bin_background),double(bin_cell));
    cla(h_conc(1).axes_concentration)
    axes(h_conc(1).axes_concentration)
    imshow(rgbimage)
    
    %calculate concentration
    if isempty(sarco_conc_user_areasarco{sarco_conc_user_counter})||isempty(sarco_conc_user_areacell{sarco_conc_user_counter})
        set(h_conc(1).edit_concentration,'String','NaN');
    elseif ~any(sarco_conc_user_binarysarc{sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter})
        set(h_conc(1).edit_concentration,'String','NaN');
    else
        r2=regionprops(sarco_conc_user_binarysarc{sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter},'Area');
        sarco_conc_user_areasarco{sarco_conc_user_counter}=r2.Area;
        set(h_conc(1).edit_concentration,'String',num2str(sarco_conc_user_areasarco{sarco_conc_user_counter}/(eps+sarco_conc_user_areacell{sarco_conc_user_counter})))
    end
    
    
    
    %store everything for shared use
    setappdata(0,'sarco_conc_user_counter',sarco_conc_user_counter)
    setappdata(0,'sarco_conc_user_binarysarc',sarco_conc_user_binarysarc)
    setappdata(0,'sarco_conc_user_areasarco',sarco_conc_user_areasarco)
    setappdata(0,'sarco_conc_user_slider',sarco_conc_user_slider)
    setappdata(0,'sarco_conc_user_slider_minT',sarco_conc_user_slider_minT)
    setappdata(0,'sarco_conc_user_slider_maxT',sarco_conc_user_slider_maxT)
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function conc_push_ok(hObject, eventdata, h_conc, h_main)
%disable fig during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
%clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));

try    
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_cellname=getappdata(0,'sarco_init_user_cellname');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_pathnamestack=getappdata(0,'sarco_init_user_pathnamestack');
    sarco_conc_user_binary1=getappdata(0,'sarco_conc_user_binary1');
    sarco_conc_user_slider=getappdata(0,'sarco_conc_user_slider');
    sarco_conc_user_slider_maxT=getappdata(0,'sarco_conc_user_slider_maxT');
    sarco_conc_user_slider_minT=getappdata(0,'sarco_conc_user_slider_minT');
    sarco_conc_user_counter=getappdata(0,'sarco_conc_user_counter');
    
    %first check: has user entered all cell outlines
    for ivid=1:sarco_init_user_Nfiles
        if isempty(sarco_conc_user_binary1{ivid})
            errordlg('Please draw all necessary cell outlines.','Error');
            enableDisableFig(h_conc(1).fig,1)
            return;
        end
    end
    
    %save masks
    for ivid=1:sarco_init_user_Nfiles
        sb=statusbar(h_conc(1).fig,['Saving... ',num2str(floor(100*(ivid-1)/sarco_init_user_Nfiles)), '%% done']);
        sb.getComponent(0).setForeground(java.awt.Color.red);
        %mask folder
        if ~isequal(exist([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Mask'], 'dir'),7)
            mkdir([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Mask'])
        end
        mask=sarco_conc_user_binary1{ivid};
        save([sarco_init_user_pathnamestack{1,ivid},'/',sarco_init_user_filenamestack{1,ivid},'/Mask/mask_',sarco_init_user_cellname{ivid},'.mat'],'mask','-v7.3')
    end
    
    %save current slider values
    sarco_conc_user_slider_maxT{sarco_conc_user_counter}=get(h_conc(1).slider,'Max');
    sarco_conc_user_slider_minT{sarco_conc_user_counter}=get(h_conc(1).slider,'Min');
    sarco_conc_user_slider{sarco_conc_user_counter}=get(h_conc(1).slider,'Value');
    
    setappdata(0,'sarco_conc_user_slider',sarco_conc_user_slider)
    setappdata(0,'sarco_conc_user_slider_minT',sarco_conc_user_slider_minT)
    setappdata(0,'sarco_conc_user_slider_maxT',sarco_conc_user_slider_maxT)
    
    %update statusbar
    sb=statusbar(h_conc(1).fig,'Saving - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %change main windows 3. button status
    set(h_main(1).button_conc,'ForegroundColor',[0 .5 0]);
    set(h_main(1).button_piv,'Enable','on');
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

%enable fig
enableDisableFig(h_conc(1).fig,1)

%close window
close(h_conc(1).fig);

%move main window to center
%move main window to the side
movegui(h_main(1).fig,'center')

function conc_slider(hObject, eventdata, h_conc)
%disable fig during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));


try
    %load
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    sarco_conc_user_binary1=getappdata(0,'sarco_conc_user_binary1');
    sarco_conc_user_binarysarc=getappdata(0,'sarco_conc_user_binarysarc');
    sarco_conc_user_areacell=getappdata(0,'sarco_conc_user_areacell');
    sarco_conc_user_areasarco=getappdata(0,'sarco_conc_user_areasarco');
    sarco_conc_user_areasarco_roi=getappdata(0,'sarco_conc_user_areasarco_roi');
    sarco_conc_user_binary_roi=getappdata(0,'sarco_conc_user_binary_roi');
    sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');
    sarco_conc_user_counter=getappdata(0,'sarco_conc_user_counter');
    
    %display binary 1st frame for this
    thresh=get(h_conc(1).slider,'Value');
    binary=sarco_init_user_preview_frame1{sarco_conc_user_counter}>thresh;
    sarco_conc_user_binarysarc{sarco_conc_user_counter} = imfill(binary, 'holes');
    measurements = regionprops(sarco_conc_user_binarysarc{sarco_conc_user_counter}, 'Area');
    sarco_conc_user_areasarco{sarco_conc_user_counter}=sum([measurements.Area]);
    
    %axes 4: colormapped binary ims
    %which parts are background:neither in binary1 nor in binarysarc
    if isempty(sarco_conc_user_binary1{sarco_conc_user_counter})
        bin_background=~sarco_conc_user_binarysarc{sarco_conc_user_counter};
        bin_cell=zeros(size(bin_background,1),size(bin_background,2));
        bin_sarco=sarco_conc_user_binarysarc{sarco_conc_user_counter};
    else
        bin_background=~(sarco_conc_user_binarysarc{sarco_conc_user_counter}|sarco_conc_user_binary1{sarco_conc_user_counter});
        bin_cell=sarco_conc_user_binary1{sarco_conc_user_counter};
        bin_sarco=sarco_conc_user_binarysarc{sarco_conc_user_counter};
    end
    rgbimage=cat(3,double(bin_sarco),double(bin_background),double(bin_cell));
    cla(h_conc(1).axes_concentration)
    axes(h_conc(1).axes_concentration)
    imshow(rgbimage)
    
    %calculate concentration
    if isempty(sarco_conc_user_areasarco{sarco_conc_user_counter})||isempty(sarco_conc_user_areacell{sarco_conc_user_counter})
        set(h_conc(1).edit_concentration,'String','NaN');
    else
        r2=regionprops(sarco_conc_user_binarysarc{sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter},'Area');
        sarco_conc_user_areasarco{sarco_conc_user_counter}=r2.Area;
        set(h_conc(1).edit_concentration,'String',num2str(sarco_conc_user_areasarco{sarco_conc_user_counter}/(eps+sarco_conc_user_areacell{sarco_conc_user_counter})))
    end
    
    
    %sarcomere area inside rois
    if sarco_conc_user_number_roi(sarco_conc_user_counter)>0
        %sarcomere area inside selection
        if ~isempty(sarco_conc_user_binary_roi{sarco_conc_user_number_roi(sarco_conc_user_counter),sarco_conc_user_counter})&&~isempty(sarco_conc_user_binary1{sarco_conc_user_counter})&&~isempty(sarco_conc_user_binarysarc{sarco_conc_user_counter})
            r2=regionprops(sarco_conc_user_binary_roi{sarco_conc_user_number_roi(sarco_conc_user_counter),sarco_conc_user_counter}.*sarco_conc_user_binary1{sarco_conc_user_counter}.*sarco_conc_user_binarysarc{sarco_conc_user_counter},'Area');
            sarco_conc_user_areasarco_roi{sarco_conc_user_number_roi(sarco_conc_user_counter),sarco_conc_user_counter}=r2.Area;
        end
    end
    
    setappdata(0,'sarco_conc_user_areasarco',sarco_conc_user_areasarco);
    setappdata(0,'sarco_conc_user_binarysarc',sarco_conc_user_binarysarc);
    setappdata(0,'sarco_conc_user_areasarco_roi',sarco_conc_user_areasarco_roi);
catch
end

function conc_checkbox(hObject, eventdata, h_conc)
%disable figure during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));


try
    %load shared
    sarco_conc_user_counter=getappdata(0,'sarco_conc_user_counter');
    sarco_conc_user_counter_roi=getappdata(0,'sarco_conc_user_counter_roi');
    sarco_conc_user_outlinex_roi=getappdata(0,'sarco_conc_user_outlinex_roi');
    sarco_conc_user_outliney_roi=getappdata(0,'sarco_conc_user_outliney_roi');
    sarco_conc_user_number_roi=getappdata(0,'sarco_conc_user_number_roi');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    
    %get value of checkbox
    i2=get(h_conc(1).checkbox,'Value');
    
    %change tags accordingly
    if i2
        sarco_conc_user_counter_roi(sarco_conc_user_counter)=1;
    else
        sarco_conc_user_counter_roi(sarco_conc_user_counter)=0;
    end
    
    %load the 1st frame image, and the parameters for uipanel2
    image=sarco_init_user_preview_frame1{sarco_conc_user_counter};
    if i2
        %set image
        reset(h_conc(1).axes_roi)
        axes(h_conc(1).axes_roi)
        imshow(image);hold on;
        %show boundary if it exists for current vid.
        for i=1:sarco_conc_user_number_roi(sarco_conc_user_counter)
            if ~isempty(sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter}) && ~isempty(sarco_conc_user_outliney_roi{i,sarco_conc_user_counter})
                plot([sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter};sarco_conc_user_outlinex_roi{i,sarco_conc_user_counter}(1)],[sarco_conc_user_outliney_roi{i,sarco_conc_user_counter};sarco_conc_user_outliney_roi{i,sarco_conc_user_counter}(1)],'r')
            end
        end
    end
    
    %change uipanel visibility accordingly
    if i2
        set(h_conc(1).panel_roi,'Visible','on')
    else
        set(h_conc(1).panel_roi,'Visible','off')
    end
    
    %save for shared use
    setappdata(0,'sarco_conc_user_counter_roi',sarco_conc_user_counter_roi)
    
catch
end