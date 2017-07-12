classdef Regressors < handle
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static=true)
        [theta] = normalEquation(x,y);
        
        [xs,ys] = resampleData(theta,x,nSamples);
    end
    
end

