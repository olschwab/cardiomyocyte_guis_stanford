%lifeact_main.m ; part of the Lifeact GUI: execute lifeact_main.m
%version 2.0.1
%written by O. Schwab (oschwab@stanford.edu)
%last change: 01/04/15

function lifeact_main
%main function for the main window of lifeact analysis

%clear all
clc
clear all;
close all;

%add paths of external funcs
addpath('External');
addpath('External/bfmatlab');
addpath('External/statusbar');
addpath('External/20130227_xlwrite');
addpath('External/ncorr_v1_2');
addpath('External/ojwoodford-export_fig-5735e6d')
addpath('External/freezeColors');
addpath('External/peters');
javaaddpath('External/20130227_xlwrite/poi_library/poi-3.8-20120326.jar');
javaaddpath('External/20130227_xlwrite/poi_library/poi-ooxml-3.8-20120326.jar');
javaaddpath('External/20130227_xlwrite/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('External/20130227_xlwrite/poi_library/xmlbeans-2.3.0.jar');
javaaddpath('External/20130227_xlwrite/poi_library/dom4j-1.6.1.jar');
javaaddpath('External/20130227_xlwrite/poi_library/stax-api-1.0.1.jar');

%supress all warning messages 
warning('off','all');


%figure size
figuresize=[250,225];
%get screen size
screensize = get(0,'ScreenSize');
%position figure on center of screen
xpos = ceil((screensize(3)-figuresize(2))/2);
ypos = ceil((screensize(4)-figuresize(1))/2);

%create figure
h_main(1).fig=figure(...
    'position',[xpos, ypos, figuresize(2), figuresize(1)],...
    'units','pixels',...
    'renderer','OpenGL',...
    'MenuBar','none',...
    'PaperPositionMode','auto',...
    'Name','Lifeact Main',...
    'NumberTitle','off',...
    'Resize','off',...
    'Color',[.94,.94,.94]);

%create buttons:
%button size
buttonsize=[30,200];
%vertical space between buttons: 5 buttons along figuresize -> 6 spaces
verticalspace=(figuresize(1)-5*buttonsize(1))/6;
%button 1 - initalization
h_main(1).button_init = uicontrol('Parent',h_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,5*verticalspace+4*buttonsize(1),buttonsize(2),buttonsize(1)],'string','Initialization');
%button 2 - concentration; disabled at start
h_main(1).button_conc = uicontrol('Parent',h_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,4*verticalspace+3*buttonsize(1),buttonsize(2),buttonsize(1)],'string','Outline & Concentration','Enable','off');
%button 3 - displacement; disabled at start
h_main(1).button_piv = uicontrol('Parent',h_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,3*verticalspace+2*buttonsize(1),buttonsize(2),buttonsize(1)],'string','Displacements','Enable','off');
%button 4 - sarcomere analysis; disabled at start
h_main(1).button_sarco = uicontrol('Parent',h_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,2*verticalspace+buttonsize(1),buttonsize(2),buttonsize(1)],'string','Sarcomere Analysis','Enable','off');
%button 5 - parameter extraction; disabled at start
h_main(1).button_para = uicontrol('Parent',h_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,verticalspace,buttonsize(2),buttonsize(1)],'string','Results','Enable','off');

%assign callbacks to buttons
%button 1
set(h_main(1).button_init,'callback',{@main_push_init,h_main})
%button 2
set(h_main(1).button_conc,'callback',{@main_push_conc,h_main})
%button 3
set(h_main(1).button_piv,'callback',{@main_push_piv,h_main})
%button 4
set(h_main(1).button_sarco,'callback',{@main_push_sarco,h_main})
%button 5
set(h_main(1).button_para,'callback',{@main_push_para,h_main})

function main_push_init(hObject, eventdata, h_main)
%launch the initialization window
lifeact_init(h_main);

function main_push_conc(hObject, eventdata, h_main)
%launch the outline&concentration window
lifeact_conc(h_main);

function main_push_piv(hObject, eventdata, h_main)
%launch the displacement window
lifeact_piv(h_main);

function main_push_sarco(hObject, eventdata, h_main)
%launch the sarcomere analysis window
lifeact_sarco(h_main);

function main_push_para(hObject, eventdata, h_main)
%launch the results window
lifeact_para(h_main);