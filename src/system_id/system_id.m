% System ID
%%
clear; close all; clc
%%
run('init.m')
Tss = param.encoder.Tss;

time_final = 15;

input_signal = "step";
stepsize = 0.5;

chirp_init_freq = 0.001;
chirp_target_freq = 10;

rod = "rod";
run = "_2_";
name1 = input_signal + "_" + num2str(stepsize*10) + run + rod + ".mat";
name2 = "id_result_" + name1;
%%
% mode = "data_collection";
mode = "analysis";
% mode = "chirp";
switch mode
    case "data_collection"
    [system_pos, system_vel, pos_iddata, vel_iddata, kapa_pos, tau_pos, kapa_vel, tau_vel] = sys_id2(name1,Tss);
    save(name2, "system_pos", "system_vel", "pos_iddata", "vel_iddata", "kapa_pos", "tau_pos", "kapa_vel", "tau_vel")
    case "analysis"
    load(name1)
    load(name2)
    time = data{2}.Values.Time;
    response = data{2}.Values.Data;
    
    switch rod
        case "rod"
            index_temp = time >= 10;
        otherwise
            index_temp = time >= 10 & time < 10.15;
    end
    response = response(index_temp);
    time = time(index_temp) - 10;
    
    figure
    plot(time, response)
    %%
    F = @(x,xdata) (x(1)*xdata + x(1)*x(2)*exp(-xdata/x(2)) - x(1)*x(2))*stepsize;
    
    x0 = [kapa_pos,tau_pos];
    x = lsqcurvefit(F,x0,time,response)
    %%
    hold on
    plot(time, F(x, time))
    plot(time, F([kapa_pos tau_pos], time))
    plot(time, F([kapa_vel tau_vel], time))
    legend
    
    kapa1 = x(1);
    tau1 = x(2);
    save(name2, "kapa1", "tau1", '-append');
    case "chirp"
        chirp1 = load(name1);
        chirp1 = chirp1.data;
        
        chirp_input = squeeze(chirp1{1}.Values.Data);
        %%
%         chirp_input = squeeze(chirp_input);
        chirp_response = chirp1{2}.Values.Data;
        chirp_vel = chirp1{3}.Values.Data;

        chirp_iddata = iddata(chirp_vel, chirp_input, Tss);
        chirp_iddata = detrend(chirp_iddata);
        chirp_sys = spafdr(chirp_iddata);
        figure; hold on
        h = bodeplot(chirp_sys);
        setoptions(h,'FreqUnits','Hz');
        id5 = load("id_result_step_5_1_rod.mat");
        s = tf('s');
        id_sys = id5.kapa1/(id5.tau1*s+ 1);
        bodeplot(id_sys)

        chirp2 = load("chirp_5_5_rod.mat");
        chirp2 = chirp2.data;
        
        chirp2_input = squeeze(chirp2{1}.Values.Data);

        chirp2_response = chirp2{2}.Values.Data;
        chirp2_vel = chirp2{3}.Values.Data;

        chirp2_iddata = iddata(chirp2_vel, chirp2_input, Tss);
        chirp2_iddata = detrend(chirp2_iddata);
        chirp2_sys = spafdr(chirp2_iddata);  
        bodeplot(chirp2_sys);

        chirp3 = load("chirp_5_4_rod.mat");
        chirp3 = chirp3.data;
        
        chirp3_input = squeeze(chirp3{1}.Values.Data);

        chirp3_response = chirp3{2}.Values.Data;
        chirp3_vel = chirp3{3}.Values.Data;

        chirp3_iddata = iddata(chirp3_vel, chirp3_input, Tss);
        chirp3_iddata = detrend(chirp3_iddata);
        chirp3_sys = spafdr(chirp3_iddata);  
        bodeplot(chirp3_sys);        
        legend
        %%
%         Y = fft(chirp_response);
%         L = length(chirp_response);
%         P2 = abs(Y/L);
%         P1 = P2(1:L/2+1);
%         P1(2:end-1) = 2*P1(2:end-1);
%         f = 1/Tss*(0:(L/2))/L;
%         figure
%         semilogx(f,db(P1)) 
%         title("Single-Sided Amplitude Spectrum of X(t)")
%         xlabel("f (Hz)")
%         ylabel("|P1(f)|")
%         %%
%         figure
%         semilogx(f, rad2deg(angle(Y(1:L/2+1))))
end