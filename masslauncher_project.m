function masslauncher_project

% test

end

function launchvel = findlaunchvel(m1,m2,k1,k2)


init_w=[0;sqrt(-2*g*(l1+l2+h1+h2-38);0;sqrt(-2*g*(l1+l2+h1+h2-38)];
tspan=[0,10];
options = odeset('Event',@(t,w) launchevent(t,w));
[times,sol]=ode45(@(t,w,m1,m2,k1,k2) diffeq(t,w,m1,m2,k1,k2),tspan,init_w,options)

disp(sol(:,3);



end

function dwdt = diffeq(t,w,m1,m2,k1,k2)

x1 = w(1);
v1 = w(2);
x2 = w(3);
v2 = w(4);

dv1dt=(-m1*g-k2*(x2-x1)+k1*x1)/m1;
dv2dt=(-m2*g+k2*(x2-x1))/m2;
dx1dt=v1;
dx2dt=v2;
dwdt=[dx1dt;dv1dt;dx2dt;dv2dt];

end

function [e_val, stop_val, e_dir] = launchevent(t,w)
e_val = w(3);
e_dir = 1;
stop_val = 1;
end