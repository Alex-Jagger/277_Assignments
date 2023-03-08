clear; close all; clc
%%
init
%% 
load_our_parameters
load_hardware_parameters
%%
design = "SOFCI";
method = "LQG";
Ts = 0.001;
%%
Angle_Pendu=180/180*pi;   %pendulum equlibrium position, 0 is vertically down, 180 is up

K_g =  m*g*l_c;
K_sin = cos(Angle_Pendu);  %linearization sin(angle)

K_pend = 1;
J_pend = J_rotor + m*l_c^2;

K_tot = K_g*K_sin*K_pend;
F_rotorred=R/(K_m*V_s);

A = [0 1; -K_tot/J_pend -1/tau];
B = [0; kapa/tau];
C = [1 0];
G = ss(A, B, C, 0); % Derive transfer function from the matrix
G_d= c2d(G,Ts,'zoh'); % Get discrete-time transfer function 
[A_d, B_d, C_d, ~] = ssdata(G_d);

Zeta_obs = 1; % Observer Damping Ratio
Wn_obs = 100*2*pi; % Observer Natural Frequency
Tr_ctl = 0.05; % Rise time 0.05
Mp_ctl = 15/100; % Maximum percent overshoot 15%
        
[L_Pred, K_SF, N, K_int, Loop_SF, SS_closed, TF,num,dem,Ad,Bd] = SOFC(G,...
    Ts, Zeta_obs, Wn_obs, Tr_ctl, Mp_ctl, F_rotorred, design,method); %Get controller gain, observer gain and feedforward gain
K_aug = [K_SF,K_int]
%%
Stepsize = 0.4;
time_step = 10;
time_final = 20;
%%
addpath("../../data/system_id_CLSOFCI_data/")
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