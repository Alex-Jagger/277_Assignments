%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script reads the data saved from MotorLab project
% Written by Cheng-Wei Chen
% 3-31-2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;

Filename = 'myData.txt';   % Put your filename here

fileID = fopen(Filename,'r');
data = fscanf(fileID,'%f %f %f %f',[4 Inf]);   % Properly modify if you change the format

% Readout the data
t = data(1,:);
r = data(2,:);
y = data(3,:);
u = data(4,:);

%% Plot results
figure;
subplot(2,1,1)
plot(t,r,'g',t,y,'b');
legend('r','y');
xlabel('time [s]');
ylabel('position');

subplot(2,1,2)
plot(t,u,'r');
legend('u');
xlabel('time [s]');
ylabel('duty');
