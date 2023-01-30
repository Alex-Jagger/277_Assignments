% Input:
%   name: name of the response and input timeseries
%   Tss: Sensor sampling time
% Output: 
%   sys: Fitted system
%   kapa: System gain
%   tau: System time constant
function [system_pos, system_vel, pos_iddata, vel_iddata, kapa_pos, tau_pos, kapa_vel, tau_vel] = sys_id2(name,Tss)
load(name, "data")
time = data{2}.Values.Time;
pos = data{2}.Values.Data;
vel = data{3}.Values.Data;
step_input = data{1}.Values.Data;

index_temp = time >= 10;
pos = pos(index_temp);
vel = vel(index_temp);
step_input = step_input(index_temp);

pos_iddata= iddata(pos, step_input,Tss);

system_pos = tfest(pos_iddata, 2, 0);
kapa_pos = system_pos.Numerator/system_pos.Denominator(2);
tau_pos = 1/system_pos.Denominator(2);

vel_iddata= iddata(vel, step_input,Tss);

system_vel = tfest(vel_iddata, 1, 0);
kapa_vel = system_vel.Numerator/system_vel.Denominator(2);
tau_vel = 1/system_vel.Denominator(2);

end