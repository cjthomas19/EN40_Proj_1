function masslauncher_project

% test

end

function launchvel = findlaunchvel(Design_Variables)



end

function dwdt = diffeq(t,w)

x=w(1);
v=w(2);

dvdt=(-m1*g-k2*(x2-x1)+k1*x1)/m1;
dvdt=(-m2*g+k2*(x2-x1))/m2;
dxdt=v;
dwdt=[dxdt;dvdt];


end

function [e_val, stop_val, e_dir] = launchevent(t,w)

end