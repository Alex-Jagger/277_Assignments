steptime = 10;
stepinput = 1;
stoptime = 20;
%%
% output = sim('../test/norm_sim_test/norm_sim_test.slx');
%%
ref = step_time_response_test2{1}.Values.Data;
y_m_real = step_time_response_test2{2}.Values.Data;
y_m_real_ts = step_time_response_test2{2}.Values;

%%
tspan = linspace(0, 10, 10001) + 9;
%%
figure; hold on; grid on
plot(tspan, y_m_L, 'LineWidth', 1.5)
plot(tspan, y_m_NL, 'LineWidth', 1.5)
plot(step_time_response_test2{2}.Values, 'LineWidth', 1.5)
xlim([4 18])
legend('Simulation Linear', 'Simulation Non-Linear','Experiment')