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

%% Read the sensor data
data = SensorsData(...
    [dataPath filename], subSamplingSize, timeStart, timeStop,...
    q_filter, tau_filter);

% load the data
data.loadData();

%% Plot the data

% define data folder
plotFolder = [dataPath '/diag'];

% Create figures handler
figuresHandler = DiagPlotFiguresHandler(plotFolder);
%Plotter.figuresHandlerMap(task) = figuresHandler;

% raw and filtered q(time)
Plotter.plot2funcTimeseries(...
    figuresHandler,...
    'Joint position q over time','jointPos',...
    data.time,rad2deg(data.raw.q),rad2deg(data.filtered.q),...
    'Joint position (degrees)','raw q','filtered q');

% raw q(time) & dq(time)
Plotter.plotFuncTimeseriesNderivative(...
    figuresHandler,...
    'Raw joint position and velocity over time','jointPosVelRaw',...
    data.time,rad2deg(data.raw.q),0.5,rad2deg(data.raw.dq),...
    'Joint position (degrees)','raw q','[dt,dq]');

% filtered q(time) & dq(time)
Plotter.plotFuncTimeseriesNderivative(...
    figuresHandler,...
    'Filtered joint position and velocity over time','jointPosVelFilt',...
    data.time,rad2deg(data.filtered.q),0.5,rad2deg(data.filtered.dq),...
    'Joint position (degrees)','filtered q','[dt,dq]');

% Tau(time)
Plotter.plot2funcTimeseries(...
    figuresHandler,...
    'Joint torque over time','jointTorq',...
    data.time,data.raw.tau,data.filtered.tau,...
    'Joint torque (N.m)','raw Tau','filtered Tau');


% filtered Tau(time) & dq(time)
Plotter.plot2funcTimeseriesYY(...
    figuresHandler,...
    'Joint velocity and torque over time','jointVelTorqFilt',...
    data.time,rad2deg(data.filtered.dq),data.time,data.filtered.tau,...
    'Joint velocity (degrees/s)','Joint torque');

%% Fit the model and plot

% Fit the model using linear regression in the closed form
% (pseudo-inverse)
[thetaPosVel,thetaNegVel] = Regressors.normalEquationAsym(...
    data.filtered.dq',...
    data.filtered.tau');

% Resample the data for later plotting
[model.dq,model.tau] = Regressors.resampleDataAsym(...
    thetaPosVel,thetaNegVel,...
    data.filtered.dq,...
    1000);

% Compute the mean residual error
% residuals = Regressors.residuals(...
%     thetaPosVel,thetaNegVel,...
%     data.filtered.dq',data.filtered.tau');
% residualError = (residuals'*residuals)/numel(residuals);

% Plot the data and the model
Plotter.plot2dDataNfittedModel(...
    figuresHandler,...
    'Joint velocity to torque model','jointVel2torqModel',...
    rad2deg(data.filtered.dq),data.filtered.tau,...
    rad2deg(model.dq),model.tau,...
    'Joint velocity (degrees/s)','Joint torque (N.m)',...
    'Training data','Model');

%disp(['Residual Error: ' residualError]);

% Save the plots into matlab figure files and eventually export them to PNG
% files.
if savePlot
    % save plots
    [figsFolder,iterator] = figuresHandler.saveFigures(exportPlot);
    % create log info file
    fileID = fopen([figsFolder '.txt'],'w');
    fprintf(fileID,'figs folder = %s\n',[dataPath '/' figsFolder]);
    fprintf(fileID,'iterator = %d\n',iterator);
    %fprintf(fileID,whos);
    fclose(fileID);
end


