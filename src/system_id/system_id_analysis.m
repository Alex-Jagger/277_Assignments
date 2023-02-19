%% Load data
output_step_rod_05_1 = load("id_result_step_rod_05_1.mat");
output_step_rod_05_1 = output_step_rod_05_1.output;
output_step_rod_06_1 = load("id_result_step_rod_06_1.mat");
output_step_rod_06_1 = output_step_rod_06_1.output;
output_step_rod_07_1 = load("id_result_step_rod_07_1.mat");
output_step_rod_07_1 = output_step_rod_07_1.output;
output_step_rod_03_1 = load("id_result_step_rod_03_1.mat");
output_step_rod_03_1 = output_step_rod_03_1.output;
output_step_rod_04_1 = load("id_result_step_rod_04_1.mat");
output_step_rod_04_1 = output_step_rod_04_1.output;

output_chirp_rod_05_01_10_1 = load("id_result_chirp_rod_05_01_10_1.mat");
output_chirp_rod_05_01_10_1 = output_chirp_rod_05_01_10_1.output;
output_chirp_rod_05_10_100_1 = load("id_result_chirp_rod_05_10_100_1.mat");
output_chirp_rod_05_10_100_1 = output_chirp_rod_05_10_100_1.output;
output_chirp_rod_05_0001_01_1 = load("id_result_chirp_rod_05_0001_01_1.mat");
output_chirp_rod_05_0001_01_1 = output_chirp_rod_05_0001_01_1.output;

data_friction_07_2 = load("friction_07_2.mat");
data_friction_07_2 = data_friction_07_2.data;

data_free = load('free_2.mat');
data_free = data_free.data;
%% Calculate the statistics of kappa from different experiments
Kapa_pos = [output_step_rod_03_1.kapa_pos; ...
    output_step_rod_04_1.kapa_pos; ...
    output_step_rod_05_1.kapa_pos; ...
    output_step_rod_06_1.kapa_pos; ...
    output_step_rod_07_1.kapa_pos];

kapa_pos_mean = mean(Kapa_pos);
kapa_pos_std = std(Kapa_pos);
disp("kapa_pos_mean: " + num2str(kapa_pos_mean) + "   kapa_pos_std: " + num2str(kapa_pos_std))

Kapa_pos_fit = [output_step_rod_03_1.kapa_pos_fit; ...
    output_step_rod_04_1.kapa_pos_fit; ...
    output_step_rod_05_1.kapa_pos_fit; ...
    output_step_rod_06_1.kapa_pos_fit; ...
    output_step_rod_07_1.kapa_pos_fit];

kapa_pos_fit_mean = mean(Kapa_pos_fit);
kapa_pos_fit_std = std(Kapa_pos_fit);
disp("kapa_pos_fit_mean: " + num2str(kapa_pos_fit_mean) + "   kapa_pos_fit_std: " + num2str(kapa_pos_fit_std))

Kapa_vel = [output_step_rod_03_1.kapa_vel; ...
    output_step_rod_04_1.kapa_vel; ...
    output_step_rod_05_1.kapa_vel; ...
    output_step_rod_06_1.kapa_vel; ...
    output_step_rod_07_1.kapa_vel];

kapa_vel_mean = mean(Kapa_vel);
kapa_vel_std = std(Kapa_vel);
disp("kapa_vel_mean: " + num2str(kapa_vel_mean) + "   kapa_vel_std: " + num2str(kapa_vel_std))

Kapa_vel_fit = [output_step_rod_03_1.kapa_vel_fit; ...
    output_step_rod_04_1.kapa_vel_fit; ...
    output_step_rod_05_1.kapa_vel_fit; ...
    output_step_rod_06_1.kapa_vel_fit; ...
    output_step_rod_07_1.kapa_vel_fit];

kapa_vel_fit_mean = mean(Kapa_vel_fit);
kapa_vel_fit_std = std(Kapa_vel_fit);
disp("kapa_vel_fit_mean: " + num2str(kapa_vel_fit_mean) + "   kapa_vel_fit_std: " + num2str(kapa_vel_fit_std))
disp(' ')
%% Calculate the statistics of tau from different experiments
Tau_pos = [output_step_rod_03_1.tau_pos; ...
    output_step_rod_04_1.tau_pos; ...
    output_step_rod_05_1.tau_pos; ...
    output_step_rod_06_1.tau_pos; ...
    output_step_rod_07_1.tau_pos];
tau_pos_mean = mean(Tau_pos);
tau_pos_std = std(Tau_pos);
disp("tau_pos_mean: " + num2str(tau_pos_mean) + "   tau_pos_std: " + num2str(tau_pos_std))

Tau_pos_fit = [output_step_rod_03_1.tau_pos_fit; ...
    output_step_rod_04_1.tau_pos_fit; ...
    output_step_rod_05_1.tau_pos_fit; ...
    output_step_rod_06_1.tau_pos_fit; ...
    output_step_rod_07_1.tau_pos_fit];

tau_pos_fit_mean = mean(Tau_pos_fit);
tau_pos_fit_std = std(Tau_pos_fit);
disp("tau_pos_fit_mean: " + num2str(tau_pos_fit_mean) + "   tau_pos_fit_std: " + num2str(tau_pos_fit_std))

Tau_vel = [output_step_rod_03_1.tau_vel; ...
    output_step_rod_04_1.tau_vel; ...
    output_step_rod_05_1.tau_vel; ...
    output_step_rod_06_1.tau_vel; ...
    output_step_rod_07_1.tau_vel];

tau_vel_mean = mean(Tau_vel);
tau_vel_std = std(Tau_vel);
disp("tau_vel_mean: " + num2str(tau_vel_mean) + "   tau_vel_std: " + num2str(tau_vel_std))

Tau_vel_fit = [output_step_rod_03_1.tau_vel_fit; ...
    output_step_rod_04_1.tau_vel_fit; ...
    output_step_rod_05_1.tau_vel_fit; ...
    output_step_rod_06_1.tau_vel_fit; ...
    output_step_rod_07_1.tau_vel_fit];

tau_vel_fit_mean = mean(Tau_vel_fit);
tau_vel_fit_std = std(Tau_vel_fit);
disp("tau_vel_fit_mean: " + num2str(tau_vel_fit_mean) + "   tau_vel_fit_std: " + num2str(tau_vel_fit_std))

%% Plot all calculated kapa
figure
subplot(2, 1, 1); hold on; grid on
freq_list = [0.3 0.4 0.5 0.6 0.7];
% plot(freq_list, Tau_pos, '.', 'MarkerSize', 30)
% 
% plot(freq_list, Tau_pos_fit, '.', 'MarkerSize', 30)
plot(freq_list, Kapa_vel, '.', 'MarkerSize', 30)
plot(freq_list, Kapa_vel_fit, '.', 'MarkerSize', 30)

% plot([0.5 0.5], [output_chirp_rod_05_0001_01_1.kapa_vel, ...
%     output_chirp_rod_05_01_10_1.kapa_vel], '.', 'MarkerSize', 30)

% legend("Position tfest", ...
%     "Position Curve Fit", ...
%     "Velocity tfest", ...
%     "Velocity Curve Fit", ...
%     "Chirp tfest")

legend("Velocity tfest", ...
    "Velocity Curve Fit")
xlabel('Input (Duty Cycle)')
ylabel('\kappa (sec^{-1})')
title('\kappa from Different Methods')
%% Plot all calculated tau
subplot(2, 1, 2); hold on; grid on
freq_list = [0.3 0.4 0.5 0.6 0.7];
% plot(freq_list, Tau_pos, '.', 'MarkerSize', 30)
% 
% plot(freq_list, Tau_pos_fit, '.', 'MarkerSize', 30)
plot(freq_list, Tau_vel, '.', 'MarkerSize', 30)
plot(freq_list, Tau_vel_fit, '.', 'MarkerSize', 30)

% plot([0.5 0.5], [output_chirp_rod_05_0001_01_1.tau_vel, ...
%     output_chirp_rod_05_01_10_1.tau_vel], '.', 'MarkerSize', 30)

% legend("Position tfest", ...
%     "Position Curve Fit", ...
%     "Velocity tfest", ...
%     "Velocity Curve Fit", ...
%     "Chirp tfest")

legend("Velocity tfest", ...
    "Velocity Curve Fit")
xlabel('Input (Duty Cycle)')
ylabel('\tau (sec)')
title('\tau from Different Methods')
%% Calculate our kapa and tau
kapa = kapa_vel_fit_mean;
tau = tau_vel_fit_mean;

save("..\..\data\kapa_tau_system_id", "kapa", "tau");
%% Plot our kapa_model tau_model bode along with chirp responses bode
sys_model = tf(kapa, [tau 1])
figure; hold on; grid on
my_bode = bodeplot(sys_model);

bodeplot(output_chirp_rod_05_0001_01_1.chirp_sys, {0.025*2*pi 0.23*2*pi}) % low freq chirp
bodeplot(output_chirp_rod_05_01_10_1.chirp_sys, {0.23*2*pi 9.03*2*pi}) % mid freq chirp
bodeplot(output_chirp_rod_05_10_100_1.chirp_sys, {9.03*2*pi 100*2*pi}); % high freq chirp
setoptions(my_bode,'FreqUnits','Hz', 'Xlim', [0.025 100], 'Grid', 'on');
legend("System of Our Model", "Plant Low Frequency Response", ...
    "Plant Mid Frequency Response", "Plant High Frequency Response")

title('Frequency Response')
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
lw1 = 2;
lw2 = 3;
LinesAx1(2).LineWidth = lw1;
LinesAx1(3).LineWidth = lw1;   
LinesAx1(4).LineWidth = lw1;                                  % Set 1LineWidth’
LinesAx1(5).LineWidth = lw2;    
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = lw1;                                  % Set 1LineWidth’
LinesAx2(3).LineWidth = lw1;    
LinesAx2(4).LineWidth = lw1;
LinesAx2(5).LineWidth = lw2;       
%% 
figure; hold on; grid on
plot(data_free.dc, data_free.V*1e-3, '.', 'MarkerSize', 20)
title('Duty Cycle vs Armature Voltage')
xlabel('Input (Duty Cycle)')
ylabel('Voltage (V)')
V_s = 1e-3*mean(data_free.V(27:35)./data_free.dc(27:35))
plot(data_free.dc, 12.912*data_free.dc)

save("..\..\data\V_s_system_id", "V_s")
%%
friction_analysis