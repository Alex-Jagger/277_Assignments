%%
clear all; close all; clc
%%
init
load_our_parameters
load_hardware_parameters
%%
clear; close all; clc
%%
init
%% 
load_our_parameters
load_hardware_parameters
%%

design_lib = ["SOFC","SOFCI","SOFCIO"];
design = design_lib(2);

methods = ["LQG","Pole Placement"];
method = methods(1);

signal_list = ["step", "sine", "square", "trig"];
signal_num = 1; % 1: step, 2: Sine, 3: Square
signal = signal_list(signal_num);

file_name_data = design + "_" + signal

TS =  [0.01,0.001];
Ts = TS(2);
%%
Stepsize = 0.4;
unit_period = 1;
time_step = 10;
time_final = 20;
%%

%Parameters in the virtual plant simulation:
Tcomp=0.0005*Ts*14;  %controller computation delay (less than one sampling interval)
Tss= 1/10000;       % 10kHz Encoder sampling rate by FPGA
encoder_resolution= 2*pi/2000;  % Encoder resolution 2000 counts/revolutin

Angle_Pendu=180/180*pi;   %pendulum equlibrium position, 0 is vertically down, 180 is up

K_g =  m*g*l_c;
K_sin = cos(Angle_Pendu);  %linearization sin(angle)

Mode_all = ["rotor","pendulum"];
Mode = Mode_all(2); % Selct different mode to present different task


K_pend = 0;  %K_pend=0 for the rotor mode
J_pend =J_rotor;  % If this is for the rotor, treat as a special case of pendulum

K_tot = K_g*K_sin*K_pend;
s = tf('s');

% Continuous-time plant model

%Full order motor-rotor model (third order):
P_rotorfull= (K_m*V_s)/((J_pend*s+b)*(L*s+R)+K_m^2);
P_rotorposfull= P_rotorfull/s;
F_rotorfull=(L*s+R)/(K_m*V_s);
P_penduposfull= P_rotorposfull/(1+K_tot*P_rotorposfull*F_rotorfull); % Full Linear Sys

%Reduced order motor-rotor model for control design (second order, assuming b=0,L=0):
P_rotorred=kapa/(tau*s+1);
P_rotorposred=P_rotorred/s;
F_rotorred=R/(K_m*V_s);
P_penduposred= P_rotorposred/(1+K_tot*P_rotorposred*F_rotorred);

z = tf('z',Ts); %Create discrete time tf variable

A = [0 1; -K_tot/J_pend -1/tau];
B = [0; kapa/tau];
C = [1 0];
G = ss(A, B, C, 0); % Derive transfer function from the matrix
G_d= c2d(G,Ts,'zoh'); % Get discrete-time transfer function 
[A_d, B_d, C_d, ~] = ssdata(G_d);
Plant = tf(G);
Plant_d = tf(G_d);

Zeta_obs = 1; % Observer Damping Ratio
Wn_obs = 100*2*pi; % Observer Natural Frequency
Tr_ctl = 0.05; % Rise time 0.05
Mp_ctl = 15/100; % Maximum percent overshoot 15%

        
[L_Pred, K_SF, N, K_int, Loop_SF, SS_closed, TF,num,dem,Ad,Bd] = SOFC(G,...
    Ts, Zeta_obs, Wn_obs, Tr_ctl, Mp_ctl, F_rotorred, design,method); %Get controller gain, observer gain and feedforward gain
K_SF
L_Pred
K_aug = [K_SF,K_int]

%%


