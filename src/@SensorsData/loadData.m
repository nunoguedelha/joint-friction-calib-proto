function loadData(obj)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

% read the file:
% q (rad), tau (Nm), offset (unknown)
[raw.q,raw.tau,raw.offset,time] = obj.readAngle2torque(obj.path);

% compute joint velocity numerically. Duplicate last value.
raw.dq = obj.numDeriv(raw.q,time);

% filter the data
q_params = struct2cell(obj.q_filter.params);
filtered.q = obj.q_filter.funcH(raw.q,q_params{:});
tau_params = struct2cell(obj.tau_filter.params);
filtered.tau = obj.tau_filter.funcH(raw.tau,tau_params{:});

% compute joint velocity numerically. Duplicate last value.
filtered.dq = obj.numDeriv(filtered.q,time);

% save parsed parameters
obj.time = time;
obj.raw  = raw;
obj.filtered = filtered;

end
