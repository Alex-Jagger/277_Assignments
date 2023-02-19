clear; close all; clc
%%
% Add paths
% addpath(pwd, ...
%     genpath(".\our_model_data"), ...
%     genpath(".\nominal_model_data"),...
%     genpath(".\real_model_data"))
% savepath
addpath(genpath("..\..\data"))
init
% Load data
our_rotor_op_step_05_1000hz = load("our_rotor_OpenLoop_step_0_5_response_1000Hz.mat");
our_rotor_op_step_05_1000hz = our_rotor_op_step_05_1000hz.out;

nominal_rotor_op_step_05_1000hz = load("nominal_rotor_OpenLoop_step_0_5_response_1000Hz");
nominal_rotor_op_step_05_1000hz = nominal_rotor_op_step_05_1000hz.out;

our_rotor_sofc_step_05_10hz = load("our_rotor_SOFC_0_5_response_10Hz");
our_rotor_sofc_step_05_10hz = our_rotor_sofc_step_05_10hz.out;
our_rotor_sofc_step_05_100hz = load("our_rotor_SOFC_0_5_response_100Hz");
our_rotor_sofc_step_05_100hz = our_rotor_sofc_step_05_100hz.out;
our_rotor_sofc_step_05_1000hz = load("our_rotor_SOFC_0_5_response_1000Hz");
our_rotor_sofc_step_05_1000hz = our_rotor_sofc_step_05_1000hz.out;

our_pend0_sofc_step_05_10hz = load("our_pendulum_0_SOFC_0_5_response_10Hz");
our_pend0_sofc_step_05_10hz = our_pend0_sofc_step_05_10hz.out;
our_pend0_sofc_step_05_100hz = load("our_pendulum_0_SOFC_0_5_response_100Hz");
our_pend0_sofc_step_05_100hz = our_pend0_sofc_step_05_100hz.out;
our_pend0_sofc_step_05_1000hz = load("our_pendulum_0_SOFC_0_5_response_1000Hz");
our_pend0_sofc_step_05_1000hz = our_pend0_sofc_step_05_1000hz.out;

our_pend180_sofc_step_05_10hz = load("our_pendulum_180_SOFC_0_5_response_10Hz");
our_pend180_sofc_step_05_10hz = our_pend180_sofc_step_05_10hz.out;
our_pend180_sofc_step_05_100hz = load("our_pendulum_180_SOFC_0_5_response_100Hz");
our_pend180_sofc_step_05_100hz = our_pend180_sofc_step_05_100hz.out;
our_pend180_sofc_step_05_1000hz = load("our_pendulum_180_SOFC_0_5_response_1000Hz");
our_pend180_sofc_step_05_1000hz = our_pend180_sofc_step_05_1000hz.out;

nominal_rotor_sofc_step_05_10hz = load("nominal_rotor_SOFC_0_5_response_10Hz");
nominal_rotor_sofc_step_05_10hz = nominal_rotor_sofc_step_05_10hz.out;
nominal_rotor_sofc_step_05_100hz = load("nominal_rotor_SOFC_0_5_response_100Hz");
nominal_rotor_sofc_step_05_100hz = nominal_rotor_sofc_step_05_100hz.out;
nominal_rotor_sofc_step_05_1000hz = load("nominal_rotor_SOFC_0_5_response_1000Hz");
nominal_rotor_sofc_step_05_1000hz = nominal_rotor_sofc_step_05_1000hz.out;

nominal_pend0_sofc_step_05_10hz = load("nominal_pendulum_0_SOFC_0_5_response_10Hz");
nominal_pend0_sofc_step_05_10hz = nominal_pend0_sofc_step_05_10hz.out;
nominal_pend0_sofc_step_05_100hz = load("nominal_pendulum_0_SOFC_0_5_response_100Hz");
nominal_pend0_sofc_step_05_100hz = nominal_pend0_sofc_step_05_100hz.out;
nominal_pend0_sofc_step_05_1000hz = load("nominal_pendulum_0_SOFC_0_5_response_1000Hz");
nominal_pend0_sofc_step_05_1000hz = nominal_pend0_sofc_step_05_1000hz.out;

nominal_pend180_sofc_step_05_10hz = load("nominal_pendulum_180_SOFC_0_5_response_10Hz");
nominal_pend180_sofc_step_05_10hz = nominal_pend180_sofc_step_05_10hz.out;
nominal_pend180_sofc_step_05_100hz = load("nominal_pendulum_180_SOFC_0_5_response_100Hz");
nominal_pend180_sofc_step_05_100hz = nominal_pend180_sofc_step_05_100hz.out;
nominal_pend180_sofc_step_05_1000hz = load("nominal_pendulum_180_SOFC_0_5_response_1000Hz");
nominal_pend180_sofc_step_05_1000hz = nominal_pend180_sofc_step_05_1000hz.out;

%%% load Experiment Data
real_rotor_sofc_step_05_10hz = load("real_rotor_SOFC_0_5_response_10Hz");
real_rotor_sofc_step_05_10hz = real_rotor_sofc_step_05_10hz.data;
real_rotor_sofc_step_05_100hz = load("real_rotor_SOFC_0_5_response_100Hz");
real_rotor_sofc_step_05_100hz = real_rotor_sofc_step_05_100hz.data;
real_rotor_sofc_step_05_1000hz = load("real_rotor_SOFC_0_5_response_1000Hz");
real_rotor_sofc_step_05_1000hz = real_rotor_sofc_step_05_1000hz.data;

real_pend0_sofc_step_05_10hz = load("real_pendulum_0_SOFC_0_5_response_10Hz");
real_pend0_sofc_step_05_10hz = real_pend0_sofc_step_05_10hz.data;
real_pend0_sofc_step_05_100hz = load("real_pendulum_0_SOFC_0_5_response_100Hz");
real_pend0_sofc_step_05_100hz = real_pend0_sofc_step_05_100hz.data;
real_pend0_sofc_step_05_1000hz = load("real_pendulum_0_SOFC_0_5_response_1000Hz");
real_pend0_sofc_step_05_1000hz = real_pend0_sofc_step_05_1000hz.data;

real_pend180_sofc_step_05_10hz = load("real_pendulum_180_SOFC_0_5_response_10Hz");
real_pend180_sofc_step_05_10hz = real_pend180_sofc_step_05_10hz.data;
real_pend180_sofc_step_05_100hz = load("real_pendulum_180_SOFC_0_5_response_100Hz");
real_pend180_sofc_step_05_100hz = real_pend180_sofc_step_05_100hz.data;
real_pend180_sofc_step_05_1000hz = load("real_pendulum_180_SOFC_0_5_response_1000Hz");
real_pend180_sofc_step_05_1000hz = real_pend180_sofc_step_05_1000hz.data;

real_rotor_op_step_05_1000hz = load("real_rotor_OpenLoop_step_0_5_response");
real_rotor_op_step_05_1000hz = real_rotor_op_step_05_1000hz.data;

%%%%%%%%%%
t10 = linspace(0,5,51);
t100 = linspace(0,5,501);
t1000 = linspace(0,5,5001);

figure(1)
hold on; grid on;
plot(t1000,nominal_rotor_op_step_05_1000hz.w_L,'-r','LineWidth',1.5)
plot(t1000,nominal_rotor_op_step_05_1000hz.w_NL,'--r','LineWidth',1.5)
plot(t1000,our_rotor_op_step_05_1000hz.w_L,'-b','LineWidth',1.5)
plot(t1000,our_rotor_op_step_05_1000hz.w_NL,'--b','LineWidth',1.5)

index = find(real_rotor_op_step_05_1000hz.vel);
index = index(1);
t_tmp = real_rotor_op_step_05_1000hz.time(index:end) - real_rotor_op_step_05_1000hz.time(index) + 1; % Step @ T = 1
p_tmp = real_rotor_op_step_05_1000hz.vel(index:end);
plot(t_tmp,p_tmp,'-m','LineWidth',1.5)

legend('Nominal_{L}','Nominal_{NL}','Our_{L}','Our_{NL}','Real','Location','best') % ,'Experiment'
xlabel('Time (s)')
xlim([0,5])
ylabel('Velocity (rad/s)')
title('Rotor Openloop Performance')

figure(2)
sgtitle('Rotor Configuration SOFC') % subplot grid title
subplot(1,3,1)
hold on; grid on;
ref = 0.5*(ones(1,length(t10)));
plot(t10,ref,'--k','LineWidth',1.5)
plot(t10,nominal_rotor_sofc_step_05_10hz.y_L,'-r','LineWidth',1.5)
plot(t10,nominal_rotor_sofc_step_05_10hz.y_NL,'--r','LineWidth',1.5)
plot(t10,our_rotor_sofc_step_05_10hz.y_L,'-b','LineWidth',1.5)
plot(t10,our_rotor_sofc_step_05_10hz.y_NL,'--b','LineWidth',1.5)

index = find(real_rotor_sofc_step_05_10hz.Data);
index = index(1);
t_tmp = real_rotor_sofc_step_05_10hz.Time(index:end) - real_rotor_sofc_step_05_10hz.Time(index) + 1;
p_tmp = real_rotor_sofc_step_05_10hz.Data(index:end);
plot(t_tmp,p_tmp,'-m','LineWidth',1.5)

legend('Reference','Nominal_{L}','Nominal_{NL}','Our_{L}','Our_{NL}','Real','Location','best') % ,'Experiment'
xlabel('Time (s)')
xlim([0,5])
ylabel('Position (rad)')
title('10Hz')

subplot(1,3,2)
hold on; grid on;
ref = 0.5*(ones(1,length(t100)));
plot(t100,ref,'--k','LineWidth',1.5)
plot(t100,nominal_rotor_sofc_step_05_100hz.y_L,'-r','LineWidth',1.5)
plot(t100,nominal_rotor_sofc_step_05_100hz.y_NL,'--r','LineWidth',1.5)
plot(t100,our_rotor_sofc_step_05_100hz.y_L,'-b','LineWidth',1.5)
plot(t100,our_rotor_sofc_step_05_100hz.y_NL,'--b','LineWidth',1.5)

index = find(real_rotor_sofc_step_05_100hz.Data);
index = index(1);
t_tmp = real_rotor_sofc_step_05_100hz.Time(index:end) - real_rotor_sofc_step_05_100hz.Time(index) + 1;
p_tmp = real_rotor_sofc_step_05_100hz.Data(index:end);
plot(t_tmp,p_tmp,'-m','LineWidth',1.5)

legend('Reference','Nominal_{L}','Nominal_{NL}','Our_{L}','Our_{NL}','Real','Location','best') % ,'Experiment'
xlabel('Time (s)')
xlim([0,5])
ylabel('Position (rad)')
title('100Hz')

subplot(1,3,3)
hold on; grid on;
ref = 0.5*(ones(1,length(t1000)));
plot(t1000,ref,'--k','LineWidth',1.5)
plot(t1000,nominal_rotor_sofc_step_05_1000hz.y_L,'-r','LineWidth',1.5)
plot(t1000,nominal_rotor_sofc_step_05_1000hz.y_NL,'--r','LineWidth',1.5)
plot(t1000,our_rotor_sofc_step_05_1000hz.y_L,'-b','LineWidth',1.5)
plot(t1000,our_rotor_sofc_step_05_1000hz.y_NL,'--b','LineWidth',1.5)

index = find(real_rotor_sofc_step_05_1000hz.Data);
index = index(1);
t_tmp = real_rotor_sofc_step_05_1000hz.Time(index:end) - real_rotor_sofc_step_05_1000hz.Time(index) + 1;
p_tmp = real_rotor_sofc_step_05_1000hz.Data(index:end);
plot(t_tmp,p_tmp,'-m','LineWidth',1.5)

legend('Reference','Nominal_{L}','Nominal_{NL}','Our_{L}','Our_{NL}','Real','Location','best') % ,'Experiment'
xlabel('Time (s)')
xlim([0,5])
ylabel('Position (rad)')
title('1000Hz')


figure(3)
sgtitle('Stable Pendulum Configuration SOFC') % subplot grid title
subplot(1,3,1)
hold on; grid on;
ref = 0.5*(ones(1,length(t10)));
plot(t10,ref,'--k','LineWidth',1.5)
plot(t10,nominal_pend0_sofc_step_05_10hz.y_L,'-r','LineWidth',1.5)
plot(t10,nominal_pend0_sofc_step_05_10hz.y_NL,'--r','LineWidth',1.5)
plot(t10,our_pend0_sofc_step_05_10hz.y_L,'-b','LineWidth',1.5)
plot(t10,our_pend0_sofc_step_05_10hz.y_NL,'--b','LineWidth',1.5)

index = find(real_pend0_sofc_step_05_10hz.Data);
index = index(1);
t_tmp = real_pend0_sofc_step_05_10hz.Time(index:end) - real_pend0_sofc_step_05_10hz.Time(index) + 1;
p_tmp = real_pend0_sofc_step_05_10hz.Data(index:end);
plot(t_tmp,p_tmp,'-m','LineWidth',1.5)

legend('Reference','Nominal_{L}','Nominal_{NL}','Our_{L}','Our_{NL}','Real','Location','best') % ,'Experiment'
xlabel('Time (s)')
xlim([0,5])
ylabel('Position (rad)')
title('10Hz')

subplot(1,3,2)
hold on; grid on;
ref = 0.5*(ones(1,length(t100)));
plot(t100,ref,'--k','LineWidth',1.5)
plot(t100,nominal_pend0_sofc_step_05_100hz.y_L,'-r','LineWidth',1.5)
plot(t100,nominal_pend0_sofc_step_05_100hz.y_NL,'--r','LineWidth',1.5)
plot(t100,our_pend0_sofc_step_05_100hz.y_L,'-b','LineWidth',1.5)
plot(t100,our_pend0_sofc_step_05_100hz.y_NL,'--b','LineWidth',1.5)

index = find(real_pend0_sofc_step_05_100hz{2}.Values.Data);
index = index(1);
t_tmp = real_pend0_sofc_step_05_100hz{2}.Values.Time(index:end) -...
real_pend0_sofc_step_05_100hz{2}.Values.Time(index) + 1;
p_tmp = real_pend0_sofc_step_05_100hz{2}.Values.Data(index:end);
plot(t_tmp,p_tmp,'-m','LineWidth',1.5)

legend('Reference','Nominal_{L}','Nominal_{NL}','Our_{L}','Our_{NL}','Real','Location','best') % ,'Experiment'
xlabel('Time (s)')
xlim([0,5])
ylabel('Position (rad)')
title('100Hz')

subplot(1,3,3)
hold on; grid on;
ref = 0.5*(ones(1,length(t1000)));
plot(t1000,ref,'--k','LineWidth',1.5)
plot(t1000,nominal_pend0_sofc_step_05_1000hz.y_L,'-r','LineWidth',1.5)
plot(t1000,nominal_pend0_sofc_step_05_1000hz.y_NL,'--r','LineWidth',1.5)
plot(t1000,our_pend0_sofc_step_05_1000hz.y_L,'-b','LineWidth',1.5)
plot(t1000,our_pend0_sofc_step_05_1000hz.y_NL,'--b','LineWidth',1.5)

index = find(real_pend0_sofc_step_05_1000hz.Data);
index = index(1);
t_tmp = real_pend0_sofc_step_05_1000hz.Time(index:end) - real_pend0_sofc_step_05_1000hz.Time(index) + 1;
p_tmp = real_pend0_sofc_step_05_1000hz.Data(index:end);
plot(t_tmp,p_tmp,'-m','LineWidth',1.5)

legend('Reference','Nominal_{L}','Nominal_{NL}','Our_{L}','Our_{NL}','Real','Location','best') % ,'Experiment'
xlabel('Time (s)')
xlim([0,5])
ylabel('Position (rad)')
title('1000Hz')


figure(4)
sgtitle('Unstable Pendulum Configuration SOFC') % subplot grid title
subplot(1,3,1)
hold on; grid on;
ref = 0.5*(ones(1,length(t10)));
plot(t10,ref,'--k','LineWidth',1.5)
plot(t10,nominal_pend180_sofc_step_05_10hz.y_L,'-r','LineWidth',1.5)
plot(t10,nominal_pend180_sofc_step_05_10hz.y_NL,'--r','LineWidth',1.5)
plot(t10,our_pend180_sofc_step_05_10hz.y_L,'-b','LineWidth',1.5)
plot(t10,our_pend180_sofc_step_05_10hz.y_NL,'--b','LineWidth',1.5)

index = find(real_pend180_sofc_step_05_10hz.Data);
index = index(1);
t_tmp = real_pend180_sofc_step_05_10hz.Time(index:end) - real_pend180_sofc_step_05_10hz.Time(index) + 1;
p_tmp = real_pend180_sofc_step_05_10hz.Data(index:end);
plot(t_tmp,p_tmp,'-m','LineWidth',1.5)

legend('Reference','Nominal_{L}','Nominal_{NL}','Our_{L}','Our_{NL}','Real','Location','best') % ,'Experiment'
xlabel('Time (s)')
xlim([0,5])
ylabel('Position (rad)')
title('10Hz')

subplot(1,3,2)
hold on; grid on;
ref = 0.5*(ones(1,length(t100)));
plot(t100,ref,'--k','LineWidth',1.5)
plot(t100,nominal_pend180_sofc_step_05_100hz.y_L,'-r','LineWidth',1.5)
plot(t100,nominal_pend180_sofc_step_05_100hz.y_NL,'--r','LineWidth',1.5)
plot(t100,our_pend180_sofc_step_05_100hz.y_L,'-b','LineWidth',1.5)
plot(t100,our_pend180_sofc_step_05_100hz.y_NL,'--b','LineWidth',1.5)

index = find(real_pend180_sofc_step_05_100hz.Data);
index = index(1);
t_tmp = real_pend180_sofc_step_05_100hz.Time(index:end) - real_pend180_sofc_step_05_100hz.Time(index) + 1;
p_tmp = real_pend180_sofc_step_05_100hz.Data(index:end);
plot(t_tmp,p_tmp,'-m','LineWidth',1.5)

legend('Reference','Nominal_{L}','Nominal_{NL}','Our_{L}','Our_{NL}','Real','Location','best')% ,'Experiment'
xlabel('Time (s)')
xlim([0,5])
ylabel('Position (rad)')
title('100Hz')

subplot(1,3,3)
hold on; grid on;
ref = 0.5*(ones(1,length(t1000)));
plot(t1000,ref,'--k','LineWidth',1.5)
plot(t1000,nominal_pend180_sofc_step_05_1000hz.y_L,'-r','LineWidth',1.5)
plot(t1000,nominal_pend180_sofc_step_05_1000hz.y_NL,'--r','LineWidth',1.5)
plot(t1000,our_pend180_sofc_step_05_1000hz.y_L,'-b','LineWidth',1.5)
plot(t1000,our_pend180_sofc_step_05_1000hz.y_NL,'--b','LineWidth',1.5)

index = find(real_pend180_sofc_step_05_1000hz.Data);
index = index(1);
t_tmp = real_pend180_sofc_step_05_1000hz.Time(index:end) - real_pend180_sofc_step_05_1000hz.Time(index) + 1;
p_tmp = real_pend180_sofc_step_05_1000hz.Data(index:end);
plot(t_tmp,p_tmp,'-m','LineWidth',1.5)

legend('Reference','Nominal_{L}','Nominal_{NL}','Our_{L}','Our_{NL}','Real','Location','best') % ,'Experiment'
xlabel('Time (s)')
xlim([0,5])
ylabel('Position (rad)')
title('1000Hz')








