function [ mean_s,std_s,std_t ] = sarco_dist( path_vid,file_vid,frame,BW,orientim,minS,maxS,conversion,~,~ )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%go +-20% from minS maxS
maxS=1.2*maxS;
minS=.8*minS;

%load image
s=load(['vars_DO_NOT_DELETE/',file_vid,'/image',num2str(frame),'.mat'],'imagei');
image=s.imagei;

%save fugure
sh=figure('visible','off');
imshow(normalise(image))
colormap('gray')
freezeColors

%rows,cols
rows=size(BW,1);
cols=size(BW,2);

%save sarco vector and orient.
s=[];
t=[];
vecc=0;

for i=1:rows
    for j=1:cols
        if BW(i,j)==1
            startx=i;
            starty=j;
            
            %while conditions: not at boundary, not 1,
            ii=0;
            jj=0; %start one off to right
            pnt=0;
            angsum=0;
            count=0;
            while sqrt(ii^2+jj^2)*conversion<maxS && pnt==0 && count<100
                angle=orientim(startx+ii,starty+jj);
                angsum=angsum-angle; %- bec. sign is wrong from orientations
                
                %determine next pixel
                if angsum<22.5*pi/180 && angsum >-22.5*pi/180
                    %case 1
                    jj=jj+1;
                elseif angsum<67.5*pi/180 && angsum >22.5*pi/180
                    %case 2
                    ii=ii-1;
                    jj=jj+1;
                    angsum=0;
                elseif angsum<-22.5*pi/180 && angsum >-67.5*pi/180
                    %case 3
                    ii=ii+1;
                    jj=jj+1;
                    angsum=0;
                elseif angsum<90*pi/180 && angsum >67.5*pi/180
                    %case 4
                    ii=ii-1;
                    angsum=0;
                elseif angsum<-67.5*pi/180 && angsum >-90*pi/180
                    %case 5
                    ii=ii+1;
                    angsum=0;
                end
                
                %new pixel
                if startx+ii>0 && starty+jj>0 && startx+ii<=rows && starty+jj<=cols
                    pnt=BW(startx+ii,starty+jj);
                else
                    pnt=2;
                end
                
                count=count+1;
            end
            
            %euclidian distance between start and end
            d=sqrt(ii^2+jj^2)*conversion;
            theta=atand(ii/jj);
            
            if d>=minS && d<=maxS && pnt==1 && count<100
                vecc=vecc+1;
                
                dmax=maxS;
                dmin=minS;
                dn=(d-dmin)/(dmax-dmin); %to [0,1]
                
                %rotate to orig. form
                %R_=[cos(angle0*pi/180),-sin(angle0*pi/180);sin(angle0*pi/180),cos(angle0*pi/180)];
                %rot around midpoint !
                %start_v=R_*([startx;starty]-.5*[size(I,1);size(I,2)])+.5*[size(I,1);size(I,2)];
                %end_v=R_*([startx+ii;starty+jj]-.5*[size(I,1);size(I,2)])+.5*[size(I,1);size(I,2)];
                %add start coord.
                %start_v=[Ocoord(1,1);Ocoord(2,1)]+start_v;
                %end_v=[Ocoord(1,1);Ocoord(2,1)]+end_v;
                
                %line([start_v(2) end_v(2)],[start_v(1) end_v(1)],'Color',thisLinesColor);
                
                %no rot.
                start_v=[startx;starty];
                end_v=[startx+ii;starty+jj];
                
                %save in vecs
                start1vec(vecc)=start_v(1);
                start2vec(vecc)=start_v(2);
                end1vec(vecc)=end_v(1);
                end2vec(vecc)=end_v(2);
                colorvec(vecc)=dn;
                
                s=[s d];
                t=[t theta];
            end
        end
    end
end

%save fig axes
figure(sh);
set(sh,'visible','off')
cc=colormap('hot');
caxis([minS maxS]);
n=size(cc,1);
for i=1:length(colorvec)
thisLinesColor = cc(ceil(colorvec(i)*n),:);
line([start2vec(i) end2vec(i)],[start1vec(i) end1vec(i)],'Color',thisLinesColor);
end
colorbar;
freezeColors;
                
%export sarco heatmap
export_fig([path_vid,file_vid,'/Plots/Sarcomere Heatmaps/heatmap',int2str(frame)],'-png','-m2',sh);
close(sh);

%mean and median sarco length
mean_s=mean(s);
std_s=std(s);

%std sarco orientations
std_t=std(t);

end

