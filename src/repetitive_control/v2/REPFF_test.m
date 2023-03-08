clear all; close all; clc
%%
load_our_parameters
load_hardware_parameters
%%
load("SOFCI_controller.mat")
% load("REPFF_controller.mat")
load("REPFF_system_id_controller.mat")
%%
signal_list = ["sine", "square", "trig"];
signal_num = 2;
signal = signal_list(signal_num);

controller_list = ["SOFCIFF", "SOFCIREP", "SOFCIREPFF"];
controller_num = 2;
controller_type = controller_list(controller_num);

Ts = 0.001;
%%
Stepsize = 0.4;
unit_period = 1;
time_step = 10;
time_final = 20;
%%