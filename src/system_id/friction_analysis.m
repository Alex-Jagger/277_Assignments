load(data_file_name, 'data');

%%
figure
plot(data{2}.Values)
%%
time = data{2}.Values.Time;
vel_response = data{2}.Values.Data;

index_temp1 = time >= 15;
index_temp2 = vel_response ~= 0;
% index_temp3 = index_temp2 & index_temp1;
index_temp3 = index_temp1;
time = time(index_temp3) - 15;
% index_temp4 = 1:14358;
% time = time(index_temp4);
vel_response = vel_response(index_temp3);
% vel_response = vel_response(index_temp4);
figure
plot(time, vel_response)
n = 1000;
vel_response_smooth = zeros(length(vel_response) - n + 1, n);
for ii = 1:n
    vel_response_smooth(:, ii) = vel_response(ii:end - n + ii);
end
vel_response_smooth = mean(vel_response_smooth, 2);
time = time(1:end - n + 1);
figure
plot(time, vel_response_smooth)

acc_response_smooth = diff(vel_response_smooth)/Tss;

n = 500;
acc_response_ssmooth = zeros(length(acc_response_smooth) - n + 1, n);
for ii = 1:n
    acc_response_ssmooth(:, ii) = acc_response_smooth(ii:end - n + ii);
end
acc_response_ssmooth = mean(acc_response_ssmooth, 2);

time = time(1: end - 1);
time = time(1:end - n + 1);
figure
plot(time, acc_response_ssmooth)
figure
plot(vel_response_smooth(1:end-n), abs(acc_response_ssmooth), '.')

% F_friction = @(x, xdata) x(1)*(1 - exp(-xdata/x(2)))*stepsize;
% x0 = [kapa_pos,tau_pos];
% x = lsqcurvefit(F_vel,x0,time,vel_response);
% kapa_vel_fit = x(1);
% tau_vel_fit = x(2);


