function exp_data = m_create_exp_data(sim_data, t)
%   M_CREATE_EXP_DATA Summary of this function goes here
%   Detailed explanation goes here

[sx, sy] = size(sim_data);

exp_data = random('norm', sim_data, sqrt(t.*sim_data), sx, sy);
% exp_data = exp_data - min(min(exp_data)) + 1; % make every elements greater than zero

end