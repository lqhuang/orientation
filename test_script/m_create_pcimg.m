path = '/mnt/data/lqhuang/EMD_6044_3_fourier_125_125_unnormalized_projector_linear/';
% particle = ? ;
load([path,'/EMD_6044_3.mat'], 'particle');

% pcimg_cell = m_initial_particle_pcimg(particle, 'nearest', 'none');
% save([path,'/corr_nearest_none.mat'], 'pcimg_cell');
% disp('OK')
% 
% pcimg_cell = m_initial_particle_pcimg(particle, 'nearest', 'linear');
% save([path,'/corr_nearest_linear.mat'], 'pcimg_cell');
% disp('OK')

pcimg_cell = m_initial_particle_pcimg(particle, 'linear', 'linear');
save([path,'/corr_linear_linear.mat'], 'pcimg_cell');
disp('OK')
clear pcimg_cell

pcimg_cell = m_initial_particle_pcimg(particle, 'linear', 'none');
save([path,'/corr_linear_none.mat'], 'pcimg_cell');
disp('OK')

