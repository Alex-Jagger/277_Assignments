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
param.encoder.freq = 1000;
param.encoder.resol = 2000;
param.encoder.cnt_init = 10000;

% PMW
param.pwm.timer_period = 2000;
param.pwm.set_point = floor(param.pwm.timer_period/2);
%%
