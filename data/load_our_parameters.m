load("kapa_tau_system_id.mat")
load("V_s_system_id.mat")
load("friction_system_id.mat")
% V_s = 10.58
b = 0;                          % Motor-rotor viscous damping
% R = 4.6;                        % (Ohms)Motor coil resistant
R = 3.8;
L = 0.23e-3;                    %(Henry) Motor coil inductance (xxx)
K_m = V_s/kapa ;                %(Nm/A) Motor torque constant

m=4.6e-2;                       %(kg) Mass of pendulum
g=9.812;                        %(m/s^2) Gravitational acceleration
l_c=2.54*1E-2;                  %(m)Distance from pivot joint to the center of pendulum rod
J_rodc=2.36*1E-5;               %(kgm^2) Moment of inertia of pendulum about center of rod

J_rotor = tau/R*K_m^2;          %(kgm^2)Moment of inertia of inertia mode of system
J_motor = J_rotor - J_rodc;


%% Parameters from nonmial model
% %Motor and Pendulum Parameters:
% m=4.4*1E-2;       %(kg) Mass of pendulum
% g=9.812;           %(m/s^2) Gravitational acceleration
% l_c=2.54*1E-2;     %(m)Distance from pivot joint to the center of pendulum rod
% J_rodc=2.16*1E-5;  %(kgm^2) Moment of inertia of pendulum about center of rod
% J_motor=1.67*1E-6; %(kgm^2)  Moment of inertia of motor rotor
% J_rotor=J_rodc+J_motor;   %(kgm^2)Moment of inertia of inertia mode of system
% J_pend=J_rotor+m*l_c^2;   %(kgm^2) Moment of inertia of pendulum mode of system
% 
% b = 0;              % Motor-rotor viscous damping
% R=3.85;             % (Ohms)Motor coil resistant
% L=0.23e-3;          %(Henry) Motor coil inductance
% K_m=2.40E-2 ;       %(Nm/A) Motor torque constant
% V_s=12-0.65*2  ;    %(V)Supply voltage of the motor drive (H-bridge)