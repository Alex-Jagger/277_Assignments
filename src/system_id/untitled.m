clear all; close all; clc
%%
run("init.m")
Tss = param.encoder.Tss;

id3 = load("id_result_step_3_1_rod.mat");
id4 = load("id_result_step_4_1_rod.mat");
id5 = load("id_result_step_5_1_rod.mat");
id6 = load("id_result_step_6_1_rod.mat");
id7 = load("id_result_step_7_1_rod.mat");

%%
% 
% 1/id3.tau1
% 1/id4.tau1
% 1/id5.tau1
% 1/id6.tau1
% 1/id7.tau1
%%
chirp1 = load("chirp_5_1_rod.mat");
chirp1 = chirp1.data;

time = chirp1{1}.Values.Time;
chirp_input = chirp1{1}.Values.Data;
chirp_response = chirp1{2}.Values.Data;

chirp_iddata = iddata(chirp_response, chirp_input, Tss)
chirp_iddata = detrend(chirp_iddata);
chirp_sys = spafdr(chirp_iddata)