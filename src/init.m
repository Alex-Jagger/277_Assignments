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

%% Parameter

% Encoder
param.encoder.freq = 1000;
param.encoder.resol = 2000;
param.encoder.cnt_init = 10000;

% PMW
param.pwm.timer_period = 2000;
param.pwm.set_point = floor(param.pwm.timer_period/2);

% Virtual Plant
% 
% param.vp.Ts = 0.001;
% 
% param.vp.m = 4.4e-2;    % kg
% param.vp.g = 9.812;          % m/s^2
% param.vp.l_c = 2.54e-2;      % m         Distance from pivot joint to the center of pendulum rod
% param.vp.J_rodc = 2.16e-5;    % kg*m^2   Moment of inertia of pendulum about center of rod
% param.vp.J_motor = 1.67e-6;  % kg*m^2    Moment of intertia of motor rotor
% param.vp.J_rotor = param.vp.J_rodc + param.vp.J_motor;
%                                 % kg*m^2    Moment of inertia of inertia
%                                 % mode of system
% param.vp.J_pend = param.vp.J_rotor + param.vp.l_c^2;
%                                 % kg*m^2    Moment of inertia of pendulum
%                                 % mode of system
% 
% param.vp.b = 0;
% param.vp.R = 3.85;
% param.vp.L = 0.23e-3;
% param.vp.K_m = 2.3e-2;
% param.vp.V_s = 12 - 0.65*2;
% 
% param.vp.Tcomp = 0.0005*param.vp.Ts*14;  %controller computation delay (less than one sampling interval)
% param.vp.saturation =1.0;    %PWM duty cycle is between - and 100% and polarity
% param.vp.deadzone = 0.06;    % PWM switcing short circuit protection results in 4% duty cycle deadzone
% param.vp.Tss= 1/20000;       % 20kHz Encoder sampling rate by FPGA
% param.vp.encoder_resolution= 2*pi/400;  % Encoder resolution 400 counts/revolutin
% 
% param.vp.Angle_Pendu=180/180*pi;   %pendulum equlibrium position, 0 is vertically down, 180 is up
% param.vp.K_g =  param.vp.m*param.vp.g*param.vp.l_c;
% param.vp.K_sin = cos(param.vp.Angle_Pendu);  %linearization sin(angle)
% param.vp.Friction_static = 4E-4; %Static friction Nm

load('norm_ctrl_param.mat')
%%
