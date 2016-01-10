function exp_data = m_create_exp_data(sim_data, SNR)
%   M_CREATE_EXP_DATA Summary of this function goes here
%   simData follows Normal(0, 1)
%   Noise follows Normal(0, SNR)

[numX, numY] = size(sim_data);

exp_data = sim_data + random('norm', 0, sqrt(SNR), numX, numY);
end