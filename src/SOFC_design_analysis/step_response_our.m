clear; close all; clc
%%
run('init.m')
%% Our Virtual Plant
TS =  [0.1,0.01,0.001];
fre = ["10 Hz","100 Hz","1000 Hz"];
for i = 1:3
Ts = TS(i);  %digital control sampling time 0.1/0.01/0.001

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
% J_motor=1.67*1E-6; %(kgm^2)  Moment of inertia of motor rotor
J_rotor = tau/R*K_m^2;    %(kgm^2)Moment of inertia of inertia mode of system
J_motor = J_rotor - J_rodc;
J_pend=J_rotor+m*l_c^2 ;   %(kgm^2) Moment of inertia of pendulum mode of system



% input d = Duty cycle
% output (rad) - Angle of pendulum

%Parameters in the virtual plant simulation:
Tcomp=0.0005*Ts*14;  %controller computation delay (less than one sampling interval)
saturation =1.0;    %PWM duty cycle is between - and 100% and polarity
deadzone = 0.05;    % PWM switcing short circuit protection results in 4% duty cycle deadzone
Tss= 1/10000;       % 10kHz Encoder sampling rate by FPGA
encoder_resolution= 2*pi/2000;  % Encoder resolution 2000 counts/revolutin

Angle_Pendu=180/180*pi;   %pendulum equlibrium position, 0 is vertically down, 180 is up
K_g =  m*g*l_c;
K_sin = cos(Angle_Pendu);  %linearization sin(angle)
Friction_static = 3.93E-4; %Static friction
% Friction_static = 0;
Friction_viscous = 8.347E-7; %Viscous friction
Friction_aerodynamic = 8.765E-9; %Aerodynamics friction

% K_pend =0;
% Stepsize= 0.5;
mode_all = ["rotor","pendulum"];
mode = mode_all(2); % Selct different mode to present different task

switch(mode)
    case {'rotor'}
        K_pend =0;  %K_pend=0 for the rotor mode
        Stepsize= 0.5;
        J_pend =J_rotor;  % If this is for the rotor, treat as a special case of pendulum

    case {'pendulum'}
        K_pend = 1;
        Stepsize = 0;  %Stepsize= Angle_Pendu;
end
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

% if mode == "rotor"
%     J_pend = J_rotor;
%     K_g = 0;
% elseif mode == "unstable pendulum"
%     K_g = -K_g;
% end

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
Wn_obs = 1000*2*pi; % Observer Natural Frequency
Tr_ctl = 0.05; % Rise time 0.05
Mp_ctl = 15/100; % Maximum percent overshoot 15%

design_lib = ["SOFC","SOFCI"];
design = design_lib(1);

[L_Pred, K_SF, N, K_int, Loop_SF, SS_closed, TF] = SOFC(G,...
    Ts, Zeta_obs, Wn_obs, Tr_ctl, Mp_ctl, F_rotorred, design); %Get controller gain, observer gain and feedforward gain
% temp = TF(1,1);
% temp = c2d(temp,Ts,'zoh')
L_Pred'
K_SF
TF_yr=TF(1,1)  ;
TF_ur=TF(2,1)  ;
TF_er=TF(3,1)  ;

TF_yd=TF(1,2)  ;
TF_ud=TF(2,2)  ;
TF_ed=TF(3,2)  ;


TF_yw=TF(1,3)  ;
TF_uw=TF(2,3)  ;
TF_ew=TF(3,3)  ;

figure(1)
step(TF_yr)
hold on;
grid on;

plotname = eval(strcat('13',int2str(i)));
% figure(2)
% step(TF_yd,TF_ud)
% legend('TFyd','TFud');
% grid on;

% figure(3)
% bode(TF_yr,TF_ur,TF_yd,TF_ud)
% legend('TFyr','TFur','TFyd','TFud');
% grid on;

%Loop Transfer Function Calculation:
Controller_SF =ss(A_d-B_d*K_SF-L_Pred*C_d,L_Pred,K_SF,0,Ts);
Controller_int =K_int/(z-1)*(1-ss(A_d-B_d*K_SF-L_Pred*C_d,B_d,K_SF,0,Ts));
Controller = Controller_SF+Controller_int;
Loop = Controller*Plant_d;
switch (design)
    case{'SOFC'}
        state_order = size(A_d,1)+size(A_d,1);
    case{'SOFCI'}
        state_order = size(A_d,1)+size(A_d,1)+1;
end
Loop=balred(Loop,state_order);

[Gm,Pm,Wcp,Wcg] = margin(Loop);

figure(4)
subplot(plotname)
nyquist(Loop);
title(strcat(fre(i)," Nyquist"));
grid on

figure(5)
subplot(plotname)
bode(Loop);
title(strcat(fre(i), "Loop Gain"));
grid on


[Gm_SF,Pm_SF,Wcp_SF,Wcg_SF] = margin(Loop_SF);
Sensitivity= 1/(1+Loop);
Sensitivity_SF= 1/(1+Loop_SF);

figure(6);
subplot(plotname)
bodemag(Sensitivity);
title(strcat(fre(i)," Sensitivity"));
% hold on
% bodemag(Sensitivity_SF);
grid on;
% legend('Sensitivity: SF with Obs','Sensitivity: SF Only');
temp{i} = pole(tf(Loop));
end
% steptime = 10;
% stepinput = 1;
% stoptime = 20;
%%
