%% System ID
clear; close all; clc
init
load_hardware_parameters;
Tss = encoder_Tss;
%% Test parameter set up

mode = "data_collection";
% mode = "signal_id";
% mode = "analysis";

% Choose a setting for data collection and system id

% input_signal = "step";
% input_signal = "chirp";
% input_signal = "friction";
input_signal = "free"

rod = "_rod_";
% rod = "_nrod_";

% stepsize = 0.3;
% stepsize = 0.4;
% stepsize = 0.5;
% stepsize = 0.6;
stepsize = 0.7;

% chirp_init_freq = 0.001;
% chirp_target_freq = 0.1;

% chirp_init_freq = 0.1;
% chirp_target_freq = 10;

chirp_init_freq = 10;
chirp_target_freq = 100;

run_num = "_2";
%% Prepare for different modes
switch input_signal
    case "step"
        input_signal_type = 1;
        data_file_name = input_signal + rod + erase(num2str(stepsize), '.') + run_num + ".mat"
        switch rod
            case "_rod_"
                time_final = 15;
            otherwise
                time_final = 10.5;
        end
    case "chirp"
        input_signal_type = 2;
        time_final = 50;
        data_file_name = input_signal + rod + erase(num2str(stepsize), '.') + '_' + ...
            erase(num2str(chirp_init_freq), '.') + '_' + erase(num2str(chirp_target_freq), '.') + run_num + ".mat"
    case "friction"
        input_signal_type = 3;
        time_final = 30;
        data_file_name = input_signal +'_'+ erase(num2str(stepsize), '.') + run_num + ".mat";
    case "free"
        input_signal_type = 4;
        time_final = 10000;
        data_file_name = input_signal + run_num + ".mat";        
end
id_file_name = "id_result_" + data_file_name;
%% Start different modes
switch mode
    case "data_collection"
        disp("Run system_id_sim.slx to collect data");
        open("system_id_sim.slx")
    case "signal_id"
        load(data_file_name, 'data');
        output = sys_id(data,Tss, input_signal);
        save("../../data/system_id_data/" + id_file_name, "output");
    case "analysis"
        system_id_analysis
    otherwise
end