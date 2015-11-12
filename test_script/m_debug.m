index = [2,3,8]
exp_projection = EMD_6044_30_noise.exp_projection{index(1),index(2),index(3)};
projection_cell = EMD_6044_30_noise.simulated_projection;

[subscript, Corr, Prob_k] = m_corr_method_function(exp_projection, projection_cell);


subscript