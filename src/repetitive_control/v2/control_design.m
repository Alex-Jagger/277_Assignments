clear all; close all; clc
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
save("..\..\..\data\SOFCI_controller", "A_d", "B_d", "C_d", "K_aug", "L_Pred", "N", "Ad", "Bd", "TF");