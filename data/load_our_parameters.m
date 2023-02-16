load("kapa_tau_system_id.mat")
load("V_s_system_id.mat")
load("friction_system_id.mat")
% V_s = 10.58
b = 0;                          % Motor-rotor viscous damping
R = 4.6;                        % (Ohms)Motor coil resistant
L = 0.23e-3;                    %(Henry) Motor coil inductance (xxx)
K_m = V_s/kapa ;                %(Nm/A) Motor torque constant

m=4.6e-2;                       %(kg) Mass of pendulum
g=9.812;                        %(m/s^2) Gravitational acceleration
l_c=2.54*1E-2;                  %(m)Distance from pivot joint to the center of pendulum rod
J_rodc=2.36*1E-5;               %(kgm^2) Moment of inertia of pendulum about center of rod

J_rotor = tau/R*K_m^2;          %(kgm^2)Moment of inertia of inertia mode of system
J_motor = J_rotor - J_rodc;