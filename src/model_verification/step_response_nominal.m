% clear; close all; clc
%%
% run('init.m')
%% Nominal Virtual Plant

Ts = 0.001;  %digital control sampling time 0.1/0.01/0.001

%Motor and Pendulum Parameters:
m=4.4*1E-2;       %(kg) Mass of pendulum
g=9.812;           %(m/s^2) Gravitational acceleration
l_c=2.54*1E-2;     %(m)Distance from pivot joint to the center of pendulum rod
J_rodc=2.16*1E-5;  %(kgm^2) Moment of inertia of pendulum about center of rod
J_motor=1.67*1E-6; %(kgm^2)  Moment of inertia of motor rotor
J_rotor=J_rodc+J_motor;   %(kgm^2)Moment of inertia of inertia mode of system
J_pend=J_rotor+m*l_c^2;   %(kgm^2) Moment of inertia of pendulum mode of system

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

% Lookup Table for Nonlinear Parameters
V_table = [-10.8,-10.8,-2,-1,-0,0,0,1,2,10.8,10.8];
DC_table = [-1,-0.96,-0.1,-0.06,-0.04,0,0.04,0.06,0.1,0.96,1];
% Friction_static = 4E-4; %Static friction Nm
friction_static = 3.93E-4; %Static friction
friction_viscous = 0; %Viscous friction
friction_aero = 0; %Aerodynamics friction
Mode_all = ["rotor","pendulum"];
Mode = Mode_all(1); % Selct different mode to present different task

switch(Mode)
    case {'pendulum'}
        K_pend = 1;
        Stepsize = 0.5;  %Stepsize= Angle_Pendu;
        stepsize = '0_5';
        mode = 'pendulum';
        
    case {'rotor'}
        K_pend =0;  %K_pend=0 for the rotor mode
        Stepsize= 0.5; %Stepsize = Duty Cycle: 0.5
        stepsize = '0_5';
        mode = 'rotor';
        J_pend =J_rotor;  % If this is for the rotor, treat as a special case of pendulum
end
K_tot = K_g*K_sin*K_pend;
s = tf('s');

% Continuous-time plant model

%Full order motor-rotor model (third order):
P_rotorfull= (K_m*V_s)/((J_pend*s+b)*(L*s+R)+K_m^2);
P_rotorposfull= P_rotorfull/s;
F_rotorfull=(L*s+R)/(K_m*V_s);
P_penduposfull= P_rotorposfull/(1+K_tot*P_rotorposfull*F_rotorfull);

%Reduced order motor-rotor model for control design (second order, assuming b=0,L=0):
kapa=V_s/K_m;
tau=J_pend*R/K_m^2;
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
Tr_ctl = 0.05; % Rise time is changed to 0.1 (originally 0.05)
Mp_ctl = 15/100; % Maximum percent overshoot 15%

design_lib = ["SOFC","SOFCI"];
design = design_lib(1);

[L_Pred, K_SF, N, K_int, Loop_SF, SS_closed, TF] = SOFC(G,...
    Ts, Zeta_obs, Wn_obs, Tr_ctl, Mp_ctl, F_rotorred, design); %Get controller gain, observer gain and feedforward gain

TF_yr=TF(1,1)  ;
TF_ur=TF(2,1)  ;
TF_er=TF(3,1)  ;

TF_yd=TF(1,2)  ;
TF_ud=TF(2,2)  ;
TF_ed=TF(3,2)  ;

TF_yw=TF(1,3)  ;
TF_uw=TF(2,3)  ;
TF_ew=TF(3,3)  ;

% figure(1)
% step(TF_yr,TF_ur)
% legend('TFyr','TFur');
% grid on;
% 
% figure(2)
% step(TF_yd,TF_ud)
% legend('TFyd','TFud');
% grid on;
% 
% figure(3)
% bode(TF_yr,TF_ur,TF_yd,TF_ud)
% legend('TFyr','TFur','TFyd','TFud');
% grid on;
% 
% %Loop Transfer Function Calculation:
% Controller_SF =ss(A_d-B_d*K_SF-L_Pred*C_d,L_Pred,K_SF,0,Ts);
% Controller_int =K_int/(z-1)*(1-ss(A_d-B_d*K_SF-L_Pred*C_d,B_d,K_SF,0,Ts));
% Controller = Controller_SF+Controller_int;
% Loop = Controller*Plant_d;
% 
% switch (design)
%     case{'SOFC'}
%         state_order = size(A_d,1)+size(A_d,1);
%     case{'SOFCI'}
%         state_order = size(A_d,1)+size(A_d,1)+1;
% end
% Loop=balred(Loop,state_order);
% 
% figure(4)
% nyquist(Loop, Loop_SF);
% legend('Loop', 'Loop_{SF}');
% grid on
% 
% figure(5)
% bode(Loop, Loop_SF);
% legend('Loop', 'Loop_{SF}');
% grid on
% 
% [Gm,Pm,Wcp,Wcg] = margin(Loop);
% [Gm_SF,Pm_SF,Wcp_SF,Wcg_SF] = margin(Loop_SF);
% Sensitivity= 1/(1+Loop);
% Sensitivity_SF= 1/(1+Loop_SF);
% 
% figure(6);
% bodemag(Sensitivity);
% hold on
% bodemag(Sensitivity_SF);
% grid on;
% legend('Sensitivity: SF with Obs','Sensitivity: SF Only');

%% Simulation

% test = 'SOFC';
% test = 'openloop'; % Simulation Type
% 
% switch(test)
%     case{'openloop'}
%         open('OpenLoop_simulation');
%         out = sim('OpenLoop_simulation');
%         save(['F:\！！！UCLA学习与课程\#####2023 Winter Quarter\' ...
%             '277 - Advanced Digital Control for Mechatronic Systems\' ...
%             '277_Assignment_Charles\277_Assignments\data\nominal_model_data\nominal_open_loop\' ...
%             'nominal_',mode,'_OpenLoop_step_',stepsize,'_response_',num2str(1/Ts),'Hz.mat'],'out')
%     case{'SOFC'}
%         open('SOFC_simulation')
%         out = sim('SOFC_simulation');
%         save(['F:\！！！UCLA学习与课程\#####2023 Winter Quarter\' ...
%             '277 - Advanced Digital Control for Mechatronic Systems\' ...
%             '277_Assignment_Charles\277_Assignments\data\nominal_model_data\nominal_SOFC\' ...
%             'nominal_',mode,'_SOFC_',stepsize,'_response_',num2str(1/Ts),'Hz.mat'],'out')
% end

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