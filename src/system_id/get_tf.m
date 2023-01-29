function [system,kapa,tau] = get_tf(name,Tss)
% Input:
%   input: Input signal
%   response: Response signal
%   Tss: Sensor sampling time
% Output: 
%   sys: Fitted system
%   kapa: System gain
%   tau: System time constant
load(name);
time = data{2}.Values.Time;
response = data{2}.Values.Data;
step = data{1}.Values.Data;

index_temp = time >= 10;
time = time(index_temp);
response = response(index_temp);
step = step(index_temp);
data= iddata(response, step,Tss);
tau_init = 42076.6;
kapa_init = 79.0012;
sys_init = idtf(tau_init, [kapa_init 1 0]);
system = tfest(data, sys_init);
kapa = system.Numerator;
tau = system.Denominator(2);

end