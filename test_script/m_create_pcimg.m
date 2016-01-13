% path = '/mnt/data/lqhuang/EMD_6044_3_fourier/';
% particle = ? ;

tic
pcimg_cell = m_initial_particle_pcimg(particle, 'none', 'none');
toc
save([path,'/corr_none_none_mean.mat'], 'pcimg_cell');
disp('OK')

% tic
% pcimg_cell = m_initial_particle_pcimg(particle, 'bilinear', 'none');
% toc
% save([path,'/corr_bilinear_none.mat'], 'pcimg_cell');
% disp('OK')

pcimg_cell = m_initial_particle_pcimg(particle, 'none', 'linear');
save([path,'/corr_none_linear_reverse.mat'], 'pcimg_cell');
disp('OK')

% pcimg_cell = m_initial_particle_pcimg(particle, 'bilinear', 'linear');
% save([path,'/corr_bilinear_linear.mat'], 'pcimg_cell');
% disp('OK')