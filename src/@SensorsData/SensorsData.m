classdef SensorsData < handle
    % A SensorsData class object holds all the data capture and sensors parameters
    % like:
    % - data start and end timestamps
    % - number of samples
    % - data capture file path
    
    properties (Access=public)
        path         ;
        nSamples  = 0; %number of samples
        tInit     = 0;    %seconds to be skipped at the start
        tEnd      = 0;    %seconds to reach the end of the movement
        filtParams;
    end
    
    methods
        function obj = SensorsData(dataPath, nSamples, tInit, tEnd, filtParams)
            if isempty(filtParams)
                filtParams.type = 'sgolay';
                filtParams.sgolayK = 5;
                filtParams.sgolayF = 601;
            end
            obj.filtParams = filtParams;
            % main input parameters
            obj.path = dataPath;
            obj.nSamples = nSamples;
            obj.tInit = tInit;
            obj.tEnd = tEnd;
        end
        
        loadData(obj);
    end
    
    methods (Static=true, Access=protected)
        [rawData,q,tau,time] = readAngle2torque(filename);
    end
end
