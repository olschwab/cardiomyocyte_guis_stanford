%beads_main.m ; part of the Beads GUI: execute beads_main.m
%version 2.0
%written by O. Schwab (oschwab@stanford.edu)
%last change: 10/28/14

function beads_main
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
addpath('External/regu/regu');
javaaddpath('External/20130227_xlwrite/poi_library/poi-3.8-20120326.jar');
javaaddpath('External/20130227_xlwrite/poi_library/poi-ooxml-3.8-20120326.jar');
javaaddpath('External/20130227_xlwrite/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('External/20130227_xlwrite/poi_library/xmlbeans-2.3.0.jar');
javaaddpath('External/20130227_xlwrite/poi_library/dom4j-1.6.1.jar');
javaaddpath('External/20130227_xlwrite/poi_library/stax-api-1.0.1.jar');


%figure size
figuresize=[200,225];
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
    'Name','Beads Main',...
    'NumberTitle','off',...
    'Resize','off',...
    'Color',[.94,.94,.94]);

%create buttons:
%button size
buttonsize=[30,200];
%vertical space between buttons: 4 buttons along figuresize -> 5 spaces
verticalspace=(figuresize(1)-4*buttonsize(1))/5;
%button 1 - initalization
h_main(1).button_init = uicontrol('Parent',h_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,4*verticalspace+3*buttonsize(1),buttonsize(2),buttonsize(1)],'string','Initialization');
%button 2 - displacement; disabled at start
h_main(1).button_piv = uicontrol('Parent',h_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,3*verticalspace+2*buttonsize(1),buttonsize(2),buttonsize(1)],'string','Displacements','Enable','off');
%button 3 - sarcomere analysis; disabled at start
h_main(1).button_tfm = uicontrol('Parent',h_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,2*verticalspace+buttonsize(1),buttonsize(2),buttonsize(1)],'string','Traction Forces','Enable','off');
%button 4 - parameter extraction; disabled at start
h_main(1).button_para = uicontrol('Parent',h_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,verticalspace,buttonsize(2),buttonsize(1)],'string','Results','Enable','off');

%assign callbacks to buttons
%button 1
set(h_main(1).button_init,'callback',{@main_push_init,h_main})
%button 2
set(h_main(1).button_piv,'callback',{@main_push_piv,h_main})
%button 4
set(h_main(1).button_tfm,'callback',{@main_push_tfm,h_main})
%button 5
set(h_main(1).button_para,'callback',{@main_push_para,h_main})

function main_push_init(hObject, eventdata, h_main)
%launch the initialization window
beads_init(h_main);

function main_push_piv(hObject, eventdata, h_main)
%launch the displacement window
beads_piv(h_main);

function main_push_tfm(hObject, eventdata, h_main)
%launch the sarcomere analysis window
beads_tfm(h_main);

function main_push_para(hObject, eventdata, h_main)
%launch the results window
beads_para(h_main);