clc;
close all;
clear all;

disp(sprintf('\n\n'))
disp('Elliptic and Algebraic Mesh Generation')
disp('© Siamak Faridani, 2006')
disp(' ')

disp(sprintf('\n'))
%These lines gets the input grid via a getfile user interface
%Files should be in taken from this website
%http://www.ae.uiuc.edu/m-selig/ads/coord_database.html


[filename, pathname] = uigetfile( ...
    {'*.dat','Airfoil Data Files (*.dat)';
    '*.*',  'All Files (*.*)'}, ...
    'Pick a file');
airfoildatafile = fopen(fullfile(pathname, filename),'r'); % Opens the file for reading






airfoilname=FGETL(airfoildatafile); %reads the airfoil name





a = fscanf(airfoildatafile, '%g %g', [2 inf]);    % It has two rows now.
a = a';
x=a(:,1)';
y=a(:,2)';
n=size(x,2);
fclose(airfoildatafile);

x=x(end:-1:1);
y=y(end:-1:1);


disp(sprintf('Number of data points for the airfoil= %d \n', n));




nsec=8; % number of sections on the airfoil/2








%start alg grid

temp_x=linspace(0,1,nsec*2);
newy=interp1(x,y,temp_x);


x=[linspace(-.5,0-(1/(2*nsec)),nsec) temp_x linspace(1+(1/(2*nsec)),1.5,nsec)];
y=[zeros(1,nsec) newy zeros(1,nsec)];


imax=4*nsec;
jmax=20;

y=[y; zeros(jmax-2,imax);ones(1,imax)];
x=[x; zeros(jmax-2,imax);linspace(-.5,1.5,imax)];
cy=8;
for i=1:imax
    for j=2:jmax-1
        y(j,i)=y(1,i)-(((y(jmax,i)-y(1,i))/cy)*log(1+(exp(-cy)-1)*((j-1)/(jmax-1))));
        y(j,i);

        if (x(1,i)==x(jmax,i))
            x(j,i)=x(1,i);
        else
            %x(j,i)=interp1([x(1,i),x(jmax,i)],[y(1,i),y(jmax,i)],y(j,i));
            x(j,i)=((x(1,i)-x(jmax,i))/(y(1,i)-y(jmax,i)))*(y(j,i)-y(1,i))+x(1,i);
            if isnan(x(j,i))
                disp('===')
                disp(j)
                disp(i)
                disp('/====');
            end


        end




    end
end

hold on;
for j=1:jmax
    plot(x(j,:),y(j,:),'black');
end
for i=1:imax
    plot(x(:,i),y(:,i),'black');
end
plot(x(1,:),y(1,:),'r','LineWidth',3);
plot(x(jmax,:),y(jmax,:),'r', 'LineWidth',3);
plot(x(:,1),y(:,1),'r', 'LineWidth',3);
plot(x(:,imax),y(:,imax),'r', 'LineWidth',3);

x_alg=x;
y_alg=y;

%============
% end of algebraic grid
%==============

%=======================
% phi and psi =0
%=======================


err=0;
err2=1;

while (abs(err2-err)>3e10*eps)
    for j=2:imax-1
        for i=2:jmax-1
            g11=((x(i+1,j)-x(i-1,j))^2+(y(i+1,j)-y(i-1,j))^2)/4;
            g22=((x(i,j+1)-x(i,j-1))^2+(y(i,j+1)-y(i,j-1))^2)/4;
            g12=(x(i+1,j)-x(i-1,j))*(x(i,j+1)-x(i,j-1))/4+(y(i+1,j)-y(i-1,j))*(y(i,j+1)-y(i,j-1))/4;

            xtemp=1/(2*(g11+g22))*(g22*x(i+1,j)-0.5*g12*x(i+1,j+1)+0.5*g12*x(i+1,j-1)+g11*x(i,j+1)+g11*x(i,j-1)+g22*x(i-1,j)-0.5*g12*x(i-1,j-1)+0.5*g12*x(i-1,j+1));
            ytemp=1/(2*(g11+g22))*(g22*y(i+1,j)-0.5*g12*y(i+1,j+1)+0.5*g12*y(i+1,j-1)+g11*y(i,j+1)+g11*y(i,j-1)+g22*y(i-1,j)-0.5*g12*y(i-1,j-1)+0.5*g12*y(i-1,j+1));
            err=err2;
            err2=(x(i,j)-xtemp)^2+(y(i,j)-ytemp)^2;

            x(i,j)=xtemp;
            y(i,j)=ytemp;
        end
    end

end

figure;
hold on
for j=1:jmax
    plot(x(j,:),y(j,:),'black');
end
for i=1:imax
    plot(x(:,i),y(:,i),'black');
end
plot(x(1,:),y(1,:),'r','LineWidth',3);
plot(x(jmax,:),y(jmax,:),'r', 'LineWidth',3);
plot(x(:,1),y(:,1),'r', 'LineWidth',3);
plot(x(:,imax),y(:,imax),'r', 'LineWidth',3);

x_regular=x;
y_regular=y;

