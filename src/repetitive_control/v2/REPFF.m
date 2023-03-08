clear; close all; clc
%%
% init
%% Our Virtual Plant %Simulation Time = 5s

Ts = 0.001;  %digital control sampling time 0.1/0.01/0.001
load_our_parameters

%Parameters in the virtual plant simulation:
Tcomp=0.0005*Ts*14;  %controller computation delay (less than one sampling interval)
Tss= 1/10000;       % 10kHz Encoder sampling rate by FPGA
encoder_resolution= 2*pi/2000;  % Encoder resolution 2000 counts/revolutin
Angle_Pendu=180/180*pi;   %pendulum equlibrium position, 0 is vertically down, 180 is up
K_g =  m*g*l_c;
K_sin = cos(Angle_Pendu);  %linearization sin(angle)
K_pend = 1;
J_pend = J_rotor + m*l_c^2;

K_tot = K_g*K_sin*K_pend;
s = tf('s');
z = tf('z', Ts);
%%
load("SOFCI_controller.mat")
%%
% TF_yr=TF(1,1)  ;
% 
% % F Block Design 2 (regard 0.9993 as unstable zero)
% F = z*(1-1.849*z^-1+0.8599*z^-2)*(1+0.9993*z)/...
%     (0.0052453*(1+0.9993)^2); % Given by Inverse TF_yr
% 
% N1 = 2;   %F*z^-N1 to be causal
% F = minreal(F*z^-N1);
% F = F / dcgain(F*TF_yr); % Normalization of dagain
% 
% Fzpet_num = F.Numerator{1};
% Fzpet_den = F.Denominator{1}; 
% 
% 
% % Q Block Design
% aa = 1; bb = 2; mm = 1;
% Q = ((aa*z + bb + aa*z^-1)/(bb + 2*aa))^mm;
% Qzpet_num = Q.Numerator{1};
% Qzpet_den = [Q.Denominator{1}(mm+1:end) zeros(1, mm)];
% N2 = mm;   %Q*z^-N2 to be causal
% 
% Np = 1/Ts;
% save("../../../data/REPFF_controller", "Np", "N1", "N2", "Fzpet_num", "Fzpet_den", "Qzpet_num", "Qzpet_den")
%%
TF_yr=TF(1,1)  ;

% F Block Design 2 (regard 0.9993 as unstable zero)
F = z*(1-1.905*z^-1+0.9111*z^-2)*(1+0.9694*z)/...
    (0.0029603*(1+0.9694)^2); % Given by Inverse TF_yr

N1 = 2;   %F*z^-N1 to be causal
F = minreal(F*z^-N1);
F = F / dcgain(F*TF_yr); % Normalization of dagain

Fzpet_num = F.Numerator{1};
Fzpet_den = F.Denominator{1}; 


% Q Block Design
aa = 1; bb = 2; mm = 50;
Q = ((aa*z + bb + aa*z^-1)/(bb + 2*aa))^mm;
Qzpet_num = Q.Numerator{1};
Qzpet_den = [Q.Denominator{1}(mm+1:end) zeros(1, mm)];
Q_coe = Qzpet_num/Q.Denominator{1}(mm+1);
N2 = mm;   %Q*z^-N2 to be causal
Np = 1/Ts;
save("../../../data/REPFF_system_id_controller", "Np", "N1", "N2", "Fzpet_num", "Fzpet_den", "Q_coe", "Qzpet_den", "Qzpet_num")
%%
Stepsize = 0.4;
unit_period = 1;
time_step = 10;
time_final = 20;
%%
signal_list = ["step", "sine", "square", "trig"];
signal_num = 2; % 1: step, 2: Sine, 3: Square
signal = signal_list(signal_num);