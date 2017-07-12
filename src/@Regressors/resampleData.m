function [ xs,ys ] = resampleData(theta,x,nSamples);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% resample x evenly over its respective limits
xs = linspace(min(x),max(x),nSamples)';
% format X adding the column of ones
Xs = [ones(size(xs,1),1) xs];

ys = Xs*theta;

end

