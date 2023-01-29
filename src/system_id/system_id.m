% System ID
% clear; close all; clc
%%
run('init.m')
Tss = param.encoder.Tss;
stepsize = 0.3;
chirp_init_freq = 0; %Hz
chirp_target_freq = 100;
[sys,kapa,tau] = get_tf('system_id\step_3_1.mat',Tss);

