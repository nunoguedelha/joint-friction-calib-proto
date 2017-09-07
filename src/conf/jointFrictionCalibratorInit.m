%====================================================================
% This configuration file defines the main application parameters
%====================================================================

% input parameters
dataPath = '../../data/dumper/';
filename = 'FrictionTest_20170707/Torque_Angler170707.csv';

% Start and end point of data samples
timeStart = 1;  % starting time in capture data file (in seconds)
timeStop  = -1; % ending time in capture data file (in seconds). If -1, use the end time from log
subSamplingSize = 400; % number of samples after sub-sampling the raw data

% Filters
q_filter = struct(...
    'funcH',@sgolayfilt,...
    'type','none',...
    'params',struct('sgolayK',5,'sgolayF',11));
tau_filter = struct(...
    'funcH',@sgolayfilt,...
    'type','sgolay',...
    'params',struct('sgolayK',5,'sgolayF',11));

% Output figures
savePlot   = false;
exportPlot = false;
