clear; close all; clc
%%
init
%% 
load_our_parameters
load_hardware_parameters
%%
load("SOFCI_controller.mat")
%%
Ts = 0.001;
Stepsize = 0.4;
time_step = 10;
time_final = 20;
%%
% addpath("../../data/system_id_CLSOFCI_data/")
load("system_id_CLSOFCI_1.mat", 'data');
%%
time = data{1}.Values.Time;
pos_response = data{1}.Values.Data;
% [pos_response, time] = smooth_signal(pos_response, time, 50);
% figure; hold on; grid on
% plot(time, pos_response)

index_temp = time >= time_step;
time = time(index_temp) - 10;
pos_response = pos_response(index_temp);

input = Stepsize*(time >= 0);

pos_iddata= iddata(pos_response, input, encoder_Tss);
system_pos = tfest(pos_iddata, 2, 0);
zpk(system_pos)
zpk(c2d(system_pos, Ts))
%%
figure; hold on; grid on
plot(time, pos_response/Stepsize, "Color", "red")
step(system_pos, 10)