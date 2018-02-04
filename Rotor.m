SETVALUE();
SETLMI();
LMI();

%S0 = 0.0005; %Зазор
%T1 = [0 8];
%l1 = 0.3;
%l2 = 0.2;
%alpha = -0.00049;
%beta = 0.00039;
%x = 0.0001;
%y = -0.00025;
%ts = 0;
%tf = 10;
%x0 = [1;1;1;1;0;0;0;0];
%ksi0 = [1;1;1;1;0;0;0;0];
%ksi0 = [-0.00049;0.00039;0.0001;-0.00025;0;0;0;0];
%ksi0 = [alpha;beta;x;y;0;0;0;0];
%[t,x] = ode45(@(t,x)valrot(t, x, A, B, W),ts,tf,x0);
%[t,x] = ode45(@(t,x)valrot(t, x, A, B, W),T,x0);
%[t,ksi] = ode45(@(t,ksi)valrot(t, ksi, A, B, W),T1,ksi0);
%(@(t,x) valrot(t, x, A, B, W))
%[t,x] = ode45('valrot',ts,tf,x0);
%plot(t,ksi);
%grid, hold on
%gtext('alpha'), gtext('beta'), gtext('x'), gtext('y'),
%gtext('alpha*'), gtext('beta*'),gtext('x*'), gtext('y*');

%plot(plot::Inequality((x+beta*s1)^2 + (y-alpha*s1)^2 < 1,
                  %    x = -0.5..0.5, y = -0.5..0.5));

%for alpha = -0.5:0.01:0.5
 %   for beta = -0.5:0.01:0.5
%ineq = ((x+beta*s1).^2 + (y-alpha*s1).^2 <= 1) & ((x-beta*s2).^2 + (y+alpha*s2).^2 <= 1);    % some inequality
%f = double(ineq);
%surf(x,y,f);
 %contour(x,y,f);
%view(0,90)            % rotate surface plot to top view
 %   end;
%end;


%========================================================================%
%%%%%%%%%%%%%%%%%%%    Для вычисления вектроа ksi    %%%%%%%%%%%%%%%%%%%%%
T1 = [0 8];
alpha = -0.00049;
beta = 0.00039;
x = 0.0001;
y = -0.00025;
ksi0 = [alpha;beta;x;y;0;0;0;0];
[t,ksi] = ode45(@(t,ksi)valrot(t, ksi, A, B, W),T1,ksi0);
%plot(t,ksi);
%xlabel('Time') 
%ylabel('Offset') 
%legend('alpha','beta','x','y','alpha->','beta->','x->','y->',4);
%axis ([0 0.01 -0.0007 0.0007])
%ksi7 = ksi(7,:);

U = W*ksi(7,:)';
%========================================================================%



%========================================================================%
%%%%%%%%%%%%%%%%%%%           Для анимации         %%%%%%%%%%%%%%%%%%%%%%%
%alpha = 0.00049;
%beta = 0.0005;
%parametr = S0; 
%v = -parametr:0.0001:parametr;
%[x,y] = meshgrid(v);  % create a grid
%ksix = 1:length(ksi);
%ksiy = 1:length(ksi);
%ineq1 = (x.^2 + y.^2 <= 4*S0.^2);
%f1 = double(ineq1);
%contour(x,y,f1); 

 %clear,clc 
 %x0 = 0; 
 %y0 = 0; 
 %r = 5*S0; 
 %x1=[]; 
 %y1=[]; 


%for i = 1:length(ksi)
%    ksix(i) = ksi(i,3);
%    ksiy(i) = ksi(i,4);   
%end;
%DELAY = 0.08;
%xv = x+beta*l1;
%xl = x-beta*l2;
%yv = y-alpha*l1;
%yl = y+alpha*l2;
%for j = 1:3
%hold on
    %for i = 1:length(ksi)
      % clf;
       % ineq1 = (xv.^2 + yv.^2 <= S0.^2);
       % ineq2 = (xl.^2 + yl.^2 <= S0.^2);
       % f1 = double(ineq1);
       % f2 = double(ineq2);
       % contour(x,y,f1);   
       % hold on
       % contour(x,y,f2);
       % hold on
       
       %pdecirc(0,0,1);
       %crc(x0,y0,r);
       % for j=0:360 
       %     x1=[x1 x0+r*cos(j/180*pi)]; 
        %    y1=[y1 y0+r*sin(j/180*pi)]; 
      %  end
        %plot(x1,y1,'k');
     %   hold on
        %plot(ksix(i),ksiy(i),'ko','MarkerSize',260,'MarkerFaceColor',[0 0 0]);
    %    pause(DELAY);
      %  hold on
       % plot(ksix(i),ksiy(i),'ko');
   % end
%end;


xv = x+beta*l1;
xl = x-beta*l2;
yv = y-alpha*l1;
yl = y+alpha*l2;



%if (xv^2 + yv^2 <= S0^2) && (xl^2 + yl^2 <= S0^2) 
    
[A B W] = getrotor(m,S0,It,L0,l1,l2,J,Jz,w);
T1 = [0 10];

ksi0 = [alpha;beta;x;y;0;0;0;0];
[t,ksi] = ode45(@(t,ksi)valrot(t, ksi, A, B, W),T1,ksi0);


%========================================================================%



%========================================================================%
%%%%%%%%%%%%%%%%%%%           Для анимации         %%%%%%%%%%%%%%%%%%%%%%%
%open('Show_trajectory.fig');

%parametr = S0*2; 
%parametr = 1; 
%v = -parametr:0.0001:parametr;
%[x,y] = meshgrid(v);  % create a grid
%ksix = 1:length(ksi);
%ksiy = 1:length(ksi);
masxv = 1:length(ksi);
masyv = 1:length(ksi);
masxl = 1:length(ksi);
masyl = 1:length(ksi);

masx = ksi(:,3);
masy = ksi(:,4);
masalpha = ksi(:,1);
masbeta = ksi(:,2);


for i = 1:length(ksi)
    %ksix(i) = ksi(i,3);
   % ksiy(i) = ksi(i,4);   
   % masxv(i) = ksi(i,3)+ksi(i,2)*l1;
    %masyv(i) = ksi(i,4)-ksi(i,1)*l1;
    %masxl(i) = ksi(i,3)-ksi(i,2)*l2;
    %masyl(i) = ksi(i,4)+ksi(i,1)*l2;
    masxv(i) = masx(i)+masbeta(i)*l1;
    masyv(i) = masy(i)+masalpha(i)*l1;
    masxl(i) = masx(i)-masbeta(i)*l2;
    masyl(i) = masy(i)-masalpha(i)*l2;
end;


DELAY = 0.00001;

 x0 = 0; 
 y0 = 0; 
 r = 4*S0; 
 x1=[]; 
 y1=[]; 

%xv = x+beta*l1;
%xl = x-beta*l2;
%yv = y-alpha*l1;
%yl = y+alpha*l2;

    %for i = 1:length(ksi)
        %clf;
       
       % axis off
        %ineq1 = (xv.^2 + yv.^2 <= S0.^2);
        %ineq1 = (x.^2 + y.^2 <= S0.^2);
        %ineq1 = (x.^2 + y.^2 <= 16*S0.^2);
        %ineq2 = (xl.^2 + yl.^2 <= S0.^2);
        %f1 = double(ineq1);
        %f2 = double(ineq2);
        %contour(x,y,f1); 
        %contour(x,y,f1,'Linecolor',[1 0.5 0]);   
       % hold on
        %contour(x,y,f2,'Linecolor',[0.7 0 0]);
       % hold on

        %for j=0:360 
         %   x1=[x1 x0+r*cos(j/180*pi)]; 
         %  y1=[y1 y0+r*sin(j/180*pi)]; 
      %  end
       % plot(x1,y1,'k');
        %axis equal
        %axis ([-0.0027 0.0027 -0.0027 0.0027])
        %axis ([-0.0006 0.0006 -0.0006 0.0006 ])
        %plot(ksix(1),ksiy(1),'ko','MarkerSize',10,'MarkerFaceColor',[1 0 0]);
        subplot(1, 2, 1),plot(masxv(1),masyv(1),'ko','MarkerSize',10,'MarkerFaceColor',[1 0 0])
        hold on
        %plot(ksix(length(ksi)),ksiy(length(ksi)),'ko','MarkerSize',10,'MarkerFaceColor',[0 1 0]);
        subplot(1, 2, 1),plot(masxv(length(ksi)),masyv(length(ksi)),'ko','MarkerSize',10,'MarkerFaceColor',[0 1 0]);
        hold on
        %plot(ksix,ksiy);
        subplot(1, 2, 1),plot(masxv,masyv);
        hold on
        xlabel('Oxv') 
        ylabel('Oyv')
        legend('Start','Finish','Trajectory',4);
        title('Trajectory of motion in the upper EMP');
        hold off
        
        
        subplot(1, 2, 2),plot(masxl(1),masyl(1),'ko','MarkerSize',10,'MarkerFaceColor',[1 0 0])
        hold on
        %plot(ksix(length(ksi)),ksiy(length(ksi)),'ko','MarkerSize',10,'MarkerFaceColor',[0 1 0]);
        subplot(1, 2, 2),plot(masxl(length(ksi)),masyl(length(ksi)),'ko','MarkerSize',10,'MarkerFaceColor',[0 1 0]);
        hold on
        %plot(ksix,ksiy);
        subplot(1, 2, 2),plot(masxl,masyl);
        hold on
        xlabel('Oxl') 
        ylabel('Oyl') 
        legend('Start','Finish','Trajectory',4);
        title('Trajectory of motion in the lower EMP');
        hold off
        %plot(ksix(i),ksiy(i),'ko','MarkerSize',5,'MarkerFaceColor',[0.5 0.5 0.5]);
        %axis off
        %plot(ksix(i),ksiy(i),'ko','MarkerSize',40,'MarkerFaceColor',[0.5 0.5 0.5]);
        %pause(DELAY);
   % end;
%========================================================================%

