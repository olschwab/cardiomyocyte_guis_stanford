function [ displacement,alphamean,alphastd,displacement_roi,alphamean_roi,alphastd_roi,alpha]=calc_blobb3( filename,relax,contr,frame,mask,binary0,roitag,roinumber,roi_i)
%calculate displacements and angles for bf: outline + rois !

%displ. needed: relax, contr, frame
%relax
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_u_',num2str(relax),'.mat'],'fu');
us_relax=s.fu;
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_v_',num2str(relax),'.mat'],'fv');
vs_relax=s.fv;
%contr
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_u_',num2str(contr),'.mat'],'fu');
us_contr=s.fu;
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_v_',num2str(contr),'.mat'],'fv');
vs_contr=s.fv;
%relax
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_x_',num2str(frame),'.mat'],'x');
xs_frame=s.x;
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_y_',num2str(frame),'.mat'],'y');
ys_frame=s.y;
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_u_',num2str(frame),'.mat'],'fu');
us_frame=s.fu;
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_v_',num2str(frame),'.mat'],'fv');
vs_frame=s.fv;

%transform mask, st 0s become Nans
mask=double(mask);
mask(mask==0)=NaN;

%get angle
deltaU=mask.*(us_contr-us_relax);
deltaV=mask.*(vs_contr-vs_relax);
u1_0=(us_contr-us_relax)-nanmean(deltaU(:)).*ones(size(us_relax,1),size(us_relax,2));
v1_0=(vs_contr-vs_relax)-nanmean(deltaV(:)).*ones(size(vs_relax,1),size(vs_relax,2));

%angle
Ang=tan((v1_0)./(u1_0+eps));
Ang_vec = subsref(Ang.', substruct('()', {':'})).';
theta=mean(Ang_vec)*180/pi;

%between current frame and relaxed:
deltaU=mask.*(us_frame-us_relax);
deltaV=mask.*(vs_frame-vs_relax);
u1_0=(us_frame-us_relax)-nanmean(deltaU(:)).*ones(size(us_relax,1),size(us_relax,2));
v1_0=(vs_frame-vs_relax)-nanmean(deltaV(:)).*ones(size(vs_relax,1),size(vs_relax,2));
x1=xs_frame;
y1=ys_frame;

%transform to cell coordinate system
R=[cosd(theta),-sind(theta);sind(theta),cosd(theta)];
u1=u1_0*R(1,1)+v1_0*R(1,2);
v1=u1_0*R(2,1)+v1_0*R(2,2);

%interpolate for every pixel
xi=1:size(binary0,2);
yi=1:size(binary0,1);
[Xqu,Yqu]=meshgrid(xi,yi);
U1 = interp2(x1,y1,u1,Xqu,Yqu,'linear',0);
V1 = interp2(x1,y1,v1,Xqu,Yqu,'linear',0);

%transofrm displacements into local CS
alpha=pi+theta;
R=[cosd(alpha),-sind(alpha);sind(alpha),cosd(alpha)];
un_prime=U1*R(1,1)+V1*R(1,2);
vn_prime=U1*R(2,1)+V1*R(2,2);
dis_pts=sqrt(un_prime.^2+vn_prime.^2);

%save
save(['vars_DO_NOT_DELETE/',filename,'/dis_pts',num2str(frame),'.mat'],'dis_pts','-v7.3')

%%now mean, aver, angle for outline and roi
%outline
%consider only the displacements inside blobb at stage B
un=U1.*binary0;
vn=V1.*binary0;
un_prime2=un*R(1,1)+vn*R(1,2);
vn_prime2=un*R(2,1)+vn*R(2,2);

%average and std angle of displacmeents
un_prime_vec = subsref(un_prime2.', substruct('()', {':'})).';
vn_prime_vec = subsref(vn_prime2.', substruct('()', {':'})).';
un_prime_vec(isnan(un_prime_vec))=[];
vn_prime_vec(isnan(vn_prime_vec))=[];


binary3=double(binary0);
binary3(binary3==0)=NaN;
un3=U1.*binary3;
vn3=V1.*binary3;
alpha=atand(vn3./un3);

%makenvectors and delete NaN (i.e. outside cell)
un3_vec = subsref(un3.', substruct('()', {':'})).';
vn3_vec = subsref(vn3.', substruct('()', {':'})).';
un3_vec(isnan(un3_vec))=[];
vn3_vec(isnan(vn3_vec))=[];
displacement=mean(sqrt(un3_vec.^2+vn3_vec.^2));


alphamean=mean(atand(vn3_vec./(un3_vec+eps)));
alphastd=std(atand(vn3_vec./(un3_vec+eps)));
if frame==relax
alphamean=NaN;
alphastd=NaN;
end

%rois:
alphamean_roi=NaN*ones(1,roinumber);
alphastd_roi=NaN*ones(1,roinumber);
displacement_roi=NaN*ones(1,roinumber);

if roitag
    for roi=1:roinumber
        bin_roi_curr=roi_i(roi);
        bin_roi_curr=double(bin_roi_curr{1});
        
        un=U1.*bin_roi_curr;
        vn=V1.*bin_roi_curr;
        un_prime2=un*R(1,1)+vn*R(1,2);
        vn_prime2=un*R(2,1)+vn*R(2,2);
        
        %average and std angle of displacmeents
        un_prime_vec = subsref(un_prime2.', substruct('()', {':'})).';
        vn_prime_vec = subsref(vn_prime2.', substruct('()', {':'})).';
        un_prime_vec(isnan(un_prime_vec))=[];
        vn_prime_vec(isnan(vn_prime_vec))=[];
        alphamean_roi(roi)=mean(atand(vn_prime_vec./(un_prime_vec+eps)));
        alphastd_roi(roi)=std(atand(vn_prime_vec./(un_prime_vec+eps)));
        if frame==relax
            alphamean_roi(roi)=NaN;
            alphastd_roi(roi)=NaN;
        end
        
        binary3=double(bin_roi_curr);
        binary3(binary3==0)=NaN;
        un3=U1.*binary3;
        vn3=V1.*binary3;
        
        %makenvectors and delete NaN (i.e. outside cell)
        un3_vec = subsref(un3.', substruct('()', {':'})).';
        vn3_vec = subsref(vn3.', substruct('()', {':'})).';
        un3_vec(isnan(un3_vec))=[];
        vn3_vec(isnan(vn3_vec))=[];
        displacement_roi(roi)=mean(sqrt(un3_vec.^2+vn3_vec.^2));
        
        %test
        %disp(num2str(alphastd_roi(roi)))
    end    
    
end

end

