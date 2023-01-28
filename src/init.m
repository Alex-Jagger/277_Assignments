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
param.encoder.freq = 1e5;
param.encoder.Tss = 1/param.encoder.freq;
param.encoder.resol = 2000;
param.encoder.cnt_init = 2^24;

% PMW
param.pwm.Ts =  1e-05;
param.pwm.timer_period = floor(1e8*param.pwm.Ts/2);
param.pwm.set_point = floor(param.pwm.timer_period/2);
%%
