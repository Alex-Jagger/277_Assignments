%
% Input:
%   G: Continuous plant ss
%   Ts: Sampling time
%   Zeta_obs: Desired damping ratio for the observer
%   Wn_obs: Desired natural frequency for the observer
%   Tr_ctl: Desired rise time for the controller
%   Mp_ctl: Desired maximum percent overshoot
% Output:
%   L_Pred: Observer gain
%   K_SF: Control gain
%   opt: Optional outputs
function [L_Pred, K_SF, N, opt] = SOFC(G, Ts, Zeta_obs, Wn_obs, Tr_ctl, Mp_ctl)

G_d = c2d(G, Ts, 'zoh');
[A_d, B_d, C_d, ~] = ssdata(G_d);
pole_s_obs = [(-Zeta_obs + sqrt(Zeta_obs^2-1))*Wn_obs,...
    (-Zeta_obs-sqrt(Zeta_obs^2-1))*Wn_obs];
pole_z_obs = exp(pole_s_obs*Ts);
L_Pred = acker(A_d',C_d',pole_z_obs)';

Wn_ctl = 1.8/Tr_ctl; %rad/sec
tmp = (log(Mp_ctl)/pi)^2;
Zeta_ctl = sqrt(tmp/(1+tmp));
pole_s_ctl = [(-Zeta_ctl + sqrt(Zeta_ctl^2-1))*Wn_ctl,...
    (-Zeta_ctl-sqrt(Zeta_ctl^2-1))*Wn_ctl];
pole_z_ctl = exp(pole_s_ctl*Ts);
K_SF = acker(A_d,B_d,pole_z_ctl);

TF_yrf=ss(A_d-B_d*K_SF,B_d,C_d,[],Ts);
N=1/freqresp(TF_yrf,0);   %Scale the feedforward gain N to make dc gain y/r=1
            
opt.pole_s_obs = pole_s_obs;
opt.pole_s_ctl = pole_s_ctl;
end