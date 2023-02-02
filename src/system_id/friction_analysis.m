
%%
time = data_friction_07_1{2}.Values.Time;
vel_response = data_friction_07_1{2}.Values.Data;

index_temp = time >= 15;
time = time(index_temp) - 15;
vel_response = vel_response(index_temp);
n1 = 1000;
[vel_response, time] = smooth_signal(vel_response, time, n1);

figure; hold on; grid on
plot(time, vel_response)
title('Friction Test, Velocity vs Time')
acc_response = diff(vel_response)/Tss;
time = time(1: end -1);
n2 = 500;
[acc_response, time] = smooth_signal(acc_response, time, n2);
vel_response = vel_response(1:end-n2);

figure
plot(time, acc_response)
title('Friction Test, Velocity vs Acceleration')
torque_response = abs(acc_response)*param.vp.J_rotor;

figure; hold on; grid on
plot(vel_response, torque_response, '.')
title('Friction Test, Torque vs Velocity')

%
function [signal_smooth, time_out] = smooth_signal(signal, time, n)
    signal_smooth = zeros(length(signal) - n + 1, n);
    for ii = 1:n
        signal_smooth(:, ii) = signal(ii:end - n + ii);
    end
    signal_smooth = mean(signal_smooth, 2);
    time_out = time(1:end - n + 1);
end


