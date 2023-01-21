% 277 Assignment Repository Initialization
%
% This file should always be run the first when doing any thing with the
% repository
%%
clear; close all; clc

%% Add paths
addpath(pwd, ...
    genpath("..\lib"), ...
    genpath("..\test"));

%% Constant

% Encoder
constant.encoder.freq = 100;
constant.encoder.resol = 2000;
constant.encoder.cnt_init = 10000;

% PMW
constant.pwm.timer_period = 2000;
constant.pwm.set_point = floor(constant.pwm.timer_period/2);
