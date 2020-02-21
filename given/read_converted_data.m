function read_converted_data
close all;
clear all;
%Function to read and plot the csv data generated by given code

%Put filename of csv data here - change if filename differs
filename = "mass_launcher_test_data2.csv";

%Generate condensed data array consisting of times in column one and
%positions of each mass in columns 2 - 4
cond_data = csvread(filename);

%Get the dimensions of the condensed data
data_dim = size(cond_data);

%Pre-allocate a matrix to store all the velocity data
velocity_matrix = zeros(data_dim(1)-1,data_dim(2));

%For loop to loop through every row in the condensed data, skipping the
%last one (we are calculating differentials between data points)
for i = 1:data_dim(1)-1
    
    %Find initial and end times
    t1 = cond_data(i,1);
    t2 = cond_data(i+1,1);
    
    %Change in time
    delta_t = t2 - t1;
    
    %Set the ith element of the time column to the average of t1 and t2
    velocity_matrix(i,1) = t1 + delta_t/2;
    
    %Loop through each mass column
    for mass = 1:(data_dim(2)-1)
        
        %Gather initial and final positions
        p1 = cond_data(i,mass + 1);
        p2 = cond_data(i+1,mass + 1);
        
        %Formula: v = dx/dt
        vel = (p2 - p1)/delta_t;
        
        %Convert from cm/s to in/s
        vel = vel / 2.54;
        
        %in/s to ft/s
        vel = vel / 12;
    
        %Store value in new velocity matrix
        velocity_matrix(i,mass + 1) = vel;
    end
    
end

%Loop through each mass and plot velocity vs. time
for mass = 1:(data_dim(2)-1)
    plot(velocity_matrix(:,1),velocity_matrix(:,mass+1));
    hold on;
end

%Plot a vertical line at the expected velocity from our velocity prediction
expected_mass_3_vel = 39.9574;
expected_graph(1:(data_dim(1)-1)) = expected_mass_3_vel;
plot(velocity_matrix(:,1),expected_graph);

%Make the graph easier to read with labels and a legend
legend(["Mass 1 (bottom)","Mass 2 (middle)","Mass 3 (top)","Estimated Launch Velocity"]);
title("Measured Mass Velocities vs. Time");
xlabel("t (s)");
ylabel("velocity (ft/s)");

%To find launch velocity, should be max velocity of the puck
disp("Max Velocity of Top Mass: " + max(max(velocity_matrix(:,4))));
end