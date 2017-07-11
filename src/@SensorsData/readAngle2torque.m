function [rawData,q,tau,time] = readAngle2torque(filename)

% header and data formats
headerFormat = '%*s;%*s';
dataFormat = '%f;RI,%f,%f,%f;%*s';

% file descriptor
fid = fopen(filename);

% parse file into an array of cells. As all file lines (L lines) have the same
% format, textscan parses the j_th matched elements of every line into one
% single cell data(1,j) = matrix(Lx1).

% Get the header for further verification of the format
header = textscan(fid, headerFormat);

% Get the measurements
dataC = textscan(fid, dataFormat);

% 2nd column is defined as C{1,2} and will be a column vector of
% timestamps.
time = dataC{1,1};
q   = cell2mat(dataC(1,2)); % joint angles
tau = cell2mat(dataC(1,3)); % joint torques

[tu,iu] = unique(time);
time    = tu';
q       = q(iu, :)';
tau     = tau(iu, :)';

if fclose(fid) == -1
   error('[ERROR] there was a problem in closing the file')
end
