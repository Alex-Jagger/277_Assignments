clear; close all; clc
%%
run('init.m')
%% Nominal Virtual Plant

Ts = 0.001;  %digital control sampling time


%Motor and Pendulum Parameters:
m=4.4*1E-2;       %(kg) Mass of pendulum
g=9.812;           %(m/s^2) Gravitational acceleration
l_c=2.54*1E-2;     %(m)Distance from pivot joint to the center of pendulum rod
J_rodc=2.16*1E-5;  %(kgm^2) Moment of inertia of pendulum about center of rod
J_motor=1.67*1E-6; %(kgm^2)  Moment of inertia of motor rotor
J_rotor=J_rodc+J_motor;    %(kgm^2)Moment of inertia of inertia mode of system
J_pend=J_rotor+m*l_c^2 ;   %(kgm^2) Moment of inertia of pendulum mode of system

b = 0;              % Motor-rotor viscous damping
R=3.85;             % (Ohms)Motor coil resistant
L=0.23e-3;          %(Henry) Motor coil inductance
K_m=2.40E-2 ;       %(Nm/A) Motor torque constant
V_s=12-0.65*2  ;    %(V)Supply voltage of the motor drive (H-bridge)
% input d = Duty cycle
% output (rad) - Angle of pendulum

%Parameters in the virtual plant simulation:
Tcomp=0.0005*Ts*14;  %controller computation delay (less than one sampling interval)
saturation =1.0;    %PWM duty cycle is between - and 100% and polarity
deadzone = 0.06;    % PWM switcing short circuit protection results in 4% duty cycle deadzone
Tss= 1/20000;       % 20kHz Encoder sampling rate by FPGA
encoder_resolution= 2*pi/400;  % Encoder resolution 400 counts/revolutin

Angle_Pendu=180/180*pi;   %pendulum equlibrium position, 0 is vertically down, 180 is up
K_g =  m*g*l_c;
K_sin = cos(Angle_Pendu);  %linearization sin(angle)
Friction_static = 4E-4; %Static friction Nm
K_pend =0;
Stepsize= 1;
J_pend =J_rotor;
load('../../data/nominal_model_SOFC_parmeters.mat')

SOFC(G, Ts, Zeta_obs, Wn_obs, Tr_ctl, Mp_ctl)
%%
% steptime = 10;
% stepinput = 1;
% stoptime = 20;
%%
% ref = step_time_response_test2{1}.Values.Data;
% y_m_real = step_time_response_test2{2}.Values.Data;
% y_m_real_ts = step_time_response_test2{2}.Values;
% 
% %%
% tspan = linspace(0, 10, 10001) + 9;
% %%
% figure; hold on; grid on
% plot(tspan, y_m_L, 'LineWidth', 1.5)
% plot(tspan, y_m_NL, 'LineWidth', 1.5)
% plot(step_time_response_test2{2}.Values, 'LineWidth', 1.5)
% xlim([4 18])
% legend('Simulation Linear', 'Simulation Non-Linear','Experiment')