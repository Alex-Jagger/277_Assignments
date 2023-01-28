% System ID
% clear; close all; clc
%%
run('init.m')
Tss = param.encoder.Tss;
%%
stepsize = 0.3;
%%
chirp_init_freq = 0; %Hz
chirp_target_freq = 100;
%%
load('step_3_1.mat')
%%

time_3_1 = data{2}.Values.Time;
response_3_1 = data{2}.Values.Data;
step_3_1 = data{1}.Values.Data;

index_temp = time_3_1 >= 10;
time_3_1 = time_3_1(index_temp);
response_3_1 = response_3_1(index_temp);
step_3_1 = step_3_1(index_temp);

data_3_1 = iddata(response_3_1, step_3_1,Tss);
%%
tau_init = 42076.6;
kapa_init = 79.0012;
sys_init = idtf(tau_init, [kapa_init 1 0]);
sys = tfest(data_3_1, sys_init);
% figure; hold on; grid on
% 
% plot(data{2}.Values)
