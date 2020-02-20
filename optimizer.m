function optimizer

x=-2*pi:.1:2*pi;
y=x;
z=cos(y)'*sin(x);
figure
contour(x,y,z);
hold on
init_guess=[1,.5]; %will trap into local min if guess isn't good (keep within acceptable parameters) 
min_vars=[-2,-1];
max_vars=[Inf,Inf];
A=[4,3]; b=[6];%used in project: Av<=b (assumed by MATLAB) -> must find A and b
%ex: if 4x+3y<=6: [4,3]=A and b=6
C=[]; d=[];%unused for project (leave as blank) -> enforce equality constraints (along parameters, instead of within)
[optimalxy,minz]=fmincon(@(v) objective(v),init_guess,A,b,C,d,min_vars,max_vars);
    
plot3(init_guess(1),init_guess(2),objective(init_guess));
plot3(optimalxy(1),optimalxy(2),minz);

%add inequali=ty constraints in matrix form to MATLAB

end

function z=objective(v)
x=v(1); y=v(2);
z=cos(y)*sin(x);
end
