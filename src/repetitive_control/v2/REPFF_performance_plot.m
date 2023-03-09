clear all; close all; clc
%%
load("../../../data/SOFCIREPFF_performance_data/SOFCIREPFF_performance_data.mat")
%%
lw = [1 2 4 0.5];
%% Sine Wave
%
%
%
%
%% 
yd_Sine = data.get("SOFCIREPFF_Sine").get("yd").Values;

y_SOFCIREPFF_Sine = data.get("SOFCIREPFF_Sine").get("y").Values;
y_SOFCIREP_Sine = data.get("SOFCIREP_Sine").get("y").Values;
y_SOFCIFF_Sine = data.get("SOFCIFF_Sine").get("y").Values;
figure; hold on; grid on

plot(y_SOFCIREPFF_Sine, "LineWidth", lw(2))
plot(y_SOFCIREP_Sine, "LineWidth", lw(2))
plot(y_SOFCIFF_Sine, "LineWidth", lw(2))
plot(yd_Sine, "LineWidth", lw(3))

legend(  "SOFCIREPFF", "SOFCIREP", "SOFCIFF", "Reference")
xlim([12 13])
xlabel("Time (s)")
ylabel("Angle (rad)")
%%
error_SOFCIREPFF_Sine = data.get("SOFCIREPFF_Sine").get("error").Values;
error_SOFCIREP_Sine = data.get("SOFCIREP_Sine").get("error").Values;
error_SOFCIFF_Sine = data.get("SOFCIFF_Sine").get("error").Values;
figure; hold on; grid on
plot(error_SOFCIREPFF_Sine, "LineWidth", lw(1))
plot(error_SOFCIREP_Sine, "LineWidth", lw(1))
plot(error_SOFCIFF_Sine, "LineWidth", lw(1))

legend("SOFCIREPFF", "SOFCIREP", "SOFCIFF")
xlim([10 13])
xlabel("Time (s)")
ylabel("Angle (rad)")
%%
disp("Sine Statistics")
disp("Mean")
mean(error_SOFCIREPFF_Sine)
mean(error_SOFCIREP_Sine)
mean(error_SOFCIFF_Sine)
disp("Std")
std(error_SOFCIREPFF_Sine)
std(error_SOFCIREP_Sine)
std(error_SOFCIFF_Sine)
disp("Maximum")
max(abs(error_SOFCIREPFF_Sine.Data))
max(abs(error_SOFCIREP_Sine.Data))
max(abs(error_SOFCIFF_Sine.Data))
%%
u_SOFCIREPFF_Sine = data.get("SOFCIREPFF_Sine").get("u").Values;
u_SOFCIREP_Sine = data.get("SOFCIREP_Sine").get("u").Values;
u_SOFCIFF_Sine = data.get("SOFCIFF_Sine").get("u").Values;
figure; hold on; grid on
plot(u_SOFCIREPFF_Sine, "LineWidth", lw(4))
plot(u_SOFCIREP_Sine, "LineWidth", lw(4))
plot(u_SOFCIFF_Sine, "LineWidth", lw(4))

legend("SOFCIREPFF", "SOFCIREP", "SOFCIFF")
xlim([10 13])
xlabel("Time (s)")
ylabel("Duty Cycle")
%%
disp("Control Effort")
mean(abs(u_SOFCIREPFF_Sine.Data))
mean(abs(u_SOFCIREP_Sine.Data))
mean(abs(u_SOFCIFF_Sine.Data))
%% Square
%
%
%
%%
yd_Square = data.get("SOFCIREPFF_Square").get("yd").Values;
%
y_SOFCIREPFF_Square = data.get("SOFCIREPFF_Square").get("y").Values;
y_SOFCIREP_Square = data.get("SOFCIREP_Square").get("y").Values;
y_SOFCIFF_Square = data.get("SOFCIFF_Square").get("y").Values;
figure; hold on; grid on
plot(y_SOFCIREPFF_Square, "LineWidth", lw(2))
plot(y_SOFCIREP_Square, "LineWidth", lw(2))
plot(y_SOFCIFF_Square, "LineWidth", lw(2))
plot(yd_Square, "LineWidth", lw(3))

legend( "SOFCIREPFF", "SOFCIREP", "SOFCIFF", "Reference")
xlim([12.5 13.5])
xlabel("Time (s)")
ylabel("Angle (rad)")

%%
figure; hold on; grid on
plot(y_SOFCIREPFF_Square, "LineWidth", lw(2))
plot(y_SOFCIREP_Square, "LineWidth", lw(2))
plot(y_SOFCIFF_Square, "LineWidth", lw(2))
plot(yd_Square, "LineWidth", lw(3))

legend( "SOFCIREPFF", "SOFCIREP", "SOFCIFF", "Reference")
xlim([11.9 12.1])
xlabel("Time (s)")
ylabel("Angle (rad)")
%%
error_SOFCIREPFF_Square = data.get("SOFCIREPFF_Square").get("error").Values;
error_SOFCIREP_Square = data.get("SOFCIREP_Square").get("error").Values;
error_SOFCIFF_Square = data.get("SOFCIFF_Square").get("error").Values;
figure; hold on; grid on
plot(error_SOFCIREPFF_Square, "LineWidth", lw(1))
plot(error_SOFCIREP_Square, "LineWidth", lw(1))
plot(error_SOFCIFF_Square, "LineWidth", lw(1))

legend("SOFCIREPFF", "SOFCIREP", "SOFCIFF")
xlim([12.5 13.5])
xlabel("Time (s)")
ylabel("Angle (rad)")
%%
error_SOFCIREPFF_Square = data.get("SOFCIREPFF_Square").get("error").Values;
error_SOFCIREP_Square = data.get("SOFCIREP_Square").get("error").Values;
error_SOFCIFF_Square = data.get("SOFCIFF_Square").get("error").Values;
figure; hold on; grid on
plot(error_SOFCIREPFF_Square, "LineWidth", lw(1))
plot(error_SOFCIREP_Square, "LineWidth", lw(1))
plot(error_SOFCIFF_Square, "LineWidth", lw(1))

legend("SOFCIREPFF", "SOFCIREP", "SOFCIFF")
xlim([12.5 13.5])
ylim([-0.01 0.02])
xlabel("Time (s)")
ylabel("Angle (rad)")
%%
disp("Square Statistics")
disp("Mean")
mean(error_SOFCIREPFF_Square)
mean(error_SOFCIREP_Square)
mean(error_SOFCIFF_Square)
disp("Std")
std(error_SOFCIREPFF_Square)
std(error_SOFCIREP_Square)
std(error_SOFCIFF_Square)
disp("Maximum")
max(abs(error_SOFCIREPFF_Square.Data))
max(abs(error_SOFCIREP_Square.Data))
max(abs(error_SOFCIFF_Square.Data))
%%
u_SOFCIREPFF_Square = data.get("SOFCIREPFF_Square").get("u").Values;
u_SOFCIREP_Square = data.get("SOFCIREP_Square").get("u").Values;
u_SOFCIFF_Square = data.get("SOFCIFF_Square").get("u").Values;
figure; hold on; grid on
plot(u_SOFCIREPFF_Square, "LineWidth", lw(4))
plot(u_SOFCIREP_Square, "LineWidth", lw(4))
plot(u_SOFCIFF_Square, "LineWidth", lw(4))

legend("SOFCIREPFF", "SOFCIREP", "SOFCIFF")
xlim([10 13])
xlabel("Time (s)")
ylabel("Duty Cycle")
%%

disp("Control Effort")

mean(abs(u_SOFCIREPFF_Square.Data))
mean(abs(u_SOFCIREP_Square.Data))
mean(abs(u_SOFCIFF_Square.Data))
%% Triangular
%
%
%
%%
yd_Triangular = data.get("SOFCIREPFF_Triangular").get("yd").Values;
%
y_SOFCIREPFF_Triangular = data.get("SOFCIREPFF_Triangular").get("y").Values;
y_SOFCIREP_Triangular = data.get("SOFCIREP_Triangular").get("y").Values;
y_SOFCIFF_Triangular = data.get("SOFCIFF_Triangular").get("y").Values;
figure; hold on; grid on
plot(y_SOFCIREPFF_Triangular, "LineWidth", lw(2))
plot(y_SOFCIREP_Triangular, "LineWidth", lw(2))
plot(y_SOFCIFF_Triangular, "LineWidth", lw(2))
plot(yd_Triangular, "LineWidth", lw(3))

legend(  "SOFCIREPFF", "SOFCIREP", "SOFCIFF", "Reference")
xlim([12 13])
xlabel("Time (s)")
ylabel("Angle (rad)")

%%
error_SOFCIREPFF_Triangular = data.get("SOFCIREPFF_Triangular").get("error").Values;
error_SOFCIREP_Triangular = data.get("SOFCIREP_Triangular").get("error").Values;
error_SOFCIFF_Triangular = data.get("SOFCIFF_Triangular").get("error").Values;
figure; hold on; grid on
plot(error_SOFCIREPFF_Triangular, "LineWidth", lw(1))
plot(error_SOFCIREP_Triangular, "LineWidth", lw(1))
plot(error_SOFCIFF_Triangular, "LineWidth", lw(1))

legend("SOFCIREPFF", "SOFCIREP", "SOFCIFF")
xlim([10 13])
xlabel("Time (s)")
ylabel("Angle (rad)")
%%
disp("Triangular Statistics")
disp("Mean")
mean(error_SOFCIREPFF_Triangular)
mean(error_SOFCIREP_Triangular)
mean(error_SOFCIFF_Triangular)
disp("Std")
std(error_SOFCIREPFF_Triangular)
std(error_SOFCIREP_Triangular)
std(error_SOFCIFF_Triangular)
disp("Maximum")
max(abs(error_SOFCIREPFF_Triangular.Data))
max(abs(error_SOFCIREP_Triangular.Data))
max(abs(error_SOFCIFF_Triangular.Data))
%%
u_SOFCIREPFF_Triangular = data.get("SOFCIREPFF_Triangular").get("u").Values;
u_SOFCIREP_Triangular = data.get("SOFCIREP_Triangular").get("u").Values;
u_SOFCIFF_Triangular = data.get("SOFCIFF_Triangular").get("u").Values;
figure; hold on; grid on
plot(u_SOFCIREPFF_Triangular, "LineWidth", lw(4))
plot(u_SOFCIREP_Triangular, "LineWidth", lw(4))
plot(u_SOFCIFF_Triangular, "LineWidth", lw(4))

legend("SOFCIREPFF", "SOFCIREP", "SOFCIFF")
xlim([10 13])
xlabel("Time (s)")
ylabel("Duty Cycle")
%%
disp("Control Effort")
mean(abs(u_SOFCIREPFF_Triangular.Data))
mean(abs(u_SOFCIREP_Triangular.Data))
mean(abs(u_SOFCIFF_Triangular.Data))
%%
% FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
% for iFig = 1:length(FigList)
%   FigHandle = FigList(iFig);
%   FigName   = num2str(get(FigHandle, 'Number'));
%   set(0, 'CurrentFigure', FigHandle);
%   saveas(FigHandle, "../../../fig/SOFCIREPFF_test/" + "fig_" + FigName + ".png"); % specify the full path
% end