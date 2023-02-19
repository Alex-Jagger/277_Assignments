% 277 Assignment Repository Initialization
%
% This file should always be run the first when doing any thing with the
% repository
%%
clear; close all; clc

%% Add paths
addpath(genpath(pwd), ...
    genpath("..\lib"), ...
    genpath("..\test"), ...
    genpath("..\data"))
% savepath
%%
load_hardware_parameters
