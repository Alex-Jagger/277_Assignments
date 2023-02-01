% Input:
%   name: name of the response and input timeseries
%   Tss: Sensor sampling time
% Output: 
%   output:
function output = sys_id(data,Tss, input_signal)
time = data{2}.Values.Time;
pos_response = data{2}.Values.Data;
vel_response = data{3}.Values.Data;
input = data{1}.Values.Data;


index_temp = time >= 10;
time = time(index_temp) - 10;
pos_response = pos_response(index_temp);
vel_response = vel_response(index_temp);
input = squeeze(input(index_temp));

pos_iddata= iddata(pos_response, input,Tss);
switch input_signal
    case 'chirp'
        pos_iddata = detrend(pos_iddata);
end
system_pos = tfest(pos_iddata, 2, 0);
kapa_pos = system_pos.Numerator/system_pos.Denominator(2);
tau_pos = 1/system_pos.Denominator(2);

vel_iddata= iddata(vel_response, input,Tss);
switch input_signal
    case 'chirp'
        vel_iddata = detrend(vel_iddata);
        chirp_sys = spafdr(vel_iddata);
end
system_vel = tfest(vel_iddata, 1, 0);
kapa_vel = system_vel.Numerator/system_vel.Denominator(2);
tau_vel = 1/system_vel.Denominator(2);


output = struct('system_pos', system_pos, ...
    'system_vel', system_vel, ...
    'pos_iddata', pos_iddata, ...
    'vel_iddata', vel_iddata, ...
    'kapa_pos', kapa_pos, ...
    'tau_pos', tau_pos, ...
    'kapa_vel', kapa_vel, ...
    'tau_vel', tau_vel);

% curfit
switch input_signal
    case 'step'
        stepsize = max(input);
        F_pos = @(x, xdata) (x(1)*xdata + x(1)*x(2)*exp(-xdata/x(2)) - x(1)*x(2))*stepsize;
        
        x0 = [kapa_pos,tau_pos];
        x = lsqcurvefit(F_pos,x0,time,pos_response);
        kapa_pos_fit = x(1);
        tau_pos_fit = x(2);
        
        F_vel = @(x, xdata) x(1)*(1 - exp(-xdata/x(2)))*stepsize;
        x0 = [kapa_pos,tau_pos];
        x = lsqcurvefit(F_vel,x0,time,vel_response);
        kapa_vel_fit = x(1);
        tau_vel_fit = x(2);
        
        output.kapa_pos_fit=kapa_pos_fit;
        output.tau_pos_fit=tau_pos_fit;
        output.kapa_vel_fit=kapa_vel_fit;
        output.tau_vel_fit=tau_vel_fit;
    otherwise
        output.chirp_sys = chirp_sys;
end


end