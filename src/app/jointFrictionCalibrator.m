% Calibrate the friction on a single joint
% - Coulomb and viscuous friction
% - Ktau (PWM to torque) rate
% 

% Add main folders in Matlab path
run generatePaths.m;

%% clear all variables and close all previous figures
clear
close all
clc

%Clear static data
%clear ;

% load application main interface parameters
run jointFrictionCalibratorInit;


