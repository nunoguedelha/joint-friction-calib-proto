classdef SensorsData < handle
    % A SensorsData class object holds all the data capture and sensors parameters
    % like:
    % - data start and end timestamps
    % - number of samples
    % - data capture file path
    
    properties (Constant=true, Access=protected)
        dfltFilter = struct(...
            'funcH',@sgolayfilt,...
            'type','sgolay',...
            'params',struct('sgolayK',5,'sgolayF',201));
        numDeriv = @(x,time) SensorsData.firstOrderDeriv(x,time);
    end
    
    properties (Access=public)
        path         ;
        nSamples  = 0; %number of samples
        tInit     = 0;    %seconds to be skipped at the start
        tEnd      = 0;    %seconds to reach the end of the movement
        q_filter  = SensorsData.dfltFilter;
        tau_filter= SensorsData.dfltFilter;
        time         ;
        raw          ;
        filtered     ;
    end
    
    methods
        function obj = SensorsData(dataPath, nSamples, tInit, tEnd, q_filter, tau_filter)
            if ~isempty(q_filter)
                obj.q_filter = q_filter;
            end
            if ~isempty(tau_filter)
                obj.tau_filter = tau_filter;
            end
            
            % main input parameters
            obj.path = dataPath;
            obj.nSamples = nSamples;
            obj.tInit = tInit;
            obj.tEnd = tEnd;
        end
        
        loadData(obj);
    end
    
    methods (Static=true, Access=public)
        dx = firstOrderDeriv(x,time);
    end
    
    methods (Static=true, Access=protected)
        [rawData,q,tau,time] = readAngle2torque(filename);
    end
end
