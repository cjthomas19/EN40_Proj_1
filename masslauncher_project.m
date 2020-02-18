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

<<<<<<< HEAD
<<<<<<< HEAD
init_w=[0;sqrt(-2*g*(l1+l2+h1+h2-38);0;sqrt(-2*g*(l1+l2+h1+h2-38)]; %initial conditions; expression for v1 and v2 generated with 'Big 5' eqns
=======
init_w=[0;sqrt(-2*g*(l1+l2+h1+h2-38));0;sqrt(-2*g*(l1+l2+h1+h2-38))];
>>>>>>> ec8b207c4a14c69f6c67e73accb8c056e4f6f5b5
=======
init_w=[0;sqrt(-2*g*(l1+l2+h1+h2-38));0;sqrt(-2*g*(l1+l2+h1+h2-38))];
>>>>>>> ec8b207c4a14c69f6c67e73accb8c056e4f6f5b5
tspan=[0,10];
options = odeset('Event',@(t,w) launchevent(t,w));
[times,sol]=ode45(@(t,w) diffeq(t,w,m1,m2,k1,k2,g),tspan,init_w,options);

<<<<<<< HEAD
<<<<<<< HEAD
disp(sol(:,3); %Velocity of the topmost mass
=======
=======
>>>>>>> ec8b207c4a14c69f6c67e73accb8c056e4f6f5b5
plot(times,sol(:,3));


>>>>>>> ec8b207c4a14c69f6c67e73accb8c056e4f6f5b5

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