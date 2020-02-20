function masslauncher_project
clear all;
close all;

findlaunchvel(3,1,0.1,1310,200,15);

end

function launchvel = findlaunchvel(m1,m2,m3,k1,k2,k3)

g = 32; %ft / s^2

m1 = m1 * 0.03108095; %lbs to slugs (lb * s^2 / ft)
m2 = m2 * 0.03108095;
m3 = m3 * 0.03108095;

k1 = k1 * 12; % lbs/in to lbs/ft
k2 = k2 * 12;
k3 = k3 * 12;

init_w = [0;-14.2;0;-14.2;0;-14.2];


tspan=[0,10];
options = odeset('Event',@(t,w) launchevent(t,w));
[times,sol]=ode45(@(t,w) diffeq(t,w,m1,m2,m3,k1,k2,k3,g),tspan,init_w,options);

plot(times,sol(:,5)); %Position of the topmost mass
hold on
plot(times,sol(:,6));
legend('Position of Top Mass','Velocity of Top Mass');
launchvel=sol(end,6);
disp(launchvel);

end

function dwdt = diffeq(t,w,m1,m2,m3,k1,k2,k3,g)

x1 = w(1);
v1 = w(2);
x2 = w(3);
v2 = w(4);
x3 = w(5);
v3 = w(6);

%% TODO: Finish writing diff-eq
dv1dt= (k2 * (x2 - x1) - m1 * g - k1 * x1) / m1;
dv2dt= (k3 * (x3 - x2) - k2 * (x2 - x1) - m2 * g)/m2;
dv3dt = (-k3 * (x3 - x2) - m2 * g)/m3;
dx1dt=v1;
dx2dt=v2;
dx3dt=v3;

dwdt=[dx1dt;dv1dt;dx2dt;dv2dt;dx3dt;dv3dt]; %sets up the two differential equations

end

function [e_val, stop_val, e_dir] = launchevent(t,w)
e_val = w(5)-w(3);
e_dir = 1;
stop_val = 1;
e_dir = 1;
end %sets up the option to stop 