clear all; close all; clc
%%
init
addpath(genpath("../../data"))
%%
%%
figure
for ii = 1:2
    subplot(2, 1, ii); hold on; grid on
    Ts_all = [0.001 0.01];
    Ts = Ts_all(ii);
    for jj = 1:2
    mode_all = ["pend0", "pend180"];
    mode = mode_all(jj); % Selct different mode to present different task
    robust_data_file_name = "robust_" + mode + "_" + num2str(1/Ts)
    
    %%
    load(robust_data_file_name)
    time = data.Time;
    response = data.Data;
    
    temp_index = time > 16 & time < 17.9;
    time = time(temp_index);
    response = response(temp_index);
    
    plot(time, response)
    end
load("sine_wave_rotor_" + num2str(1/Ts))
time = data{2}.Values.Time;
response = data{2}.Values.Data;

temp_index = time > 16 & time < 17.9;
time = time(temp_index);
response = response(temp_index);

plot(time, response)
legend("Stable Pendulum " + num2str(1/Ts) + "Hz", "Unstable Pendulum "  + num2str(1/Ts) + "Hz", "Rotor "  + num2str(1/Ts) + "Hz")

xlabel("time [sec]")
ylabel("Position [rad]")
end

