% filepath = '/mnt/data/lqhuang/EMD_6044_3_fourier_125_125_normalized_projector_linear/';
% particle = ? ;
% load([filepath,'/EMD_6044_3.mat'], 'particle');

% pcimg_cell = m_initial_particle_pcimg(particle, 'nearest', 'none');
% save([filepath,'/corr_nearest_none.mat'], 'pcimg_cell');
% disp('OK')
% 
% pcimg_cell = m_initial_particle_pcimg(particle, 'nearest', 'linear');
% save([filepath,'/corr_nearest_linear.mat'], 'pcimg_cell');
% disp('OK')

pcimg_cell = m_initial_particle_pcimg(particle, 'linear', 'linear');
save([filepath,'/corr_linear_linear.mat'], 'pcimg_cell');
disp('OK')
clear pcimg_cell

pcimg_cell = m_initial_particle_pcimg(particle, 'linear', 'none');
save([filepath,'/corr_linear_none.mat'], 'pcimg_cell');
disp('OK')

