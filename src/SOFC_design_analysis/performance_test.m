clear; close all; clc
%%
init
load_hardware_parameters
%%
mode_all = ["rotor","pend0", "pend180"];
mode = mode_all(3); % Selct different mode to present different task

Ts_all = [0.001 0.01 0.1];
Ts = Ts_all(2);

signal_all = ["square_wave" "triangle_wave" "sine_wave"];
signal_num = 3;
signal = signal_all(signal_num);

data_file_name = signal + "_" + mode + "_" + num2str(1/Ts)
%%
Stepsize = 0.4;
unit_period = 1;
time_final = 20;
%%
kapa=542.8;
tau=0.4563;

%Motor and Pendulum Parameters:
b = 0;              % Motor-rotor viscous damping
R = 4.6;             % (Ohms)Motor coil resistant
L = 0.23e-3;          %(Henry) Motor coil inductance (xxx)
V_s = 12.91  ;    %(V)Supply voltage of the motor drive (H-bridge)
K_m = V_s/kapa ;       %(Nm/A) Motor torque constant

m=4.6*1E-2;       %(kg) Mass of pendulum
g=9.812;           %(m/s^2) Gravitational acceleration
l_c=2.54*1E-2;     %(m)Distance from pivot joint to the center of pendulum rod
J_rodc=2.36*1E-5;  %(kgm^2) Moment of inertia of pendulum about center of rod
J_rotor = tau/R*K_m^2;    %(kgm^2)Moment of inertia of inertia mode of system
J_motor = J_rotor - J_rodc;

Angle_Pendu=180/180*pi;   %pendulum equlibrium position, 0 is vertically down, 180 is up
K_g =  m*g*l_c;
K_sin = cos(Angle_Pendu);  %linearization sin(angle)

switch(mode)
    case {'rotor'}
        K_tot =0;  %K_pend=0 for the rotor mode
        J_pend =J_rotor;  % If this is for the rotor, treat as a special case of pendulum
    case {'pend0'}
        K_tot = m*g*l_c*cos(0);
        J_pend=J_rotor+m*l_c^2 ;
    case {"pend180"}
        K_tot = m*g*l_c*cos(pi);
        J_pend=J_rotor+m*l_c^2 ;
end

s = tf('s');
P_rotorred=kapa/(tau*s+1);
P_rotorposred=P_rotorred/s;
F_rotorred=R/(K_m*V_s);
P_penduposred= P_rotorposred/(1+K_tot*P_rotorposred*F_rotorred);

A = [0 1; -K_tot/J_pend -1/tau];
B = [0; kapa/tau];
C = [1 0];
G = ss(A, B, C, 0); % Derive transfer function from the matrix
G_d= c2d(G,Ts,'zoh'); % Get discrete-time transfer function 
[A_d, B_d, C_d, ~] = ssdata(G_d);
Plant = tf(G);
Plant_d = tf(G_d);

Zeta_obs = 1; % Observer Damping Ratio
Wn_obs = 1000*2*pi; % Observer Natural Frequency
Tr_ctl = 0.05; % Rise time 0.05
Mp_ctl = 15/100; % Maximum percent overshoot 15%

[L_Pred, K_SF, N, K_int, Loop_SF, SS_closed, TF] = SOFC(G,...
    Ts, Zeta_obs, Wn_obs, Tr_ctl, Mp_ctl, F_rotorred, 'SOFC'); %Get controller gain, observer gain and feedforward gain

open('performance_sim_test.slx');
