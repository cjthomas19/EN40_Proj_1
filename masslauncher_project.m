function masslauncher_project

% test
findlaunchvel(1,1,1,1)

end

function launchvel = findlaunchvel(m1,m2,k1,k2)

g = 9.8;
l1 = 1;
l2 = 1;
h1 = 1;
h2 = 1;

init_w=[0;-sqrt(-2*g*(l1+l2+h1+h2-38));0;-sqrt(-2*g*(l1+l2+h1+h2-38))]; %initial conditions; expression for v1 and v2 generated with 'Big 5' eqns

tspan=[0,10];
options = odeset('Event',@(t,w) launchevent(t,w));
[times,sol]=ode45(@(t,w) diffeq(t,w,m1,m2,k1,k2,g),tspan,init_w,options);


plot(times,sol(:,3)); %Position of the topmost mass
hold on
plot(times,sol(:,4));
legend('Position of Top Mass','Velocity of Top Mass');
launchvel=sol(end,4);
disp(launchvel);



end

function dwdt = diffeq(t,w,m1,m2,k1,k2,g)

x1 = w(1);
v1 = w(2);
x2 = w(3);
v2 = w(4);

dv1dt=(-m1*g-k2*(x2-x1)+k1*x1)/m1;
dv2dt=(-m2*g+k2*(x2-x1))/m2;
dx1dt=v1;
dx2dt=v2;
dwdt=[dx1dt;dv1dt;dx2dt;dv2dt]; %sets up the two differential equations

end

function [e_val, stop_val, e_dir] = launchevent(t,w)
e_val = w(3);
e_dir = 1;
stop_val = 1;
end %sets up the option to stop 