%%
time = data_friction_07_2{2}.Values.Time;
vel_response = data_friction_07_2{2}.Values.Data;

n1 = 2000;
index_temp = time >= 15;
time = time(index_temp) - 15;
vel_response = vel_response(index_temp);
[vel_response, time] = smooth_signal(vel_response, time, n1);
index_temp = vel_response ~= 0;
time = time(index_temp);
vel_response = vel_response(index_temp);

figure
subplot(2, 1, 1); hold on; grid on
plot(time, vel_response, 'LineWidth', 3)
title('Friction Test, Velocity vs Time')
xlabel('Time (sec)')
ylabel('Velocity (rad/s)')
acc_response = diff(vel_response)/Tss;
time = time(1: end -1);
n2 = 500;
[acc_response, time] = smooth_signal(acc_response, time, n2);
vel_response = vel_response(1:end-n2);

% subplot(3, 1, 2); hold on; grid on
% plot(time, acc_response, 'LineWidth', 3)
% title('Friction Test, Acceleration vs Time')
% xlabel('Time (sec)')
% ylabel('Acceleration (rad/sec^{2})')
torque_response = abs(acc_response)*param.vp.J_rotor;

subplot(2, 1, 2); hold on; grid on
plot(vel_response, torque_response, 'LineWidth', 3)
title('Friction Test, Torque vs Velocity')
xlabel('Velocity (rad/s)')
ylabel('Torque (Nm)')

%%
F_friction = @(x, xdata) x(1)+ x(2)*xdata + x(3)*xdata.^2;
x0 = [4, 0, 1];
n_throw = 1;
x = lsqcurvefit(F_friction, x0, vel_response(n_throw:end), torque_response(n_throw:end));
plot(vel_response, F_friction(x, vel_response), "LineWidth", 3)

disp("Static(Coulomb) Friction Coefficient: " + num2str(x(1)))
disp("Viscous Friction Coefficient: " + num2str(x(2)))
disp("Aerodynamic Friction Coefficient: " + num2str(x(3)))
%%
function [signal_smooth, time_out] = smooth_signal(signal, time, n)
    signal_smooth = zeros(length(signal) - n + 1, n);
    for ii = 1:n
        signal_smooth(:, ii) = signal(ii:end - n + ii);
    end
    signal_smooth = mean(signal_smooth, 2);
    time_out = time(1:end - n + 1);
end


