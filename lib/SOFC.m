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
function [L_Pred, K_SF, N, K_int, Loop_SF, SS_closed, TF] = SOFC(G,...
    Ts, Zeta_obs, Wn_obs, Tr_ctl, Mp_ctl, F_rotorred, design)

G_d = c2d(G, Ts, 'zoh');
[A_d, B_d, C_d, ~] = ssdata(G_d);
Bw = F_rotorred*B_d;

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

switch(design)
    case{'SOFC'}
        K_SF = acker(A_d,B_d,pole_z_ctl);
        K_int = 0;
        TF_yrf=ss(A_d-B_d*K_SF,B_d,C_d,[],Ts);
        N=1/freqresp(TF_yrf,0);   %Scale the feedforward gain N to make dc gain y/r=1
        AA= [A_d-B_d*K_SF, B_d*K_SF; zeros(size(A_d)), A_d-L_Pred*C_d];
        BB= [B_d*N, B_d, Bw; zeros(size(B_d)), B_d, Bw];
        CC= [C_d, zeros(size(C_d)); -K_SF, K_SF; -C_d, zeros(size(C_d))];
        DD= [0 0 0; N 0 0;1, 0 0];
        Loop_SF =ss(A_d,B_d,K_SF,0,Ts);

    case{'SOFCI'}
        Aaug=[A_d zeros(size(B_d)); C_d 1];
        Baug=[B_d;0];
        gamma = 0.9;    %0<gamma<1 to select integrator pole faster than SF pole
        pole_int = gamma*max(abs(pole_z_ctl));
        pole_z_ctl_int= [pole_z_ctl, pole_int];
        K_aug=acker(Aaug,Baug,pole_z_ctl_int);
        K_SF=K_aug(1:size(A_d,1));
        K_int = K_aug(size(A_d,1)+1:size(K_aug,2));
                
        TF_yrf=ss(A_d-B_d*K_SF,B_d,C_d,0,Ts);
        N=1/freqresp(TF_yrf,0);  % With integra action, N does not affect steady state, but on transient response
                
        AA= [A_d-B_d*K_SF, -B_d*K_int,  B_d*K_SF; C_d, 1, zeros(size(C_d)); zeros(size(A_d)), zeros(size(B_d)), A_d-L_Pred*C_d];
        BB= [B_d*N, B_d, Bw;-1., 0, 0; zeros(size(B_d)), B_d, Bw];
        CC= [C_d, 0, zeros(size(C_d)); -K_SF, -K_int, K_SF; -C_d, 0, zeros(size(C_d))];
        DD= [0 0 0; N 0 0;1, 0 0];
                
        Loop_SF = ss(Aaug,Baug,K_aug,0,Ts);    

end

SS_closed = ss(AA,BB,CC,DD);
[NUM,DEN] = tfdata(SS_closed,'v');
TF=tf(NUM,DEN,Ts);

% opt.pole_s_obs = pole_s_obs;
% opt.pole_s_ctl = pole_s_ctl;
end