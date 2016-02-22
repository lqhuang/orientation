% path = '/mnt/data/lqhuang/EMD_6044_3_fourier/';
% particle = ? ;

pcimg_cell = m_initial_particle_pcimg(particle, 'nearest', 'none');
save([path,'/corr_nearest_none.mat'], 'pcimg_cell');
disp('OK')

pcimg_cell = m_initial_particle_pcimg(particle, 'nearest', 'linear');
save([path,'/corr_nearest_linear.mat'], 'pcimg_cell');
disp('OK')

% pcimg_cell = m_initial_particle_pcimg(particle, 'linear', 'none');
% save([path,'/corr_linear_none.mat'], 'pcimg_cell');
% disp('OK')
% 
% pcimg_cell = m_initial_particle_pcimg(particle, 'linear', 'linear');
% save([path,'/corr_linear_linear.mat'], 'pcimg_cell');
% disp('OK')