function read_converted_data

filename = "mass_launcher_test_data2.csv";

cond_data = csvread(filename);

data_dim = size(cond_data);

velocity_matrix = zeros(data_dim(1)-1,data_dim(2));

for i = 1:data_dim(1)-1
    t1 = cond_data(i,1);
    t2 = cond_data(i+1,1);
    
    delta_t = t2 - t1;
    
    velocity_matrix(i,1) = t1 + delta_t/2;
    
    for mass = 1:3
        p1 = cond_data(i,mass + 1);
        p2 = cond_data(i+1,mass + 1);
        
        vel = (p2 - p1)/delta_t;
        vel = vel / 2.54;
        vel = vel / 12;
    
        velocity_matrix(i,mass + 1) = vel;
    end
    
end

for mass = 1:3
    plot(velocity_matrix(:,1),velocity_matrix(:,mass+1));
    hold on;
end

legend(["Mass 1 (bottom)","Mass 2 (middle)","Mass 3 (top)"]);

title("Measured Mass Velocities vs. Time");
xlabel("t (s)");
ylabel("velocity (ft/s)");


end