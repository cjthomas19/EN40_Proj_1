function masslauncher_project

% test

end

function launchvel = findlaunchvel(m1,m2,k1,k2)



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

end