clear all;
close all;
clc
%%
init
addpath(genpath("../../data"))
%%
wave_name = ["sine","triangle","square"];
plant_name = ["rotor","pend0","pend180"];
color = ["-r","--r","-b"];
fre = [100,1000];
lb = 16;
ub = 16.9;
%%
fig_count = 1;
for i = 1:3
    for j = 1:3
%         subplot_id = eval(strcat(num2str(9),num2str(i),num2str(j)));
        subplot_id = eval(strcat(num2str(33),num2str(fig_count)));
        subplot(subplot_id)
        for k = 1:2
            data_name = wave_name(j) + "_wave_" + plant_name(i) + "_" + num2str(fre(k)) + ".mat";
            data = load(data_name);
            Time = data.data{2}.Values.Time;
            index_l = Time>=lb;
            index_u = Time<= ub;
            index = index_l & index_u;
            Time = Time(index);
            Value = data.data{2}.Values.Data;
            Value = Value(index);
%             figure(fig_count)
            plot(Time,Value,color(k),'LineWidth',1.5);
            hold on;
            grid on;
        end
        reference_time = data.data{1}.Values.Time;
        reference_data = data.data{1}.Values.Data;
        index_l = reference_time>=lb;
        index_u = reference_time<= ub;
        index = index_l & index_u;
        reference_time = reference_time(index);
        reference_data = reference_data(index);
        fig_count = fig_count + 1;
        plot(reference_time,reference_data,color(3),'LineWidth',1.5);
        xlabel('Time(s)');
        ylabel('Output(rad)');
        legend('100Hz','1000Hz','Reference');
        temp = " Rotor";
        if plant_name(i) == "pend0"
            temp = " Stable Pendulum";
        elseif plant_name(i) == "pend180"
                temp = " Unstable Pendulum";
        end
        title_ = strcat(wave_name(j),' wave for ',temp,' model');
        title(title_) 
    end

end
%% Difference
color = ["-r","-b"];
figure
fig_count = 1;
for i = 1:3
    for j = 1:3
%         subplot_id = eval(strcat(num2str(9),num2str(i),num2str(j)));
        subplot_id = eval(strcat(num2str(33),num2str(fig_count)));
        subplot(subplot_id)



        for k = 1:2
            data_name = wave_name(j) + "_wave_" + plant_name(i) + "_" + num2str(fre(k)) + ".mat";
            data = load(data_name);

            reference_time = data.data{1}.Values.Time;
            reference_data = data.data{1}.Values.Data;
            index_l = reference_time>=lb;
            index_u = reference_time<= ub;
            index = index_l & index_u;
            reference_time = reference_time(index);
            reference_data = reference_data(index);

            Time = data.data{2}.Values.Time;
            index_l = Time>=lb;
            index_u = Time<= ub;
            index = index_l & index_u;
            Time = Time(index);
            Value = data.data{2}.Values.Data;
            Value = Value(index);
%             figure(fig_count)
            new_reference_data = interp1(reference_time,reference_data,Time);
            plot(Time,abs(Value - new_reference_data),color(k),'LineWidth',1.5);
% plot(Time, new_reference_data)
            hold on;
            grid on;
        end

        fig_count = fig_count + 1;

        xlabel('Time(s)');
        ylabel('Output(rad)');
        legend('100Hz','1000Hz');
        temp = " Rotor";
        if plant_name(i) == "pend0"
            temp = " Stable Pendulum";
        elseif plant_name(i) == "pend180"
                temp = " Unstable Pendulum";
        end
        title_ = strcat(wave_name(j),' wave error for ',temp,' model');
        title(title_) 
    end

end