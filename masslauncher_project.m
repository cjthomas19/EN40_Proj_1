function masslauncher_project
%Function to find optimal springs and mass values to shoot the top mass
%with as much speed as possible

%Begin with a clear workspace
clear all;
close all;

%Intuitively, it makes sense that the heaviest mass and stiffest springs
%should be at the bottom, so this is our initial guess
init_guess = [3,1,0.5,500,200,20];

%Minimum and maximum weights/spring constants from problem description
min_vars = [0.117,0.117,0.117,15,15,15];
max_vars = [5.84,5.84,5.84,1310,1310,1310];

%This equation in the form Ax<=b prevents the total amount of mass from
%exceeding 7lbs, as stated in the problem description
A = [1,1,1,0,0,0]; b = [7];
C = []; d = [];

%Use fmincon with a defined objective function to determine optimal values
[optimal_soln,max_vel]=fmincon(@(v) objective(v),init_guess,A,b,C,d,min_vars,max_vars);

%Negate result because we optimized the negative of the velocity (fmincon
%only does minimization, not maximization)
max_val = - max_vel;

%Display information about the optimization
disp('Optimal Maximum Velocity is...');
disp(max_val);
disp('m1 m2 m3 k1 k2 k3');
disp(optimal_soln);

%These are actual values of the springs/masses available closest to our
%calculated values. Here we check the theoretical final velocity
[times,solns]=solveforlaunchvel(5.84,0.829,.117,959,134.44,15);
actual_vel=solns(end,6);
disp('Actual velocity based on available masses and springs...');
disp(actual_vel);

%plot spring compressions
figure;
plot(times, (solns(:,1)) * 12);
hold on;
plot(times, (solns(:,3) - solns(:,1)) * 12);
plot(times, (solns(:,5) - solns(:,3)) * 12);

title("Spring Compressions vs. Time");
xlabel("t (s)");
ylabel("displacement (in)");
legend(["Spring 1","Spring 2", "Spring 3"]);

end

function vel = objective(v)
%Define the objective function with our function to find velocity

%find solutions for given v
[t,sol] = solveforlaunchvel(v(1),v(2),v(3),v(4),v(5),v(6));

%because the event function should stop the calculation when the mass
%leaves, the launch velocity will be the final velocity of m3 in solution
launchvel=sol(end,6);

vel = -1 * launchvel;
end

function [times,solns] = solveforlaunchvel(m1,m2,m3,k1,k2,k3)

g = 32.17; % define g in units of ft / s^2

m1 = m1 * 0.03108095; %lbs to slugs (slugs are lb * s^2 / ft)
m2 = m2 * 0.03108095; %we do this conversion because slugs are a unit of
m3 = m3 * 0.03108095; %mass and lbs are a unit of weight

k1 = k1 * 12; % lbs/in to lbs/ft
k2 = k2 * 12; %we chose feet as our unit of distance, designing around
k3 = k3 * 12; %slugs, so spring constants need to be adjusted

%initial values of the w function for ode45, based on initial displacements
%and an initial velocity calculated from the distance fallen
init_w = [0;-14.2;0;-14.2;0;-14.2]; 

%the event function should stop ode45 before this, but large time range to
%be safe
tspan=[0,10];

%pass event function in to ode45 as options
options = odeset('Event',@(t,w) launchevent(t,w));

%solve the diff eqs with given variables
[times,solns]=ode45(@(t,w) diffeq(t,w,m1,m2,m3,k1,k2,k3,g),tspan,init_w,options);


end



function dwdt = diffeq(t,w,m1,m2,m3,k1,k2,k3,g)

%define differential equation according to physics
%define each variable from bottom to top from w vector
x1 = w(1);
v1 = w(2);
x2 = w(3);
v2 = w(4);
x3 = w(5);
v3 = w(6);

%define each differential equation, where x_n is a displacement of mass n
dv1dt= (k2 * (x2 - x1) - m1 * g - k1 * x1) / m1;
dv2dt= (k3 * (x3 - x2) - k2 * (x2 - x1) - m2 * g)/m2;
dv3dt = (-k3 * (x3 - x2) - m2 * g)/m3;
dx1dt=v1;
dx2dt=v2;
dx3dt=v3;

dwdt=[dx1dt;dv1dt;dx2dt;dv2dt;dx3dt;dv3dt]; %return the three differential equations

end

function [e_val, stop_val, e_dir] = launchevent(t,w)
%sets up the option to stop 
%e_val function is x3-x2, because when this goes to zero, the top spring is
%unstretched and therefore no longer exerting force on the mass (the mass
%has left)
e_val = w(5)-w(3);
stop_val = 1;
e_dir = 1;
end 