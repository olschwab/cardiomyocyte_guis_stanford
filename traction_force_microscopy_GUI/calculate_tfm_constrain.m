function [ theta,xs_frame,ys_frame,u1,v1,u1_0,v1_0,V,absd,Fx,Fy,F,Trx,Try,v] = calculate_tfm_constrain(filename,relax,contr,frame,maskpiv,cellmask,E,nu,conversion)
%calculates tfm between 2 frames
A=(1+nu)/(pi*E);

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
%frame
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_x_',num2str(frame),'.mat'],'x');
xs_frame=s.x;
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_y_',num2str(frame),'.mat'],'y');
ys_frame=s.y;
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_u_',num2str(frame),'.mat'],'fu');
us_frame=s.fu;
s=load(['vars_DO_NOT_DELETE/',filename,'/piv_v_',num2str(frame),'.mat'],'fv');
vs_frame=s.fv;

%transform mask, st 0s become Nans
mask=double(maskpiv);
binaryImage=double(cellmask);
mask(mask==0)=NaN;

%get angle
deltaU=mask.*(us_contr-us_relax);
deltaV=mask.*(vs_contr-vs_relax);
u1_0=(us_contr-us_relax)-nanmean(deltaU(:)).*ones(size(us_relax,1),size(us_relax,2));
v1_0=(vs_contr-vs_relax)-nanmean(deltaV(:)).*ones(size(vs_relax,1),size(vs_relax,2));

%angle
Ang=tan((v1_0)./(u1_0+eps));
Ang_vec = subsref(Ang.', substruct('()', {':'})).';
Ang_vec(isnan(Ang_vec))=[];
theta=mean(Ang_vec)*180/pi;

%between current frame and relaxed:
deltaU=mask.*(us_frame-us_relax);
deltaV=mask.*(vs_frame-vs_relax);
u1_0=(us_frame-us_relax)-nanmean(deltaU(:)).*ones(size(us_relax,1),size(us_relax,2));
v1_0=(vs_frame-vs_relax)-nanmean(deltaV(:)).*ones(size(vs_relax,1),size(vs_relax,2));
x1=xs_frame*conversion*1e-6;
y1=ys_frame*conversion*1e-6;

%transform to cell coordinate system
%R=[cosd(theta),-sind(theta);sind(theta),cosd(theta)];
%u1=(u1_0*R(1,1)+v1_0*R(1,2))*conversion*1e-6;
%v1=(u1_0*R(2,1)+v1_0*R(2,2))*conversion*1e-6;
u1=u1_0*conversion*1e-6;
v1=v1_0*conversion*1e-6;
u1_0=u1;
v1_0=v1;

iter=1;
oldtracmax=1e6;
diff=1;
while iter<50 && diff>1e-6
%step 1: normal unconstrained    
%fourier transform
u=(fft2(u1_0));
v=(fft2(v1_0));

%initialize traction vectors w. nans
Tx=zeros(size(u));
Ty=zeros(size(v));

%image size
Nx=size(u,1);
Ny=size(v,2);

%distance between grid points
D=(x1(1,2)-x1(1,1)); %in m

%wavenumbers: theory from fourier transform; matlab starts at f=0:N/2 then
%from -N/2 to -1;
dkx=1/(Nx*D);
kx=[0:fix(Nx/2),-fix(Nx/2):-1]*dkx*2*pi;
dky=1/(Ny*D);
ky=[0:fix(Ny/2),-fix(Ny/2):-1]*dky*2*pi;


ii=0;
%loop over wavenumbers
for i=kx(1:end-1)
    ii=ii+1;
    jj=0;
    for j=ky(1:end-1)
        jj=jj+1;
        
        k=sqrt(i^2+j^2);
        un=u(ii,jj);
        vn=v(ii,jj);
        uk=[un;vn];
        
        %at f=0 the tractions must be 0
        if (i==0) && (j==0)
            Tx(ii,jj)=0;
            Ty(ii,jj)=0;
            
        else
            %Qingzong: at the nyquist frequency, set the off-diagonal element to zero, see Butler et al. Am J Physil Cell Physiol 2001
            if (ii==Nx/2)||(jj==Ny/2)
                K=A*2*pi/(k^3)*[(1-nu)*k^2+nu*j^2,0; 0,(1-nu)*k^2+nu*i^2];
            else
                K=A*2*pi/(k^3)*[(1-nu)*k^2+nu*j^2,-nu*i*j; -nu*i*j,(1-nu)*k^2+nu*i^2];
            end
                       
            %2D identity
            H=eye(2);
            
            %now finally, the traction force calculation
            lambda=0; %no regul.
            Gn=K'*K+lambda^2*H;
            T=Gn\(K'*uk(end:-1:1));
            Tx(ii,jj)=T(2);
            Ty(ii,jj)=T(1);
        end
    end
end

%transform back into real space
Trx=real((ifft2(Tx)));
Try=real((ifft2(Ty)));

%step 2: define a new traction field by setting the tractions outside the
%cell boundary to zero.
Trx_new=Trx.*binaryImage;
Try_new=Try.*binaryImage;

%norm of the tractions
v = sqrt( Trx_new.^2 + Try_new.^2 );

%step 3: calculate displacement field induced by this field: forward FT;
Trx_new_fft=(fft2(Trx_new));
Try_new_fft=(fft2(Try_new));

u_new=zeros(size(Trx_new_fft));
v_new=zeros(size(Try_new_fft));

%wavevector: N points
Nx=size(Trx_new_fft,1);
Ny=size(Try_new_fft,2);
D=(x1(1,2)-x1(1,1)); %in m

%wavenumber
dkx=1/(Nx*D);
kx=[0:fix(Nx/2),-fix(Nx/2):-1]*dkx*2*pi;
dky=1/(Ny*D);
ky=[0:fix(Ny/2),-fix(Ny/2):-1]*dky*2*pi;

ii=0;
for i=kx(1:end-1)
    ii=ii+1;
    jj=0;
    for j=ky(1:end-1)
        jj=jj+1;
        
        k=sqrt(i^2+j^2);
        
        Trxn=Trx_new_fft(ii,jj);
        Tryn=Try_new_fft(ii,jj);
        Trk=[Trxn;Tryn];
        
        if (i==0) && (j==0)
            u_new(ii,jj)=0;
            u_new(ii,jj)=0;
            
        else
            %Qingzong: at the nyquist frequency, set the off-diagonal element to zero, see Butler et al. Am J Physil Cell Physiol 2001
            if (ii==Nx/2)||(jj==Ny/2)
                K=A*2*pi/(k^3)*[(1-nu)*k^2+nu*j^2,0; 0,(1-nu)*k^2+nu*i^2];
            else
                K=A*2*pi/(k^3)*[(1-nu)*k^2+nu*j^2,-nu*i*j; -nu*i*j,(1-nu)*k^2+nu*i^2];
            end
            H=eye(2);
            
            lambda=0;%no regul
            
            %
            Gn=K'*K+lambda^2*H;
            uk=K'\(Gn*Trk(end:-1:1));
            u_new(ii,jj)=uk(2);
            v_new(ii,jj)=uk(1);
        end
    end
end

%
u1_0=real((ifft2(u_new)));
v1_0=real((ifft2(v_new)));

%step 4: replace dis inside cell by experimental results
u1_0=u1_0.*double(~binaryImage)+u1.*binaryImage;
v1_0=v1_0.*double(~binaryImage)+v1.*binaryImage;

%increase counter
iter=iter+1;

diff=abs(oldtracmax-max(v(:)));
oldtracmax=max(v(:));
end

%Interpolate traction data for every pixel
try
[Xqu,Yqu]=meshgrid(xs_frame(1):xs_frame(end),ys_frame(1):ys_frame(end));
V = interp2(xs_frame,ys_frame,v,Xqu,Yqu,'linear');
catch
    V=v;
end

%save displacmeent in matrix
absd=sqrt(u1.^2+v1.^2);

%forces calculation: every traction is wrt the area of 1px*1px
Apx=(conversion*1e-6)^2*(xs_frame(1,2)-xs_frame(1,1))*(ys_frame(2,1)-ys_frame(1,1));
Fx=Apx*Trx_new;
Fy=Apx*Try_new;
F=Apx*v;

end

