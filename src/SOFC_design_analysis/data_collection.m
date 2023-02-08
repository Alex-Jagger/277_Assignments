%%

% model_name = "real_";
% 
% % model_type = "rotor_";
% % model_type = "pendulum_0_";
% model_type = "pendulum_180_";
% 
% freq = num2str(1/Ts);
% 
% data_file_name = model_name + model_type + "SOFC_0_5_" + "response_" +  freq + "Hz"

clear all; close all; clc
%%
init
load('step_rod_05_1.mat')

time = data{3}.Values.Time;
vel_response = data{3}.Values.Data;


n1 = 100;
index_temp = time >= 9;
time = time(index_temp) - 9;
vel_response = vel_response(index_temp);
[vel_response, time] = smooth_signal(vel_response, time, n1);

figure
plot(time, vel_response)

clear data
data.time = time;
data.vel = vel_response;

save('yuchen_data/real_model_data/real_rotor_OpenLoop_step_0_5_response', "data")