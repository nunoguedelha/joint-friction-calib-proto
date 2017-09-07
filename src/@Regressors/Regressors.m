classdef Regressors < handle
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static=true)
        [thetaPosVel,thetaNegVel] = normalEquation(x,y);
        
        [xs,ys] = resampleData(thetaPosVel,thetaNegVel,x,nSamples);
    end
    
end
