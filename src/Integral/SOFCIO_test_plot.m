clear all; close all; clc
%%
addpath("../../data/performance_data/")
addpath("../../data/SOFCIO_test_data/")


lw = 2;
%%
SOFC_PP_step = load("SOFC_PP_step");
timespan = SOFC_PP_step.data.Time;
response = SOFC_PP_step.data.Data;

figure; hold on; grid on
unitstep = 0.4*(timespan>=10);
plot(timespan, unitstep, "LineWidth", lw)

plot(timespan, response, "LineWidth", lw)

SOFC_LQR_step = load("SOFC_LQR_step");
timespan = SOFC_LQR_step.data.Time;
response = SOFC_LQR_step.data.Data;
plot(timespan, response, "LineWidth", lw)


SOFCI_LQR_step = load("SOFCI_LQR_step");
timespan = SOFCI_LQR_step.data.Time;
response = SOFCI_LQR_step.data.Data;
[response, timespan] = smooth_signal(response, timespan, 1000);
plot(timespan, response, "LineWidth", lw)


xlim([9.5 15])
xlabel("Time [sec]")
ylabel("Position [rad]")
legend("Reference", "SOFC Pole Placement", "SOFC LQG", "SOFCI LQG")
%%
lb = 16;
ub = 17;

figure
%%
SOFC_sine = load("sine_wave_pend180_1000.mat");
timespan = SOFC_sine.data{1}.Values.Time;
response = SOFC_sine.data{1}.Values.Data;

temp_index = timespan > lb & timespan < ub;
timespan = timespan(temp_index);
response = response(temp_index);

subplot(3, 1, 1); hold on; grid on;
plot(timespan, response, "LineWidth", lw)

timespan = SOFC_sine.data{2}.Values.Time;
response = SOFC_sine.data{2}.Values.Data;
[response, timespan] = smooth_signal(response, timespan, 500);

temp_index = timespan > lb & timespan < ub;
timespan = timespan(temp_index);
response = response(temp_index);

plot(timespan, response, "LineWidth", lw)

SOFCIO_sine = load("SOFCIO_LQR_sine.mat");
timespan = SOFCIO_sine.data.Time;
response = SOFCIO_sine.data.Data;
[response, timespan] = smooth_signal(response, timespan, 1000);
temp_index = timespan > lb & timespan < ub;
timespan = timespan(temp_index);
response = response(temp_index);

plot(timespan, response, "LineWidth", lw)

xlabel("Time [sec]")
ylabel("Position [rad]")
legend("Reference", "SOFC LQG", "SOFCIO LQG")
%%
SOFC_square = load("square_wave_pend180_1000.mat");
timespan = SOFC_square.data{1}.Values.Time;
response = SOFC_square.data{1}.Values.Data;

temp_index = timespan > lb & timespan < ub;
timespan = timespan(temp_index);
response = response(temp_index);

subplot(3, 1, 2); hold on; grid on;
plot(timespan, response, "LineWidth", lw)

timespan = SOFC_square.data{2}.Values.Time;
response = SOFC_square.data{2}.Values.Data;
[response, timespan] = smooth_signal(response, timespan, 500);

temp_index = timespan > lb & timespan < ub;
timespan = timespan(temp_index);
response = response(temp_index);

plot(timespan, response, "LineWidth", lw)

SOFCIO_square = load("SOFCIO_LQR_square.mat");
timespan = SOFCIO_square.data.Time;
response = SOFCIO_square.data.Data;
[response, timespan] = smooth_signal(response, timespan, 500);
temp_index = timespan > lb & timespan < ub;
timespan = timespan(temp_index);
response = response(temp_index);

plot(timespan, response, "LineWidth", lw)
xlabel("Time [sec]")
ylabel("Position [rad]")
% legend("Reference", "SOFC LQG", "SOFCIO LQG")
%%
SOFC_triangle = load("triangle_wave_pend180_1000.mat");
timespan = SOFC_triangle.data{1}.Values.Time;
response = SOFC_triangle.data{1}.Values.Data;

temp_index = timespan > lb & timespan < ub;
timespan = timespan(temp_index);
response = response(temp_index);

subplot(3, 1, 3); hold on; grid on;
plot(timespan, response, "LineWidth", lw)

timespan = SOFC_triangle.data{2}.Values.Time;
response = SOFC_triangle.data{2}.Values.Data;
[response, timespan] = smooth_signal(response, timespan, 500);

temp_index = timespan > lb & timespan < ub;
timespan = timespan(temp_index);
response = response(temp_index);

plot(timespan, response, "LineWidth", lw)

SOFCIO_triangle = load("SOFCIO_LQR_trig.mat");
timespan = SOFCIO_triangle.data.Time;
response = SOFCIO_triangle.data.Data;
[response, timespan] = smooth_signal(response, timespan, 500);

temp_index = timespan > lb & timespan < ub;
timespan = timespan(temp_index);
response = response(temp_index);

plot(timespan, response, "LineWidth", lw)
xlabel("Time [sec]")
ylabel("Position [rad]")
% legend("Reference", "SOFC LQG", "SOFCIO LQG")