%bf_conc.m ; part of the Brightfield GUI: execute bf_main.m
%version 2.0
%written by O. Schwab (oschwab@stanford.edu)
%last change: 11/03/14

function bf_conc(h_main)
%main function for the outline&concentration window of bf gui

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
    'Name','Brightfield Outline',...
    'NumberTitle','off',...
    'Resize','off',...
    'Color',[.94,.94,.94],...
    'visible','off');

%create uipanel for cell outline & draw button
%uipanel:
h_conc(1).panel_outline = uipanel('Parent',h_conc(1).fig,'Title','Cell outline','units','pixels','Position',[20,190,760,250]);
%button: draw outline
h_conc(1).button_draw = uicontrol('Parent',h_conc(1).panel_outline,'style','pushbutton','position',[5,15,75,25],'string','Draw outline');
%axes: display first frame of current
h_conc(1).axes_outline = axes('Parent',h_conc(1).panel_outline,'Units', 'pixels','Position',[5,55,745,175]);
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
%checkbox
set(h_conc(1).checkbox,'callback',{@conc_checkbox,h_conc})

%populate stuff when window first opens
try
    %load what shared para we need
    bf_init_user_Nfiles=getappdata(0,'bf_init_user_Nfiles');
    bf_init_user_filenamestack=getappdata(0,'bf_init_user_filenamestack');
    bf_init_user_preview_frame1=getappdata(0,'bf_init_user_preview_frame1');
    
    %initiate counter (which video)
    bf_conc_user_counter=1;
    %make a counter to find out what user selected (roi/conc)
    bf_conc_user_counter_roi=zeros(1,bf_init_user_Nfiles);
    %initialise parameter vectors for angle, minor, major and ratio
    bf_conc_user_angle=NaN*ones(1,bf_init_user_Nfiles);
    bf_conc_user_minor=NaN*ones(1,bf_init_user_Nfiles);
    bf_conc_user_major=NaN*ones(1,bf_init_user_Nfiles);
    %initialize cells for conc blobb and boundary coord.
    bf_conc_user_outlinex=cell(1,bf_init_user_Nfiles);
    bf_conc_user_outliney=cell(1,bf_init_user_Nfiles);
    bf_conc_user_binary1=cell(1,bf_init_user_Nfiles);
    %initalize for roi
    bf_conc_user_number_roi=zeros(1,bf_init_user_Nfiles);
    bf_conc_user_outlinex_roi=cell(5,bf_init_user_Nfiles); %inital. with 5 rois
    bf_conc_user_outliney_roi=cell(5,bf_init_user_Nfiles);
    bf_conc_user_binary_roi=cell(5,bf_init_user_Nfiles);
        
    %turn off visibility of panels
    set(h_conc(1).panel_outline,'Visible','on')
    set(h_conc(1).panel_roi,'Visible','off')
    set(h_conc(1).panel_roichoice,'Visible','on')
    
    %buttons
    if bf_conc_user_counter>1
        set(h_conc(1).button_backwards,'Enable','on');
    else
        set(h_conc(1).button_backwards,'Enable','off');
    end
    if bf_conc_user_counter==bf_init_user_Nfiles
        set(h_conc(1).button_forwards,'Enable','off');
    else
        set(h_conc(1).button_forwards,'Enable','on');
    end
    
    %set texts to 1st vid
    set(h_conc(1).text_whichvidname,'String',bf_init_user_filenamestack{1,bf_conc_user_counter});
    set(h_conc(1).text_whichvid,'String',[num2str(bf_conc_user_counter),'/',num2str(bf_init_user_Nfiles)]);
    
    %display 1st frame of 1st vid in axes
    reset(h_conc(1).axes_outline)
    axes(h_conc(1).axes_outline)
    imshow(bf_init_user_preview_frame1{bf_conc_user_counter});hold on;
 
    %store everything for shared use
    setappdata(0,'bf_conc_user_counter',bf_conc_user_counter)
    setappdata(0,'bf_conc_user_counter_roi',bf_conc_user_counter_roi)
    setappdata(0,'bf_conc_user_angle',bf_conc_user_angle)
    setappdata(0,'bf_conc_user_minor',bf_conc_user_minor)
    setappdata(0,'bf_conc_user_major',bf_conc_user_major)
    setappdata(0,'bf_conc_user_outlinex',bf_conc_user_outlinex);
    setappdata(0,'bf_conc_user_outliney',bf_conc_user_outliney);
    setappdata(0,'bf_conc_user_binary1',bf_conc_user_binary1);
    setappdata(0,'bf_conc_user_number_roi',bf_conc_user_number_roi);
    setappdata(0,'bf_conc_user_outlinex_roi',bf_conc_user_outlinex_roi);
    setappdata(0,'bf_conc_user_outliney_roi',bf_conc_user_outliney_roi);
    setappdata(0,'bf_conc_user_binary_roi',bf_conc_user_binary_roi);
    
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
bf_conc_user_counter=getappdata(0,'bf_conc_user_counter');
bf_conc_user_angle=getappdata(0,'bf_conc_user_angle');
bf_conc_user_minor=getappdata(0,'bf_conc_user_minor');
bf_conc_user_major=getappdata(0,'bf_conc_user_major');
bf_init_user_conversion=getappdata(0,'bf_init_user_conversion');
bf_init_user_preview_frame1=getappdata(0,'bf_init_user_preview_frame1');
bf_conc_user_outlinex=getappdata(0,'bf_conc_user_outlinex');
bf_conc_user_outliney=getappdata(0,'bf_conc_user_outliney');
bf_conc_user_binary1=getappdata(0,'bf_conc_user_binary1');

%open preview frame
image=bf_init_user_preview_frame1{bf_conc_user_counter};

%show in new fig
hf=figure;
imshow(image);hold on;

%user drawn polynom conc
hFH=impoly;

%get cell blobb
binaryImage = hFH.createMask();
bf_conc_user_binary1{bf_conc_user_counter}=binaryImage;

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
r1=regionprops(binaryImage,'MajorAxisLength','MinorAxisLength','Orientation');
m1=r1.MajorAxisLength*bf_init_user_conversion{bf_conc_user_counter};
O1=r1.Orientation;
b1=r1.MinorAxisLength*bf_init_user_conversion{bf_conc_user_counter};
%display new para
set(h_conc(1).edit_angle,'String',num2str(O1))
set(h_conc(1).edit_minor,'String',num2str(b1))
set(h_conc(1).edit_major,'String',num2str(m1))
set(h_conc(1).edit_ratio,'String',num2str(m1/(b1+eps)))


%update para
bf_conc_user_angle(bf_conc_user_counter)=O1;
bf_conc_user_minor(bf_conc_user_counter)=b1;
bf_conc_user_major(bf_conc_user_counter)=m1;
bf_conc_user_outlinex{bf_conc_user_counter}=xp_s;
bf_conc_user_outliney{bf_conc_user_counter}=yp_s;

%save for shared use
setappdata(0,'bf_conc_user_angle',bf_conc_user_angle);
setappdata(0,'bf_conc_user_minor',bf_conc_user_minor);
setappdata(0,'bf_conc_user_major',bf_conc_user_major);
setappdata(0,'bf_conc_user_outlinex',bf_conc_user_outlinex);
setappdata(0,'bf_conc_user_outliney',bf_conc_user_outliney);
setappdata(0,'bf_conc_user_binary1',bf_conc_user_binary1);
catch
end

function conc_push_addroi(hObject, eventdata, h_conc)
%disable fig during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));

try
%load shared
bf_conc_user_counter=getappdata(0,'bf_conc_user_counter');
bf_init_user_preview_frame1=getappdata(0,'bf_init_user_preview_frame1');
bf_conc_user_outlinex_roi=getappdata(0,'bf_conc_user_outlinex_roi');
bf_conc_user_outliney_roi=getappdata(0,'bf_conc_user_outliney_roi');
bf_conc_user_binary_roi=getappdata(0,'bf_conc_user_binary_roi');
bf_conc_user_number_roi=getappdata(0,'bf_conc_user_number_roi');
bf_conc_user_binary1=getappdata(0,'bf_conc_user_binary1');

%load the relax frame image
image=bf_init_user_preview_frame1{bf_conc_user_counter};

%show in new fig
hf=figure;
imshow(image);hold on;
for i=1:bf_conc_user_number_roi(bf_conc_user_counter)
    plot([bf_conc_user_outlinex_roi{i,bf_conc_user_counter};bf_conc_user_outlinex_roi{i,bf_conc_user_counter}(1)],[bf_conc_user_outliney_roi{i,bf_conc_user_counter};bf_conc_user_outliney_roi{i,bf_conc_user_counter}(1)],'r')
end

%user drawn polynom conc
hFH=impoly;

%get cell blobb
binaryImage = hFH.createMask();
bf_conc_user_binary_roi{bf_conc_user_number_roi(bf_conc_user_counter)+1,bf_conc_user_counter}=binaryImage;

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
for i=1:bf_conc_user_number_roi(bf_conc_user_counter)
    plot([bf_conc_user_outlinex_roi{i,bf_conc_user_counter};bf_conc_user_outlinex_roi{i,bf_conc_user_counter}(1)],[bf_conc_user_outliney_roi{i,bf_conc_user_counter};bf_conc_user_outliney_roi{i,bf_conc_user_counter}(1)],'r')
end
plot([xp_s;xp_s(1)],[yp_s;yp_s(1)],'r')

%update para
bf_conc_user_number_roi(bf_conc_user_counter)=bf_conc_user_number_roi(bf_conc_user_counter)+1;
bf_conc_user_outlinex_roi{bf_conc_user_number_roi(bf_conc_user_counter),bf_conc_user_counter}=xp_s;
bf_conc_user_outliney_roi{bf_conc_user_number_roi(bf_conc_user_counter),bf_conc_user_counter}=yp_s;

%save for shared use
setappdata(0,'bf_conc_user_number_roi',bf_conc_user_number_roi);
setappdata(0,'bf_conc_user_outlinex_roi',bf_conc_user_outlinex_roi);
setappdata(0,'bf_conc_user_outliney_roi',bf_conc_user_outliney_roi);
setappdata(0,'bf_conc_user_binary_roi',bf_conc_user_binary_roi);

catch
end

function conc_push_clearroi(hObject, eventdata, h_conc)
%disable fig during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));


try
%load shared
bf_conc_user_counter=getappdata(0,'bf_conc_user_counter');
bf_init_user_preview_frame1=getappdata(0,'bf_init_user_preview_frame1');
bf_conc_user_outlinex_roi=getappdata(0,'bf_conc_user_outlinex_roi');
bf_conc_user_outliney_roi=getappdata(0,'bf_conc_user_outliney_roi');
bf_conc_user_binary_roi=getappdata(0,'bf_conc_user_binary_roi');
bf_conc_user_number_roi=getappdata(0,'bf_conc_user_number_roi');

%load the 1st frame image
image=bf_init_user_preview_frame1{bf_conc_user_counter};

%dislay boundary in axes
reset(h_conc(1).axes_roi)
axes(h_conc(1).axes_roi)
imshow(image);hold on;

%update para
for i=1:bf_conc_user_number_roi(bf_conc_user_counter)
    bf_conc_user_outlinex_roi{i,bf_conc_user_counter}={};
    bf_conc_user_outliney_roi{i,bf_conc_user_counter}={};
    bf_conc_user_binary_roi{i,bf_conc_user_counter}={};
end
bf_conc_user_number_roi(bf_conc_user_counter)=0;

%save for shared use
setappdata(0,'bf_conc_user_number_roi',bf_conc_user_number_roi);
setappdata(0,'bf_conc_user_outlinex_roi',bf_conc_user_outlinex_roi);
setappdata(0,'bf_conc_user_outliney_roi',bf_conc_user_outliney_roi);
setappdata(0,'bf_conc_user_binary_roi',bf_conc_user_binary_roi);

catch
end

function conc_push_forwards(hObject, eventdata, h_conc)
%disable fig during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));


try
    %load what shared para we need
    bf_init_user_Nfiles=getappdata(0,'bf_init_user_Nfiles');
    bf_init_user_filenamestack=getappdata(0,'bf_init_user_filenamestack');
    bf_init_user_preview_frame1=getappdata(0,'bf_init_user_preview_frame1');
    bf_conc_user_counter=getappdata(0,'bf_conc_user_counter');
    bf_conc_user_angle=getappdata(0,'bf_conc_user_angle');
    bf_conc_user_minor=getappdata(0,'bf_conc_user_minor');
    bf_conc_user_major=getappdata(0,'bf_conc_user_major');
    bf_conc_user_outlinex=getappdata(0,'bf_conc_user_outlinex');
    bf_conc_user_outliney=getappdata(0,'bf_conc_user_outliney');
    bf_conc_user_outlinex_roi=getappdata(0,'bf_conc_user_outlinex_roi');
    bf_conc_user_outliney_roi=getappdata(0,'bf_conc_user_outliney_roi');
    bf_conc_user_counter_roi=getappdata(0,'bf_conc_user_counter_roi');
    bf_conc_user_number_roi=getappdata(0,'bf_conc_user_number_roi');
      
    %update counter
    bf_conc_user_counter=bf_conc_user_counter+1;
    
    %did user input rois for current?
    if bf_conc_user_counter_roi(bf_conc_user_counter)
        set(h_conc(1).checkbox,'Value',1);
    else
        set(h_conc(1).checkbox,'Value',0);
    end
    
    %preview image
    image=bf_init_user_preview_frame1{bf_conc_user_counter};
    
    %conc
    %set image
    reset(h_conc(1).axes_outline)
    axes(h_conc(1).axes_outline)
    imshow(image);hold on;
    %show boundary if it exists for current vid.
    xp_s=bf_conc_user_outlinex{bf_conc_user_counter};
    yp_s=bf_conc_user_outliney{bf_conc_user_counter};
    if ~isempty(xp_s) && ~isempty(yp_s)
        plot([xp_s;xp_s(1)],[yp_s;yp_s(1)],'r')
    end
    %set para
    set(h_conc(1).edit_angle,'String',num2str(bf_conc_user_angle(bf_conc_user_counter)));
    set(h_conc(1).edit_minor,'String',num2str(bf_conc_user_minor(bf_conc_user_counter)));
    set(h_conc(1).edit_major,'String',num2str(bf_conc_user_major(bf_conc_user_counter)));
    set(h_conc(1).edit_ratio,'String',num2str(bf_conc_user_major(bf_conc_user_counter)/(bf_conc_user_minor(bf_conc_user_counter)+eps)));
    
    
    if bf_conc_user_counter_roi(bf_conc_user_counter)
        %set image
        reset(h_conc(1).axes_roi)
        axes(h_conc(1).axes_roi)
        imshow(image);hold on;
        %show boundary if it exists for current vid.
        for i=1:bf_conc_user_number_roi(bf_conc_user_counter)
            if ~isempty(bf_conc_user_outlinex_roi{i,bf_conc_user_counter}) && ~isempty(bf_conc_user_outliney_roi{i,bf_conc_user_counter})
                plot([bf_conc_user_outlinex_roi{i,bf_conc_user_counter};bf_conc_user_outlinex_roi{i,bf_conc_user_counter}(1)],[bf_conc_user_outliney_roi{i,bf_conc_user_counter};bf_conc_user_outliney_roi{i,bf_conc_user_counter}(1)],'r')
            end
        end
    end
    
    %change uipanel visibility accordingly
    if bf_conc_user_counter_roi(bf_conc_user_counter)
        set(h_conc(1).panel_roi,'Visible','on')
    else
        set(h_conc(1).panel_roi,'Visible','off')
    end
    
    
    %enable/disable forward/backward buttons
    if bf_conc_user_counter<bf_init_user_Nfiles
        set(h_conc(1).button_forwards,'Enable','on')
    else
        set(h_conc(1).button_forwards,'Enable','off')
    end
    if bf_conc_user_counter>1
        set(h_conc(1).button_backwards,'Enable','on')
    else
        set(h_conc(1).button_backwards,'Enable','off')
    end
    
    %set texts to 1st vid
    set(h_conc(1).text_whichvidname,'String',bf_init_user_filenamestack{1,bf_conc_user_counter});
    set(h_conc(1).text_whichvid,'String',[num2str(bf_conc_user_counter),'/',num2str(bf_init_user_Nfiles)]);
    
       
    %store everything for shared use
    setappdata(0,'bf_conc_user_counter',bf_conc_user_counter)
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
    bf_init_user_Nfiles=getappdata(0,'bf_init_user_Nfiles');
    bf_init_user_filenamestack=getappdata(0,'bf_init_user_filenamestack');
    bf_init_user_preview_frame1=getappdata(0,'bf_init_user_preview_frame1');
    bf_conc_user_counter=getappdata(0,'bf_conc_user_counter');
    bf_conc_user_angle=getappdata(0,'bf_conc_user_angle');
    bf_conc_user_minor=getappdata(0,'bf_conc_user_minor');
    bf_conc_user_major=getappdata(0,'bf_conc_user_major');
    bf_conc_user_outlinex=getappdata(0,'bf_conc_user_outlinex');
    bf_conc_user_outliney=getappdata(0,'bf_conc_user_outliney');
    bf_conc_user_outlinex_roi=getappdata(0,'bf_conc_user_outlinex_roi');
    bf_conc_user_outliney_roi=getappdata(0,'bf_conc_user_outliney_roi');
    bf_conc_user_counter_roi=getappdata(0,'bf_conc_user_counter_roi');
    bf_conc_user_number_roi=getappdata(0,'bf_conc_user_number_roi');
        
    %update counter
    bf_conc_user_counter=bf_conc_user_counter-1;
    
    %did user input rois for current?
    if bf_conc_user_counter_roi(bf_conc_user_counter)
        set(h_conc(1).checkbox,'Value',1);
    else
        set(h_conc(1).checkbox,'Value',0);
    end
    
    %preview image
    image=bf_init_user_preview_frame1{bf_conc_user_counter};
    
    %conc
    %set image
    reset(h_conc(1).axes_outline)
    axes(h_conc(1).axes_outline)
    imshow(image);hold on;
    %show boundary if it exists for current vid.
    xp_s=bf_conc_user_outlinex{bf_conc_user_counter};
    yp_s=bf_conc_user_outliney{bf_conc_user_counter};
    if ~isempty(xp_s) && ~isempty(yp_s)
        plot([xp_s;xp_s(1)],[yp_s;yp_s(1)],'r')
    end
    %set para
    set(h_conc(1).edit_angle,'String',num2str(bf_conc_user_angle(bf_conc_user_counter)));
    set(h_conc(1).edit_minor,'String',num2str(bf_conc_user_minor(bf_conc_user_counter)));
    set(h_conc(1).edit_major,'String',num2str(bf_conc_user_major(bf_conc_user_counter)));
    set(h_conc(1).edit_ratio,'String',num2str(bf_conc_user_major(bf_conc_user_counter)/(bf_conc_user_minor(bf_conc_user_counter)+eps)));
    
    
    if bf_conc_user_counter_roi(bf_conc_user_counter)
        %set image
        reset(h_conc(1).axes_roi)
        axes(h_conc(1).axes_roi)
        imshow(image);hold on;
        %show boundary if it exists for current vid.
        for i=1:bf_conc_user_number_roi(bf_conc_user_counter)
            if ~isempty(bf_conc_user_outlinex_roi{i,bf_conc_user_counter}) && ~isempty(bf_conc_user_outliney_roi{i,bf_conc_user_counter})
                plot([bf_conc_user_outlinex_roi{i,bf_conc_user_counter};bf_conc_user_outlinex_roi{i,bf_conc_user_counter}(1)],[bf_conc_user_outliney_roi{i,bf_conc_user_counter};bf_conc_user_outliney_roi{i,bf_conc_user_counter}(1)],'r')
            end
        end
    end
    
    %change uipanel visibility accordingly
    if bf_conc_user_counter_roi(bf_conc_user_counter)
        set(h_conc(1).panel_roi,'Visible','on')
    else
        set(h_conc(1).panel_roi,'Visible','off')
    end
    
    
    %enable/disable forward/backward buttons
    if bf_conc_user_counter<bf_init_user_Nfiles
        set(h_conc(1).button_forwards,'Enable','on')
    else
        set(h_conc(1).button_forwards,'Enable','off')
    end
    if bf_conc_user_counter>1
        set(h_conc(1).button_backwards,'Enable','on')
    else
        set(h_conc(1).button_backwards,'Enable','off')
    end
    
    %set texts to 1st vid
    set(h_conc(1).text_whichvidname,'String',bf_init_user_filenamestack{1,bf_conc_user_counter});
    set(h_conc(1).text_whichvid,'String',[num2str(bf_conc_user_counter),'/',num2str(bf_init_user_Nfiles)]);
    
    
    %store everything for shared use
    setappdata(0,'bf_conc_user_counter',bf_conc_user_counter)
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
    bf_init_user_Nfiles=getappdata(0,'bf_init_user_Nfiles');
    bf_init_user_cellname=getappdata(0,'bf_init_user_cellname');
    bf_init_user_filenamestack=getappdata(0,'bf_init_user_filenamestack');
    bf_init_user_pathnamestack=getappdata(0,'bf_init_user_pathnamestack');
    bf_conc_user_binary1=getappdata(0,'bf_conc_user_binary1');
    
    %first check: has user entered all cell outlines
    for ivid=1:bf_init_user_Nfiles
        if isempty(bf_conc_user_binary1{ivid})
            errordlg('Please draw all necessary cell outlines.','Error');
            enableDisableFig(h_conc(1).fig,1)
            return;
        end
    end
    
    %save masks
    for ivid=1:bf_init_user_Nfiles
        sb=statusbar(h_conc(1).fig,['Saving... ',num2str(floor(100*(ivid-1)/bf_init_user_Nfiles)), '%% done']);
        sb.getComponent(0).setForeground(java.awt.Color.red);
        %mask folder
        if ~isequal(exist([bf_init_user_pathnamestack{1,ivid},bf_init_user_filenamestack{1,ivid},'/Mask'], 'dir'),7)
            mkdir([bf_init_user_pathnamestack{1,ivid},bf_init_user_filenamestack{1,ivid},'/Mask'])
        end
        mask=bf_conc_user_binary1{ivid};
        save([bf_init_user_pathnamestack{1,ivid},'/',bf_init_user_filenamestack{1,ivid},'/Mask/mask_',bf_init_user_cellname{ivid},'.mat'],'mask','-v7.3')
    end
    
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

function conc_checkbox(hObject, eventdata, h_conc)
%disable figure during calculation
enableDisableFig(h_conc(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_conc(1).fig,1));


try
    %load shared
    bf_conc_user_counter=getappdata(0,'bf_conc_user_counter');
    bf_conc_user_counter_roi=getappdata(0,'bf_conc_user_counter_roi');
    bf_conc_user_outlinex_roi=getappdata(0,'bf_conc_user_outlinex_roi');
    bf_conc_user_outliney_roi=getappdata(0,'bf_conc_user_outliney_roi');
    bf_conc_user_number_roi=getappdata(0,'bf_conc_user_number_roi');
    bf_init_user_preview_frame1=getappdata(0,'bf_init_user_preview_frame1');
    
    %get value of checkbox
    i2=get(h_conc(1).checkbox,'Value');
    
    %change tags accordingly
    if i2
        bf_conc_user_counter_roi(bf_conc_user_counter)=1;
    else
        bf_conc_user_counter_roi(bf_conc_user_counter)=0;
    end
    
    %load the 1st frame image, and the parameters for uipanel2
    image=bf_init_user_preview_frame1{bf_conc_user_counter};
    if i2
        %set image
        reset(h_conc(1).axes_roi)
        axes(h_conc(1).axes_roi)
        imshow(image);hold on;
        %show boundary if it exists for current vid.
        for i=1:bf_conc_user_number_roi(bf_conc_user_counter)
            if ~isempty(bf_conc_user_outlinex_roi{i,bf_conc_user_counter}) && ~isempty(bf_conc_user_outliney_roi{i,bf_conc_user_counter})
                plot([bf_conc_user_outlinex_roi{i,bf_conc_user_counter};bf_conc_user_outlinex_roi{i,bf_conc_user_counter}(1)],[bf_conc_user_outliney_roi{i,bf_conc_user_counter};bf_conc_user_outliney_roi{i,bf_conc_user_counter}(1)],'r')
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
    setappdata(0,'bf_conc_user_counter_roi',bf_conc_user_counter_roi)
    
catch
end