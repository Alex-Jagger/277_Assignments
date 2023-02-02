% 277 Assignment Repository Initialization
%
% This file should always be run the first when doing any thing with the
% repository
%%
clear; close all; clc

%% Add paths
addpath(pwd, ...
    genpath("..\lib"), ...
    genpath("..\test"), ...
    genpath("..\data"))
savepath
%% Parameter

% Encoder
param.encoder.freq = 1e4;
param.encoder.Tss = 1/param.encoder.freq;
param.encoder.resol = 2000;
param.encoder.cnt_init = 2^24;

% PMW
param.pwm.Ts =  1e-5;
param.pwm.timer_period = floor(1e8*param.pwm.Ts/2);
param.pwm.set_point = floor(param.pwm.timer_period/2);

% Virtual Plant
param.vp.R = 4.6;                   % Ohm
% param.vp.J_rod = 1/12*
% J_rotor = J_motor + J_rod
% J_pend = J_rotor + l_c^2*J_rod
param.vp.J_rotor = 2.3270e-05;      % kg*m^2
