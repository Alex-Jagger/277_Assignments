% Input:
%   name: name of the response and input timeseries
%   Tss: Sensor sampling time
% Output: 
%   sys: Fitted system
%   kapa: System gain
%   tau: System time constant
function [system, my_iddata, kapa,tau] = sys_id(name,Tss)
load(name, "data")
time = data{2}.Values.Time;
response = data{2}.Values.Data;
step = data{1}.Values.Data;

index_temp = time >= 10;
response = response(index_temp);
step = step(index_temp);
my_iddata= iddata(response, step,Tss);
tau_init = 2;
kapa_init = 500;
sys_init = idtf(kapa_init, [tau_init 1 0]);
system = tfest(my_iddata, 2, 0);
kapa = system.Numerator/system.Denominator(2);
tau = 1/system.Denominator(2);
end