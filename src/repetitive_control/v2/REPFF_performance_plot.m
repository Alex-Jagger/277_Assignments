clear all; close all; clc
%%
load("../../../data/SOFCIREPFF_performance_data/SOFCIREPFF_performance_data.mat")
%%
lw = [1 2 4];
%%
yd_Sine = data.get("SOFCIREPFF_Sine").get("yd").Values;
%
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

% d = designfilt("lowpassiir",FilterOrder=12, ...
%     HalfPowerFrequency=0.1,DesignMethod="butter");
% y = filtfilt(d,error_SOFCIREPFF_Square.Data);
% 
% plot(error_SOFCIREPFF_Square.Time, y, "LineWidth", lw(1))

legend("SOFCIREPFF", "SOFCIREP", "SOFCIFF")
xlim([12.5 13.5])
ylim([-0.01 0.02])
xlabel("Time (s)")
ylabel("Angle (rad)")
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
% FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
% for iFig = 1:length(FigList)
%   FigHandle = FigList(iFig);
%   FigName   = num2str(get(FigHandle, 'Number'));
%   set(0, 'CurrentFigure', FigHandle);
%   saveas(FigHandle, "../../../fig/SOFCIREPFF_test/" + "fig_" + FigName + ".png"); % specify the full path
% end