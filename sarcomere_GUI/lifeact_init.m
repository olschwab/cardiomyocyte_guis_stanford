%lifeact_init.m ; part of the Lifeact GUI: execute lifeact_main.m
%version 2.0.1
%written by O. Schwab (oschwab@stanford.edu)
%last change: 01/04/15

function lifeact_init(h_main)
%main function for the initilization window of lifeact gui

%create new window for initialization
%figure size
figuresize=[450,800];
%get screen size
screensize = get(0,'ScreenSize');
%position figure on center of screen
xpos = ceil((screensize(3)-figuresize(2))/2);
ypos = ceil((screensize(4)-figuresize(1))/2);
%create figure; invisible at first
h_init(1).fig=figure(...
    'position',[xpos, ypos, figuresize(2), figuresize(1)],...
    'units','pixels',...
    'renderer','OpenGL',...
    'MenuBar','none',...
    'PaperPositionMode','auto',...
    'Name','Lifeact Initialization',...
    'NumberTitle','off',...
    'Resize','off',...
    'Color',[.94,.94,.94],...
    'visible','off');

%create uipanel for readin & buttons
%uipanel: contains readin button for videos and folders
h_init(1).panel_read = uipanel('Parent',h_init(1).fig,'Title','Open 1 or more video files','units','pixels','Position',[20,355,155,80]);
%button 1: read in videos
h_init(1).button_readvid = uicontrol('Parent',h_init(1).panel_read,'style','pushbutton','position',[5,35,140,25],'string','Add video (tif, czi, avi)');
%button 2: read in folder
h_init(1).button_readfolder = uicontrol('Parent',h_init(1).panel_read,'style','pushbutton','position',[5,5,140,25],'string','Add images folder');

%create uipanel to display and delete loaded videos
%uipanel: list all the loaded videos, invisible
h_init(1).panel_list = uipanel('Parent',h_init(1).fig,'Title','List of loaded videos','units','pixels','Position',[20,45,155,305],'visible','off');
%listbox 1: lists videos
h_init(1).listbox_display = uicontrol('Parent',h_init(1).panel_list,'style','listbox','position',[5,35,140,250]);
%button 3: delte current video
h_init(1).button_delete = uicontrol('Parent',h_init(1).panel_list,'style','pushbutton','position',[5,5,140,25],'string','Delete selected');

%create uipanel to display video information and first frame
%uipanel: 
h_init(1).panel_vid = uipanel('Parent',h_init(1).fig,'Title','Video information','units','pixels','Position',[190,45,590,390],'visible','off');
%axes: display first frame of current
h_init(1).axes_curr = axes('Parent',h_init(1).panel_vid,'Units', 'pixels','Position',[5,35,575,290]);
%button 4: forwards
h_init(1).button_forwards = uicontrol('Parent',h_init(1).panel_vid,'style','pushbutton','position',[560,5,25,25],'string','>');
%button 5: backwards
h_init(1).button_backwards = uicontrol('Parent',h_init(1).panel_vid,'style','pushbutton','position',[535,5,25,25],'string','<');
%button 6: draw mask
%h_init(1).button_draw = uicontrol('Parent',h_init(1).panel_vid,'style','pushbutton','position',[490,335,45,20],'string','Draw');
%button 7: load mask
%h_init(1).button_load = uicontrol('Parent',h_init(1).panel_vid,'style','pushbutton','position',[535,335,45,20],'string','Load');
%text 1: show which video (i/n)
h_init(1).text_whichvid = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[490,5,25,15],'string','(1/1)','HorizontalAlignment','left');
%text 2: show fps
h_init(1).text_fps = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[10,355,150,15],'string','Frames per second','HorizontalAlignment','left');
%text 3: show conversion
h_init(1).text_conversion = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[10,335,150,15],'string','Conversion to micron','HorizontalAlignment','left');
%text 4: show number of frames
h_init(1).text_nframes = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[250,355,150,15],'string','Number of frames','HorizontalAlignment','left');
%text 5: show cellname
h_init(1).text_cellname = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[250,335,150,15],'string','Cell name','HorizontalAlignment','left');
%text 6: optional mask
%h_init(1).text_mask = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[490,355,80,15],'string','Optional mask','HorizontalAlignment','center');
%text 7: show which video (name)
h_init(1).text_whichvidname = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[5,5,200,15],'string','Experiment','HorizontalAlignment','left');
%edit 1: fps
h_init(1).edit_fps = uicontrol('Parent',h_init(1).panel_vid,'style','edit','position',[130,355,80,15],'HorizontalAlignment','center');
%edit 2: conversion
h_init(1).edit_conversion = uicontrol('Parent',h_init(1).panel_vid,'style','edit','position',[130,335,80,15],'HorizontalAlignment','center');
%edit 3: number of frames
h_init(1).edit_nframes = uicontrol('Parent',h_init(1).panel_vid,'style','edit','position',[370,355,80,15],'HorizontalAlignment','center');
%edit 4: cellname
h_init(1).edit_cellname = uicontrol('Parent',h_init(1).panel_vid,'style','edit','position',[370,335,80,15],'HorizontalAlignment','center');

%create ok button
h_init(1).button_ok = uicontrol('Parent',h_init(1).fig,'style','pushbutton','position',[735,25,45,20],'string','OK','visible','off');

%assign callbacks to buttons
%button 1
set(h_init(1).button_readvid,'callback',{@init_push_readvid,h_init})
%button 2
set(h_init(1).button_readfolder,'callback',{@init_push_readfolder,h_init})
%button 4
set(h_init(1).button_delete,'callback',{@init_push_delete,h_init})
%button 5
set(h_init(1).button_forwards,'callback',{@init_push_forwards,h_init})
%button 6
set(h_init(1).button_backwards,'callback',{@init_push_backwards,h_init})
%button 7
%set(h_init(1).button_draw,'callback',{@init_push_draw,h_init})
%button 8
%set(h_init(1).button_load,'callback',{@init_push_load,h_init})
%button 9
set(h_init(1).button_ok,'callback',{@init_push_ok,h_init,h_main})

%if there are already files on the stack, make the other panels visible too
%and show parameters
if ~isempty(getappdata(0,'sarco_init_user_filenamestack'))                          %files on stack
    %load shared parameters
    sarco_init_user_counter=getappdata(0,'sarco_init_user_counter');                %current video number
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');                  %number of videos
    sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');          %conversion factor: 1px=?micron
    sarco_init_user_framerate=getappdata(0,'sarco_init_user_framerate');            %framerate
    sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');                %number of frames
    sarco_init_user_cellname=getappdata(0,'sarco_init_user_cellname');              %cellname
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');    %filestack
    sarco_init_user_vidext=getappdata(0,'sarco_init_user_vidext');                  %video extension
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');  %preview frame for each video
    
    %change display strings and values
    %put video files into listbox
    set(h_init(1).listbox_display,'String',sarco_init_user_filenamestack);
    %select item in listbox
    set(h_init(1).listbox_display,'Value',sarco_init_user_counter);
    %display 1st frame of new video
    axes(h_init(1).axes_curr);
    imshow(sarco_init_user_preview_frame1{sarco_init_user_counter});
    %display new settings
    set(h_init(1).edit_fps,'String',num2str(sarco_init_user_framerate{sarco_init_user_counter}));                               %framerate
    set(h_init(1).edit_conversion,'String',num2str(sarco_init_user_conversion{sarco_init_user_counter}));                       %conversion
    set(h_init(1).edit_nframes,'String',num2str(sarco_init_user_Nframes{sarco_init_user_counter}));                             %number of frames
    set(h_init(1).edit_cellname,'String',sarco_init_user_cellname{sarco_init_user_counter});                                    %cellname
    set(h_init(1).text_whichvidname,'String',[sarco_init_user_filenamestack{1,sarco_init_user_counter},' (showing 1st frame)']);%name of video
    set(h_init(1).text_whichvid,'String',[num2str(sarco_init_user_counter),'/',num2str(sarco_init_user_Nfiles)]);               %which video (i/N)
    
    %set/change properties
    %if tif or avi or folder, user needs to edit edits; disable nframes
    if strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'.tif') || strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'.avi') || strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'none')
        set(h_init(1).edit_fps,'Enable','on');          %enable framerate edit
        set(h_init(1).edit_conversion,'Enable','on');   %enable conversion edit
    else
        set(h_init(1).edit_fps,'Enable','off');         %disable framerate edit
        set(h_init(1).edit_conversion,'Enable','off');  %disable conversion edit
    end
    set(h_init(1).edit_nframes,'Enable','off');         %disable Nframes edit
    %forwards and backwards buttons enable/disable
    if sarco_init_user_counter==sarco_init_user_Nfiles; %if current vid is the last on stack
        set(h_init(1).button_forwards,'Enable','off');  %disable forwards
    else
        set(h_init(1).button_forwards,'Enable','on');   %enable forwards
    end
    if sarco_init_user_counter==1;                      %if current vid is the first on stack
        set(h_init(1).button_backwards,'Enable','off'); %disable backwards
    else
        set(h_init(1).button_backwards,'Enable','on');  %enable backwards
    end
    %panels, button, listbox
    set(h_init(1).panel_vid,'Visible','on');        %show video panel
    set(h_init(1).panel_list,'Visible','on');       %show list panel
    set(h_init(1).button_ok,'Visible','on');        %show button panel
    set(h_init(1).listbox_display,'Enable','off');  %disable listbox editing
else %turn off panels
    set(h_init(1).panel_vid,'Visible','off');       %hide video panel
    set(h_init(1).panel_list,'Visible','off');      %hide list panel
    set(h_init(1).button_ok,'Visible','off');       %hide ok button
end
    
%make figure visible
set(h_init(1).fig,'visible','on');

%move main window to the side
movegui(h_main(1).fig,'west')

function init_push_readvid(hObject, eventdata, h_init)
%reads in a series of videos

%disable figure during calculation
enableDisableFig(h_init(1).fig,0);
%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_init(1).fig,1));

%error catching loop
try
    %load what shared para we need
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_pathnamestack=getappdata(0,'sarco_init_user_pathnamestack');
    sarco_init_user_vidext=getappdata(0,'sarco_init_user_vidext');
    sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');
    sarco_init_user_cellname=getappdata(0,'sarco_init_user_cellname');
    sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');
    sarco_init_user_framerate=getappdata(0,'sarco_init_user_framerate');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    %sarco_init_user_mask=getappdata(0,'sarco_init_user_mask');
    
    
    %load video files: filename: 1xN cell w. strings; pathname string
    [filename,pathname] = uigetfile({'*.czi';'*.tif';'*.avi'},'MultiSelect','on');
    %really a file or did user press cancel?
    if isequal(filename,0)
        return;
    end
    filename = cellstr(filename);
    
    %look if there already files on the image stack
    Nfiles0=size(sarco_init_user_filenamestack,2);
    
    %add new files and paths to stacks
    for i=1:size(filename,2)
        [~,name,ext]=fileparts(strcat(pathname,filename{1,i}));
        sarco_init_user_filenamestack{1,Nfiles0+i}=name;
        sarco_init_user_pathnamestack{1,Nfiles0+i}=pathname;
        sarco_init_user_vidext{1,Nfiles0+i}=ext;
    end
    
    %put video files into listbox
    set(h_init(1).listbox_display,'String',sarco_init_user_filenamestack);
    
    %new number of files
    sarco_init_user_Nfiles=size(sarco_init_user_filenamestack,2);
    
    %loop over vids, and extract data
    for j=1:size(filename,2)
        %update statusbar
        if size(filename,2)==1
            sb=statusbar(h_init(1).fig,'Importing... ');
            sb.getComponent(0).setForeground(java.awt.Color.red);
        else
            sb=statusbar(h_init(1).fig,['Importing... ',num2str(floor(100*(j-1)/size(filename,2))), '%% done']);
            sb.getComponent(0).setForeground(java.awt.Color.red);
        end
        
        %create folder for saving the stuff
        if isequal(exist(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+j}], 'dir'),7)
            rmdir(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+j}],'s')
        end
        mkdir(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+j}])
        
        %check format, load and save:
        if strcmp(sarco_init_user_vidext{1,Nfiles0+j},'.czi')
            %use bioformats for import
            [~,data]=evalc('bfopen([sarco_init_user_pathnamestack{1,Nfiles0+j},sarco_init_user_filenamestack{1,Nfiles0+j},sarco_init_user_vidext{1,Nfiles0+j}]);');
            
            %imagedata
            images=data{1,1}; %images
            N=size(images,1); %number of frames
            
            %save images in variable
            for i=1:N
                imagei=images{i,1};
                %convert to grey
                if ndims(imagei) == 3
                    imagei=rgb2gray(imagei);
                end
                imagei=normalise(imagei);
                %save to mat
                save(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+j},'/image',num2str(i),'.mat'],'imagei','-v7.3')
            end
            
        elseif strcmp(sarco_init_user_vidext{1,Nfiles0+j},'.tif')
            InfoImage=imfinfo([sarco_init_user_pathnamestack{1,Nfiles0+j},sarco_init_user_filenamestack{1,Nfiles0+j},sarco_init_user_vidext{1,Nfiles0+j}]);
            N=length(InfoImage);
            TifLink = Tiff([sarco_init_user_pathnamestack{1,Nfiles0+j},sarco_init_user_filenamestack{1,Nfiles0+j},sarco_init_user_vidext{1,Nfiles0+j}], 'r');
            for i=1:N
                TifLink.setDirectory(i);
                imagei=TifLink.read();
                %convert to grey
                if ndims(imagei) == 3
                    imagei=rgb2gray(imagei);
                end
                imagei=normalise(imagei);
                %save to mat
                save(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+j},'/image',num2str(i),'.mat'],'imagei','-v7.3')
            end
            TifLink.close();
            
        elseif strcmp(sarco_init_user_vidext{1,Nfiles0+j},'.avi')
            videoObj = VideoReader([sarco_init_user_pathnamestack{1,Nfiles0+j},sarco_init_user_filenamestack{1,Nfiles0+j},sarco_init_user_vidext{1,Nfiles0+j}]);
            N = videoObj.NumberOfFrames;
            for i=1:N
                imagei=read(videoObj, i);
                %convert to grey
                if ndims(imagei) == 3
                    imagei=rgb2gray(imagei);
                end
                imagei=normalise(imagei);
                %save to mat
                save(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+j},'/image',num2str(i),'.mat'],'imagei','-v7.3')
            end
        end
        
        
        
        %save preview of 1st frame in workspace for display
        s=load(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+j},'/image1.mat'],'imagei');
        sarco_init_user_preview_frame1{Nfiles0+j}=normalise(s.imagei);
        
        %save mask: initially all ones:
        %sarco_init_user_mask{Nfiles0+j}=ones(size(s.imagei,1),size(s.imagei,2));
        
        %if czi: read metadata, else put the values to NaN;
        if strcmp(sarco_init_user_vidext{1,Nfiles0+j},'.czi')
            %metadata
            omeMeta = data{1, 4};
            metadata = data{1, 2};
            
            %conversion factor px-> um
            voxelSizeX = omeMeta.getPixelsPhysicalSizeX(0).getValue(); % in ?m
            
            %time increment (inverse fps) [general image information: always
            %in: Global Information|Image !!]
            tincrement=str2double(metadata.get('Global Information|Image|T|Interval|Increment #1'));
            
            %for later use:
            sarco_init_user_conversion{Nfiles0+j}=voxelSizeX;
            sarco_init_user_framerate{Nfiles0+j}=1/tincrement;
            sarco_init_user_Nframes{Nfiles0+j}=N;
            sarco_init_user_cellname{Nfiles0+j}='cellname1';
            
            %if tiff or avi
        elseif strcmp(sarco_init_user_vidext{1,Nfiles0+j},'.tif') || strcmp(sarco_init_user_vidext{1,Nfiles0+j},'.avi')
            sarco_init_user_conversion{Nfiles0+j}=NaN;
            sarco_init_user_framerate{Nfiles0+j}=NaN;
            sarco_init_user_Nframes{Nfiles0+j}=N;
            sarco_init_user_cellname{Nfiles0+j}='cellname1';
        end
    end
    %update statusbar
    sb=statusbar(h_init(1).fig,'Import - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %turn on panels
    set(h_init(1).panel_list,'Visible','on');
    set(h_init(1).panel_vid,'Visible','on');
    set(h_init(1).button_ok,'Visible','on');
    
    
    %set para in boxes for 1st video: depending on file extension: enable
    %editing of boxes for fps, conversion
    set(h_init(1).edit_fps,'String',num2str(sarco_init_user_framerate{1}));
    set(h_init(1).edit_conversion,'String',num2str(sarco_init_user_conversion{1}));
    if strcmp(sarco_init_user_vidext{1,1},'.tif') || strcmp(sarco_init_user_vidext{1,1},'.avi') || strcmp(sarco_init_user_vidext{1,1},'none')
        set(h_init(1).edit_fps,'Enable','on');
        set(h_init(1).edit_conversion,'Enable','on');
    else
        set(h_init(1).edit_fps,'Enable','off');
        set(h_init(1).edit_conversion,'Enable','of');
    end
    set(h_init(1).edit_nframes,'String',num2str(sarco_init_user_Nframes{1}));
    set(h_init(1).edit_nframes,'Enable','off');
    
    set(h_init(1).edit_cellname,'String',sarco_init_user_cellname{1});
    set(h_init(1).text_whichvidname,'String',[sarco_init_user_filenamestack{1,1},' (showing 1st frame)']);
    
    %set frame1 of 1st video
    axes(h_init(1).axes_curr);
    imshow(sarco_init_user_preview_frame1{1});
    
    %select item in listbox
    set(h_init(1).listbox_display,'Value',1);
    
    %update text (x/N)
    set(h_init(1).text_whichvid,'String',[num2str(1),'/',num2str(sarco_init_user_Nfiles)]);
    
    %forwards and backwards buttons enable/disable
    if 1==sarco_init_user_Nfiles; %if current vid is the last on stack
        set(h_init(1).button_forwards,'Enable','off');  %disable forwards
    else
        set(h_init(1).button_forwards,'Enable','on');   %enable forwards
    end                     %if current vid is the first on stack
    set(h_init(1).button_backwards,'Enable','off'); %disable backwards
    
    %initiate counter for going through all videos
    sarco_init_user_counter=1;
    
    %store everything for shared use
    setappdata(0,'sarco_init_user_filenamestack',sarco_init_user_filenamestack)
    setappdata(0,'sarco_init_user_pathnamestack',sarco_init_user_pathnamestack)
    setappdata(0,'sarco_init_user_vidext',sarco_init_user_vidext)
    setappdata(0,'sarco_init_user_counter',sarco_init_user_counter)
    setappdata(0,'sarco_init_user_Nfiles',sarco_init_user_Nfiles)
    setappdata(0,'sarco_init_user_cellname',sarco_init_user_cellname)
    setappdata(0,'sarco_init_user_Nframes',sarco_init_user_Nframes)
    setappdata(0,'sarco_init_user_conversion',sarco_init_user_conversion)
    setappdata(0,'sarco_init_user_framerate',sarco_init_user_framerate)
    %setappdata(0,'sarco_init_user_mask',sarco_init_user_mask)
    setappdata(0,'sarco_init_user_preview_frame1',sarco_init_user_preview_frame1)
        
    %grey out back button
    set(h_init(1).button_backwards,'Enable','off');
    
    %grey out listbox
    set(h_init(1).listbox_display,'Enable','off');
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
    
    %if there is an error, and there are no files on the stack, do not
    %display anything
    if isempty(getappdata(0,'sarco_init_user_filenamestack'))
        set(h_init(1).panel_vid,'Visible','off');
        set(h_init(1).panel_list,'Visible','off');
        set(h_init(1).button_ok,'Visible','off');
        
    end
end

function init_push_readfolder(hObject, eventdata, h_init)
%disable figure during calculation
enableDisableFig(h_init(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_init(1).fig,1));


%%error catching loop
try
    
    %load what shared para we need
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_pathnamestack=getappdata(0,'sarco_init_user_pathnamestack');
    sarco_init_user_vidext=getappdata(0,'sarco_init_user_vidext');
    sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');
    sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');
    %sarco_init_user_mask=getappdata(0,'sarco_init_user_mask');
    sarco_init_user_framerate=getappdata(0,'sarco_init_user_framerate');
    sarco_init_user_cellname=getappdata(0,'sarco_init_user_cellname');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    
    
    %load image folder
    foldername = uigetdir;
    
    %really a folder or did user press cancel?
    if isequal(foldername,0)
        return;
    end
    
    
    %foldername = cellstr(foldername);
    
    %what to call this vid?
    name = inputdlg('How do you want to call this vid?');
    
    %look if there already files on the image stack
    Nfiles0=size(sarco_init_user_filenamestack,2);
    
    %add new files and paths to stacks
    sarco_init_user_filenamestack{1,Nfiles0+1}=name{1};
    sarco_init_user_pathnamestack{1,Nfiles0+1}=foldername;
    sarco_init_user_vidext{1,Nfiles0+1}='none';
    
    %put video files into listbox
    set(h_init(1).listbox_display,'String',sarco_init_user_filenamestack);
    
    %new number of files
    sarco_init_user_Nfiles=size(sarco_init_user_filenamestack,2);
    
    %update statusbar
    sb=statusbar(h_init(1).fig,'Importing... ');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    
    %create folder for saving the stuff
    if isequal(exist(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+1}], 'dir'),7)
        rmdir(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+1}],'s')
    end
    mkdir(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+1}])
    
    %number of files
    files = dir([foldername '/*.png']);
    N=length(files);
    for i = 1:N
        filename = [foldername '/' files(i).name];
        imagei=imread(filename);
        %convert to grey
        if ndims(imagei) == 3
        end
        imagei=normalise(imagei);
        %save to mat
        save(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+1},'/image',num2str(i),'.mat'],'imagei','-v7.3')
    end
    
    
    
    %save preview of 1st frame in workspace for display
    s=load(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{1,Nfiles0+1},'/image1.mat'],'imagei');
    sarco_init_user_preview_frame1{Nfiles0+1}=normalise(s.imagei);
    
    %save mask: initially all ones:
    %sarco_init_user_mask{Nfiles0+1}=ones(size(s.imagei,1),size(s.imagei,2));
    
    %metadata to NaN
    sarco_init_user_conversion{Nfiles0+1}=NaN;
    sarco_init_user_framerate{Nfiles0+1}=NaN;
    sarco_init_user_Nframes{Nfiles0+1}=N;
    sarco_init_user_cellname{Nfiles0+1}='cellname1';
    
    %update statusbar
    sb=statusbar(h_init(1).fig,'Import - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %turn on panels
    set(h_init(1).panel_list,'Visible','on');
    set(h_init(1).panel_vid,'Visible','on');
    
    %set para in boxes for 1st video
    %set para in boxes for 1st video: depending on file extension: enable
    %editing of boxes for fps, conversion
    set(h_init(1).edit_fps,'String',num2str(sarco_init_user_framerate{1}));
    set(h_init(1).edit_conversion,'String',num2str(sarco_init_user_conversion{1}));
    if strcmp(sarco_init_user_vidext{1,1},'.tif') || strcmp(sarco_init_user_vidext{1,1},'.avi') || strcmp(sarco_init_user_vidext{1,1},'none')
        set(h_init(1).edit_fps,'Enable','on');
        set(h_init(1).edit_conversion,'Enable','on');
    else
        set(h_init(1).edit_fps,'Enable','off');
        set(h_init(1).edit_conversion,'Enable','of');
    end
    set(h_init(1).edit_nframes,'String',num2str(sarco_init_user_Nframes{1}));
    set(h_init(1).edit_nframes,'Enable','off');
    
    set(h_init(1).edit_cellname,'String',sarco_init_user_cellname{1});
    set(h_init(1).text_whichvidname,'String',[sarco_init_user_filenamestack{1,1},' (showing 1st frame)']);
    
    %set frame1 of 1st video
    axes(h_init(1).axes_curr);
    imshow(sarco_init_user_preview_frame1{1});
    
    %update text (x/N)
    set(h_init(1).text_whichvid,'String',[num2str(1),'/',num2str(sarco_init_user_Nfiles)]);
    
    %if only one vid file: grey out forward button
    if sarco_init_user_Nfiles==1
        set(h_init(1).button_forwards,'Enable','off');
        %enable ok button for czi
        set(h_init(1).button_ok,'Enable','on');
    else
        set(h_init(1).button_forwards,'Enable','on');
    end
    set(h_init(1).button_backwards,'Enable','off'); %disable backwards
    
    
    %initiate counter for going through all videos
    sarco_init_user_counter=1;
    
    %store everything for shared use
    setappdata(0,'sarco_init_user_filenamestack',sarco_init_user_filenamestack)
    setappdata(0,'sarco_init_user_pathnamestack',sarco_init_user_pathnamestack)
    setappdata(0,'sarco_init_user_vidext',sarco_init_user_vidext)
    setappdata(0,'sarco_init_user_counter',sarco_init_user_counter)
    setappdata(0,'sarco_init_user_Nfiles',sarco_init_user_Nfiles)
    setappdata(0,'sarco_init_user_Nframes',sarco_init_user_Nframes)
    setappdata(0,'sarco_init_user_cellname',sarco_init_user_cellname)
    setappdata(0,'sarco_init_user_conversion',sarco_init_user_conversion)
    %setappdata(0,'sarco_init_user_mask',sarco_init_user_mask)
    setappdata(0,'sarco_init_user_framerate',sarco_init_user_framerate)
    setappdata(0,'sarco_init_user_preview_frame1',sarco_init_user_preview_frame1)
    
    
    
    %grey out back button
    set(h_init(1).button_backwards,'Enable','off');
    
    %grey out listbox
    set(h_init(1).listbox_display,'Enable','off');
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
    
    %if there is an error, and there are no files on the stack, do not
    %display anything
    if ~isempty(getappdata(0,'sarco_init_user_filenamestack'))
        %cancel grey out everything
        set(get(h_init(1).uipanel1,'Children'),'Enable','on');
        set(get(h_init(1).panel_list,'Children'),'Enable','on');
        set(h_init(1).text_whichvid,'Enable','on');
        set(h_init(1).text3,'Enable','on');
        set(h_init(1).text4,'Enable','on');
        set(h_init(1).text5,'Enable','on');
        set(h_init(1).text_whichvidname,'Enable','on');
        set(h_init(1).edit_fps,'Enable','on');
        set(h_init(1).edit_conversion,'Enable','on');
        set(h_init(1).edit_nframes,'Enable','on');
        
        %grey out listbox
        set(h_init(1).listbox_display,'Enable','off');
    else
        set(h_init(1).panel_list,'Visible','off');
        set(h_init(1).panel_vid,'Visible','off');
        set(h_init(1).button_ok,'Visible','off');
        
    end
end

function init_push_delete(hObject, eventdata, h_init)
try
    %load what shared para we need
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');
    sarco_init_user_framerate=getappdata(0,'sarco_init_user_framerate');
    sarco_init_user_cellname=getappdata(0,'sarco_init_user_cellname');
    sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_pathnamestack=getappdata(0,'sarco_init_user_pathnamestack');
    sarco_init_user_vidext=getappdata(0,'sarco_init_user_vidext');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    %sarco_init_user_mask=getappdata(0,'sarco_init_user_mask');
    
    %get selected item in listbox
    index=get(h_init(1).listbox_display,'Value');
    
    %to which video does it jump next?
    if index==sarco_init_user_Nfiles
        index_next=index-1;
    else index_next=index;
    end
    
    %remove directory of saved imagedata
    if isequal(exist(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{index}], 'dir'),7)
        rmdir(['vars_DO_NOT_DELETE/',sarco_init_user_filenamestack{index}],'s')
    end
    
    %delete from saved stuff
    sarco_init_user_Nfiles=sarco_init_user_Nfiles-1;
    sarco_init_user_conversion(index)=[];
    sarco_init_user_cellname(index)=[];
    sarco_init_user_framerate(index)=[];
    sarco_init_user_Nframes(index)=[];
    sarco_init_user_filenamestack(index)=[];
    sarco_init_user_pathnamestack(index)=[];
    sarco_init_user_vidext(index)=[];
    sarco_init_user_preview_frame1(index)=[];
    %sarco_init_user_mask(index)=[];
    set(h_init(1).listbox_display,'String',sarco_init_user_filenamestack);
    
    if ~isempty(sarco_init_user_filenamestack)
        %look at vid counter
        sarco_init_user_counter=index_next;
        
        %select item in listbox
        set(h_init(1).listbox_display,'Value',sarco_init_user_counter);
        
        %display 1st frame of new video
        axes(h_init(1).axes_curr);
        imshow(sarco_init_user_preview_frame1{1,sarco_init_user_counter});
        
        %display new settings
        set(h_init(1).edit_fps,'String',num2str(sarco_init_user_framerate{sarco_init_user_counter}));
        set(h_init(1).edit_conversion,'String',num2str(sarco_init_user_conversion{sarco_init_user_counter}));
        set(h_init(1).edit_nframes,'String',num2str(sarco_init_user_Nframes{sarco_init_user_counter}));
        set(h_init(1).edit_nframes,'Enable','off');
        set(h_init(1).edit_cellname,'String',sarco_init_user_cellname{sarco_init_user_counter});
        set(h_init(1).text_whichvidname,'String',[sarco_init_user_filenamestack{1,sarco_init_user_counter},' (showing 1st frame)']);
        if strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'.tif') || strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'.avi') || strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'none')
            set(h_init(1).edit_fps,'Enable','on');
            set(h_init(1).edit_conversion,'Enable','on');
        else
            set(h_init(1).edit_fps,'Enable','off');
            set(h_init(1).edit_conversion,'Enable','of');
        end
        
        %update text (x/N)
        set(h_init(1).text_whichvid,'String',[num2str(sarco_init_user_counter),'/',num2str(sarco_init_user_Nfiles)]);
        
        if sarco_init_user_counter==1;
            set(h_init(1).button_backwards,'Enable','off');
        else
            set(h_init(1).button_backwards,'Enable','on');
        end
        if sarco_init_user_counter==sarco_init_user_Nfiles;
        set(h_init(1).button_forwards,'Enable','off');
        else
        set(h_init(1).button_forwards,'Enable','on');
        end
        
        %grey out listbox
        set(h_init(1).listbox_display,'Enable','off');
        
    else %hide panels etc
        set(h_init(1).panel_list,'Visible','off');
        set(h_init(1).panel_vid,'Visible','off');
        set(h_init(1).button_ok,'Enable','off');
        sarco_init_user_counter=1;
    end
    
    %store everything for shared use
    setappdata(0,'sarco_init_user_filenamestack',sarco_init_user_filenamestack)
    setappdata(0,'sarco_init_user_pathnamestack',sarco_init_user_pathnamestack)
    setappdata(0,'sarco_init_user_vidext',sarco_init_user_vidext)
    setappdata(0,'sarco_init_user_Nfiles',sarco_init_user_Nfiles)
    setappdata(0,'sarco_init_user_Nframes',sarco_init_user_Nframes)
    setappdata(0,'sarco_init_user_cellname',sarco_init_user_cellname)
    setappdata(0,'sarco_init_user_conversion',sarco_init_user_conversion)
    setappdata(0,'sarco_init_user_framerate',sarco_init_user_framerate)
    setappdata(0,'sarco_init_user_framerate',sarco_init_user_framerate)
    setappdata(0,'sarco_init_user_counter',sarco_init_user_counter)
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function init_push_forwards(hObject, eventdata, h_init)
%disable figure during calculation
enableDisableFig(h_init(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_init(1).fig,1));


try
    
    %load what shared para we need
    sarco_init_user_counter=getappdata(0,'sarco_init_user_counter');
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');
    sarco_init_user_framerate=getappdata(0,'sarco_init_user_framerate');
    sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');
    sarco_init_user_cellname=getappdata(0,'sarco_init_user_cellname');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_pathnamestack=getappdata(0,'sarco_init_user_pathnamestack');
    sarco_init_user_vidext=getappdata(0,'sarco_init_user_vidext');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    %sarco_init_user_mask=getappdata(0,'sarco_init_user_mask');
    
    %look at vid counter
    if sarco_init_user_counter<sarco_init_user_Nfiles;
        %save settings
        sarco_init_user_framerate{sarco_init_user_counter}=str2double(get(h_init(1).edit_fps,'String'));
        sarco_init_user_conversion{sarco_init_user_counter}=str2double(get(h_init(1).edit_conversion,'String'));
        sarco_init_user_cellname{sarco_init_user_counter}=get(h_init(1).edit_cellname,'String');
        
        %go to video before
        sarco_init_user_counter=sarco_init_user_counter+1;
        
        %select item in listbox
        set(h_init(1).listbox_display,'Value',sarco_init_user_counter);
        
        %display 1st frame of new video
        axes(h_init(1).axes_curr);
        imshow(sarco_init_user_preview_frame1{sarco_init_user_counter});
        
        %display new settings
        set(h_init(1).edit_fps,'String',num2str(sarco_init_user_framerate{sarco_init_user_counter}));
        set(h_init(1).edit_conversion,'String',num2str(sarco_init_user_conversion{sarco_init_user_counter}));
        set(h_init(1).edit_nframes,'String',num2str(sarco_init_user_Nframes{sarco_init_user_counter}));
        set(h_init(1).edit_nframes,'Enable','off');
        set(h_init(1).edit_cellname,'String',sarco_init_user_cellname{sarco_init_user_counter});
        set(h_init(1).text_whichvidname,'String',[sarco_init_user_filenamestack{1,sarco_init_user_counter},' (showing 1st frame)']);
        if strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'.tif') || strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'.avi') || strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'none')
            set(h_init(1).edit_fps,'Enable','on');
            set(h_init(1).edit_conversion,'Enable','on');
        else
            set(h_init(1).edit_fps,'Enable','off');
            set(h_init(1).edit_conversion,'Enable','of');
        end
        
        %save new settings
        
        %update text (x/N)
        set(h_init(1).text_whichvid,'String',[num2str(sarco_init_user_counter),'/',num2str(sarco_init_user_Nfiles)]);
    end
    
    if sarco_init_user_counter==sarco_init_user_Nfiles;
        %grey out back button
        set(h_init(1).button_forwards,'Enable','off');
        set(h_init(1).button_backwards,'Enable','on');
        %enable ok button
        set(h_init(1).button_ok,'Enable','on');
    else
        set(h_init(1).button_forwards,'Enable','on');
        set(h_init(1).button_backwards,'Enable','on');
    end
    
    %grey out listbox
    set(h_init(1).listbox_display,'Enable','off');
    
    %store everything for shared use
    setappdata(0,'sarco_init_user_filenamestack',sarco_init_user_filenamestack)
    setappdata(0,'sarco_init_user_pathnamestack',sarco_init_user_pathnamestack)
    setappdata(0,'sarco_init_user_vidext',sarco_init_user_vidext)
    setappdata(0,'sarco_init_user_counter',sarco_init_user_counter)
    setappdata(0,'sarco_init_user_Nfiles',sarco_init_user_Nfiles)
    setappdata(0,'sarco_init_user_cellname',sarco_init_user_cellname)
    setappdata(0,'sarco_init_user_Nframes',sarco_init_user_Nframes)
    setappdata(0,'sarco_init_user_conversion',sarco_init_user_conversion)
    setappdata(0,'sarco_init_user_framerate',sarco_init_user_framerate)
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

function init_push_backwards(hObject, eventdata, h_init)
%disable figure during calculation
enableDisableFig(h_init(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_init(1).fig,1));


try
    
    %load what shared para we need
    sarco_init_user_counter=getappdata(0,'sarco_init_user_counter');
    sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
    sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');
    sarco_init_user_framerate=getappdata(0,'sarco_init_user_framerate');
    sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');
    sarco_init_user_cellname=getappdata(0,'sarco_init_user_cellname');
    sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
    sarco_init_user_pathnamestack=getappdata(0,'sarco_init_user_pathnamestack');
    sarco_init_user_vidext=getappdata(0,'sarco_init_user_vidext');
    %sarco_init_user_mask=getappdata(0,'sarco_init_user_mask');
    sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
    
    %look at vid counter
    if sarco_init_user_counter>1;
        %save settings
        sarco_init_user_framerate{sarco_init_user_counter}=str2double(get(h_init(1).edit_fps,'String'));
        sarco_init_user_conversion{sarco_init_user_counter}=str2double(get(h_init(1).edit_conversion,'String'));
        sarco_init_user_cellname{sarco_init_user_counter}=get(h_init(1).edit_cellname,'String');
        
        %go to video before
        sarco_init_user_counter=sarco_init_user_counter-1;
        
        %select item in listbox
        set(h_init(1).listbox_display,'Value',sarco_init_user_counter);
        
        %display 1st frame of new video
        axes(h_init(1).axes_curr);
        imshow(sarco_init_user_preview_frame1{sarco_init_user_counter});
        
        %display new settings
        %display new settings
        set(h_init(1).edit_fps,'String',num2str(sarco_init_user_framerate{sarco_init_user_counter}));
        set(h_init(1).edit_conversion,'String',num2str(sarco_init_user_conversion{sarco_init_user_counter}));
        set(h_init(1).edit_nframes,'String',num2str(sarco_init_user_Nframes{sarco_init_user_counter}));
        set(h_init(1).edit_nframes,'Enable','off');
        set(h_init(1).edit_cellname,'String',sarco_init_user_cellname{sarco_init_user_counter});
        set(h_init(1).text_whichvidname,'String',[sarco_init_user_filenamestack{1,sarco_init_user_counter},' (showing 1st frame)']);
        if strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'.tif') || strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'.avi') || strcmp(sarco_init_user_vidext{1,sarco_init_user_counter},'none')
            set(h_init(1).edit_fps,'Enable','on');
            set(h_init(1).edit_conversion,'Enable','on');
        else
            set(h_init(1).edit_fps,'Enable','off');
            set(h_init(1).edit_conversion,'Enable','of');
        end
        
        %update text (x/N)
        set(h_init(1).text_whichvid,'String',[num2str(sarco_init_user_counter),'/',num2str(sarco_init_user_Nfiles)]);
    end
    
    if sarco_init_user_counter==1;
        set(h_init(1).button_backwards,'Enable','off');
        set(h_init(1).button_forwards,'Enable','on');
    else
        set(h_init(1).button_backwards,'Enable','on');
        set(h_init(1).button_forwards,'Enable','on');
    end
    
    %grey out listbox
    set(h_init(1).listbox_display,'Enable','off');
    
    %store everything for shared use
    setappdata(0,'sarco_init_user_filenamestack',sarco_init_user_filenamestack)
    setappdata(0,'sarco_init_user_pathnamestack',sarco_init_user_pathnamestack)
    setappdata(0,'sarco_init_user_vidext',sarco_init_user_vidext)
    setappdata(0,'sarco_init_user_counter',sarco_init_user_counter)
    setappdata(0,'sarco_init_user_Nfiles',sarco_init_user_Nfiles)
    setappdata(0,'sarco_init_user_cellname',sarco_init_user_cellname)
    setappdata(0,'sarco_init_user_Nframes',sarco_init_user_Nframes)
    setappdata(0,'sarco_init_user_conversion',sarco_init_user_conversion)
    setappdata(0,'sarco_init_user_framerate',sarco_init_user_framerate)
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

% function init_push_draw(hObject, eventdata, h_init)
% try
% %load shared
% sarco_init_user_counter=getappdata(0,'sarco_init_user_counter');
% sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
% sarco_init_user_mask=getappdata(0,'sarco_init_user_mask');
% 
% %draw
% hf=figure;
% imshow(sarco_init_user_preview_frame1{sarco_init_user_counter});
% hFH=impoly;
% binaryImage = hFH.createMask();
% close(hf);
% 
% %save as new mask
% sarco_init_user_mask{sarco_init_user_counter}=binaryImage;
% 
% %display preview w. mask
% cla(h_init(1).axes_curr)
% axes(h_init(1).axes_curr)
% imshow(sarco_init_user_preview_frame1{sarco_init_user_counter}.*sarco_init_user_mask{sarco_init_user_counter});
% 
% %save
% setappdata(0,'sarco_init_user_mask',sarco_init_user_mask)
% catch errorObj
%     % If there is a problem, we display the error message
%     errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
% 
% end
% 
% function init_push_load(hObject, eventdata, h_init)
% try
% %load shared
% sarco_init_user_counter=getappdata(0,'sarco_init_user_counter');
% sarco_init_user_preview_frame1=getappdata(0,'sarco_init_user_preview_frame1');
% sarco_init_user_mask=getappdata(0,'sarco_init_user_mask');
% 
% %
% [FileName,PathName] = uigetfile('*.mat','Select mat file');
% %really a file or did user press cancel?
%     if isequal(FileName,0)
%         return;
%     end
% var=load(fullfile(PathName,FileName));
% 
% %save as new mask
% sarco_init_user_mask{sarco_init_user_counter}=var.mask;
% 
% %display preview w. mask
% cla(h_init(1).axes_curr)
% axes(h_init(1).axes_curr)
% imshow(sarco_init_user_preview_frame1{sarco_init_user_counter}.*sarco_init_user_mask{sarco_init_user_counter});
% 
% %save
% setappdata(0,'sarco_init_user_mask',sarco_init_user_mask)
% 
% catch errorObj
%     % If there is a problem, we display the error message
%     errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
% end

function init_push_ok(hObject, eventdata, h_init,h_main)
%disable figure during calculation
enableDisableFig(h_init(1).fig,0);

%turn back on in the end
%clean1=onCleanup(@()enableDisableFig(h_init(1).fig,1));

    
%%error catching loop
try 

    %load what shared para we need
sarco_init_user_Nfiles=getappdata(0,'sarco_init_user_Nfiles');
sarco_init_user_Nframes=getappdata(0,'sarco_init_user_Nframes');
sarco_init_user_cellname=getappdata(0,'sarco_init_user_cellname');
sarco_init_user_filenamestack=getappdata(0,'sarco_init_user_filenamestack');
sarco_init_user_pathnamestack=getappdata(0,'sarco_init_user_pathnamestack');
sarco_init_user_framerate=getappdata(0,'sarco_init_user_framerate');
sarco_init_user_conversion=getappdata(0,'sarco_init_user_conversion');
sarco_init_user_counter=getappdata(0,'sarco_init_user_counter');
%sarco_init_user_mask=getappdata(0,'sarco_init_user_mask');

%save settings for current frame
sarco_init_user_framerate{sarco_init_user_counter}=str2double(get(h_init(1).edit_fps,'String'));
sarco_init_user_conversion{sarco_init_user_counter}=str2double(get(h_init(1).edit_conversion,'String'));
sarco_init_user_cellname{sarco_init_user_counter}=get(h_init(1).edit_cellname,'String');

%first check: has user entered all the necesaary info: fps,
%conversion
for ivid=1:sarco_init_user_Nfiles
    if ~isempty(find(isnan([sarco_init_user_framerate{:}]))) || ~isempty(find(isnan([sarco_init_user_conversion{:}])))
        errordlg('Please enter all the necessary values: frames per second and Conversion.','Error');
        enableDisableFig(h_init(1).fig,1)
        return;
    end
end


%save micro data & save mask
for ivid=1:sarco_init_user_Nfiles
    sb=statusbar(h_init(1).fig,['Saving... ',num2str(floor(100*(ivid-1)/sarco_init_user_Nfiles)), '%% done']);
    sb.getComponent(0).setForeground(java.awt.Color.red);
    %create folder ewith same name as vid. & mask folder
    if ~isequal(exist([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Results'], 'dir'),7)
        mkdir([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Results'])
    end
    
    %if ~isequal(exist([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Mask'], 'dir'),7)
    %    mkdir([sarco_init_user_pathnamestack{1,ivid},sarco_init_user_filenamestack{1,ivid},'/Mask'])
    %end
    
    
    %copy excel file to new result file
    newfile=[sarco_init_user_pathnamestack{1,ivid},'/',sarco_init_user_filenamestack{1,ivid},'/Results/',sarco_init_user_filenamestack{1,ivid},'.xls'];
    copyfile('Sample_DO_NOT_EDIT.xls',newfile);
    
    %write microscope data to excel file
    A = {sarco_init_user_framerate{ivid},sarco_init_user_conversion{ivid},sarco_init_user_Nframes{ivid},sarco_init_user_cellname{ivid}};
    sheet = 'General';
    xlRange = 'A3';
    xlwrite(newfile,A,sheet,xlRange)
    
    %save mask
    %mask=sarco_init_user_mask{ivid};
    %save([sarco_init_user_pathnamestack{1,ivid},'/',sarco_init_user_filenamestack{1,ivid},'/Mask/mask_',sarco_init_user_cellname{ivid},'.mat'],'mask','-v7.3')
end
%update statusbar
sb=statusbar(h_init(1).fig,'Saving - Done !');
sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));

catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');

end

setappdata(0,'sarco_init_user_cellname',sarco_init_user_cellname)
setappdata(0,'sarco_init_user_conversion',sarco_init_user_conversion)
setappdata(0,'sarco_init_user_framerate',sarco_init_user_framerate)

%enable
enableDisableFig(h_init(1).fig,1);

%close window
close(h_init(1).fig);

%change main windows 2. button status
set(h_main(1).button_conc,'Enable','on');
set(h_main(1).button_init,'ForegroundColor',[0 .5 0]);

%move main window to center
movegui(h_main(1).fig,'center')
