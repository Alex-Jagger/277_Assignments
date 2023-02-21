clear; close all; clc
%%
init
%% Our Virtual Plant %Simulation Time = 5s
load_our_parameters
TS =  [0.01,0.001];
fre = ["100 Hz","1000 Hz"];
k = 1;
for i = 1:2
    Ts = TS(i);
    %Parameters in the virtual plant simulation:
    Tcomp=0.0005*Ts*14;  %controller computation delay (less than one sampling interval)
    Tss= 1/10000;       % 10kHz Encoder sampling rate by FPGA
    encoder_resolution= 2*pi/2000;  % Encoder resolution 2000 counts/revolutin
    
    Angle_Pendu=180/180*pi;   %pendulum equlibrium position, 0 is vertically down, 180 is up
    
    K_g =  m*g*l_c;
    K_sin = cos(Angle_Pendu);  %linearization sin(angle)
    
    % Lookup Table for Nonlinear Parameters
    V_table = [-10.57,-10.57,-9.66,-9.04,-0.05,0,0.05,9.04,9.66,10.57,10.57];
    DC_table = [-1,-0.972,-0.96,-0.7,-0.02,0,0.02,0.7,0.96,0.972,1];
    friction_static = 3.93E-4; %Static friction
    friction_viscous = 8.347E-7; %Viscous friction
    friction_aero = 8.765E-9; %Aerodynamics friction
    % V_table = [-10.8,-10.8,-2,-1,-0,0,0,1,2,10.8,10.8];
    % DC_table = [-1,-0.96,-0.1,-0.06,-0.04,0,0.04,0.06,0.1,0.96,1];
    
    Mode_all = ["rotor","pendulum"];
    Mode = Mode_all(2); % Selct different mode to present different task
    
    switch(Mode)
        case {'pendulum'}
            K_pend = 1;
            Stepsize = 0.5;  %Stepsize = Angle_Pendu;
            stepsize = '0_5';
            mode = 'pendulum';
            J_pend = J_rotor + m*l_c^2;
        case {'rotor'}
            K_pend = 0;  %K_pend=0 for the rotor mode
            Stepsize = 0.5;  %Stepsize = Duty Cycle(openloop); Angle(SOFC): 0.5 & 1?;
            stepsize = '0_5';
            mode = 'rotor';
            J_pend =J_rotor;  % If this is for the rotor, treat as a special case of pendulum
    end
    K_tot = K_g*K_sin*K_pend;
    s = tf('s');
    
    % Continuous-time plant model
    
    %Full order motor-rotor model (third order):
    P_rotorfull= (K_m*V_s)/((J_pend*s+b)*(L*s+R)+K_m^2);
    P_rotorposfull= P_rotorfull/s;
    F_rotorfull=(L*s+R)/(K_m*V_s);
    P_penduposfull= P_rotorposfull/(1+K_tot*P_rotorposfull*F_rotorfull); % Full Linear Sys
    
    %Reduced order motor-rotor model for control design (second order, assuming b=0,L=0):
    P_rotorred=kapa/(tau*s+1);
    P_rotorposred=P_rotorred/s;
    F_rotorred=R/(K_m*V_s);
    P_penduposred= P_rotorposred/(1+K_tot*P_rotorposred*F_rotorred);
    
    z = tf('z',Ts); %Create discrete time tf variable
    
    A = [0 1; -K_tot/J_pend -1/tau];
    B = [0; kapa/tau];
    C = [1 0];
    G = ss(A, B, C, 0); % Derive transfer function from the matrix
    G_d= c2d(G,Ts,'zoh'); % Get discrete-time transfer function 
    [A_d, B_d, C_d, ~] = ssdata(G_d);
    Plant = tf(G);
    Plant_d = tf(G_d);
    
    Zeta_obs = 1; % Observer Damping Ratio
    Wn_obs = 100*2*pi; % Observer Natural Frequency
    Tr_ctl = 0.05; % Rise time 0.05
    Mp_ctl = 15/100; % Maximum percent overshoot 15%
    
    design_lib = ["SOFC","SOFCI","SOFCIO"];
    design = design_lib(2);
    plot_libs = ["Without Internal Model","With Integrator Only","With Integrator + Oscillator"];
    plot_lib = plot_libs(2);
    methods = ["LQG","Pole Placement"];
    for j = 1:1
        method = methods(j);
        
        [L_Pred, K_SF, N, K_int, Loop_SF, SS_closed, TF,num,dem,Ad,Bd] = SOFC(G,...
            Ts, Zeta_obs, Wn_obs, Tr_ctl, Mp_ctl, F_rotorred, design,method); %Get controller gain, observer gain and feedforward gain
        
        WeK_aug = [K_SF,K_int];
        TF_yr=TF(1,1)  ;
        TF_ur=TF(2,1)  ;
        TF_er=TF(3,1)  ;
        
        TF_yd=TF(1,2)  ;
        TF_ud=TF(2,2)  ;
        TF_ed=TF(3,2)  ;
        
        TF_yw=TF(1,3)  ;
        TF_uw=TF(2,3)  ;
        TF_ew=TF(3,3)  ;
        
        
        % figure(1)
        % step(TF_yr,TF_ur)
        % legend('TFyr','TFur');
        % grid on;
        % 
        % figure(2)
        % step(TF_yd,TF_ud)
        % legend('TFyd','TFud');
        % grid on;
        % 
        % figure(3)
        % bode(TF_yr,TF_ur,TF_yd,TF_ud)
        % legend('TFyr','TFur','TFyd','TFud');
        % grid on;
        % 
        
        % Loop Transfer Function Calculation:
        Controller_SF =ss(A_d -B_d*K_SF-L_Pred*C_d,L_Pred,K_SF,0,Ts);
        switch design
            case{'SOFC'}
                state_order = size(A_d,1)+size(A_d,1);
                Controller_int = K_int/(z-1)*(1-ss(A_d-B_d*K_SF-L_Pred*C_d,B_d,K_SF,0,Ts));
            case{'SOFCI'}
                Controller_int = K_int/(z-1)*(1-ss(A_d-B_d*K_SF-L_Pred*C_d,B_d,K_SF,0,Ts));
                state_order = size(A_d,1)+size(A_d,1) + 1;
            case{'SOFCIO'}
                osi_d = tf(num,dem,Ts);
%                 osi_d = c2d(osi_c,Ts,'matched');
                Controller_int = osi_d* (1-ss(A_d-B_d*K_SF-L_Pred*C_d,B_d,K_SF,0,Ts));
                state_order = size(A_d,1)+size(A_d,1)+3;
        end
        Controller = Controller_SF+Controller_int;
        Loop = Controller*Plant_d;
        
        Loop=balred(Loop,state_order);
        
        % figure(4)
        % nyquist(Loop, Loop_SF);
        % legend('Loop', 'Loop_{SF}');
        % grid on
        % 
        % figure(5)
        % bode(Loop, Loop_SF);
        % legend('Loop', 'Loop_{SF}');
        % grid on
        % 
        % [Gm,Pm,Wcp,Wcg] = margin(Loop);
        % [Gm_SF,Pm_SF,Wcp_SF,Wcg_SF] = margin(Loop_SF);
        % Sensitivity= 1/(1+Loop);
        % Sensitivity_SF= 1/(1+Loop_SF);
        % 
        % figure(6);
        % bodemag(Sensitivity);
        % hold on
        % bodemag(Sensitivity_SF);
        % grid on;
        % legend('Sensitivity: SF with Obs','Sensitivity: SF Only');
        plotname = eval(strcat('12',int2str(k)));
%         [Gm,Pm,Wcp,Wcg] = margin(Loop);
        
        figure(4)
        subplot(plotname)
        nyquist(Loop);
        title(strcat(fre(i)," Nyquist using ",method," ",plot_lib));
        grid on
        
        figure(5)
        subplot(plotname)
        bode(Loop);
        title(strcat(fre(i), " Loop Gain using ",method," ", plot_lib));
        grid on
        
        
        [Gm_SF,Pm_SF,Wcp_SF,Wcg_SF] = margin(Loop_SF);
        Sensitivity= 1/(1+Loop);
        Sensitivity_SF= 1/(1+Loop_SF);
        
        figure(6);
        subplot(plotname)
        bodemag(Sensitivity);
        title(strcat(fre(i)," Sensitivity using ",method," ",plot_lib));
        % hold on
        % bodemag(Sensitivity_SF);
        grid on;
        % legend('Sensitivity: SF with Obs','Sensitivity: SF Only');
        temp{i} = pole(tf(Loop));
        k = k + 1;
    end
end
%% Simulation


% test = 'openloop'; % Simulation Type
% test = 'SOFC';

% switch(test)
%     case{'openloop'}
%         open('OpenLoop_simulation');
%         out = sim('OpenLoop_simulation');
%         save(['F:\！！！UCLA学习与课程\#####2023 Winter Quarter\' ...
%             '277 - Advanced Digital Control for Mechatronic Systems\' ...
%             '277_Assignment_Charles\277_Assignments\data\our_model_data\our_open_loop\' ...
%             'our_',mode,'_OpenLoop_step_',stepsize,'_response_',num2str(1/Ts),'Hz.mat'],'out')
%     case{'SOFC'}
%         open('SOFC_simulation')
%         out = sim('SOFC_simulation');
%         save(['F:\！！！UCLA学习与课程\#####2023 Winter Quarter\' ...
%             '277 - Advanced Digital Control for Mechatronic Systems\' ...
%             '277_Assignment_Charles\277_Assignments\data\our_model_data\our_SOFC\' ...
%             'our_',mode,'_SOFC_',stepsize,'_response_',num2str(1/Ts),'Hz.mat'],'out')
% end


% steptime = 10;
% stepinput = 1;
% stoptime = 20;
%%
% ref = step_time_response_test2{1}.Values.Data;
% y_m_real = step_time_response_test2{2}.Values.Data;
% y_m_real_ts = step_time_response_test2{2}.Values;
% 
% %%
% tspan = linspace(0, 10, 10001) + 9;
% %%
% figure; hold on; grid on
% plot(tspan, y_m_L, 'LineWidth', 1.5)
% plot(tspan, y_m_NL, 'LineWidth', 1.5)
% plot(step_time_response_test2{2}.Values, 'LineWidth', 1.5)
% xlim([4 18])
% legend('Simulation Linear', 'Simulation Non-Linear','Experiment')