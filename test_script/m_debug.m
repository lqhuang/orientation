% index = [2,2,2]

euler_angle = [3,3,3]
theta = euler_angle(1) - 1;
psi = euler_angle(2) - 1;
Phi = euler_angle(3) - 1;
step = 30;

projection = m_projector(EMD_6044_3.object,[theta*step , psi*step , Phi*step ]);
% figure(1);imagesc(projection);
% figure(2);imagesc(projection_cell{3,3,3})
imagesc = projection-projection_cell{3,3,3};
% projection = EMD_6044_3.simulated_projection{index(1),index(2),index(3)};

exp_data = m_create_exp_data(projection, 1)+1;

projection_cell = EMD_6044_3.simulated_projection;

pcimg_method = 'none';
weight = 'none';
subscript = m_corr_method_function(exp_data, projection_cell, pcimg_cell, pcimg_method, weight);

subscript

