% path = '/mnt/data/lqhuang/EMD_6044_3_fourier/';
% particle = ? ;

tic
pcimg_cell = m_initial_particle_pcimg(particle, 'linear', 'none');
toc
save([path,'/corr_linear_none.mat'], 'pcimg_cell');
disp('OK')

pcimg_cell = m_initial_particle_pcimg(particle, 'linear', 'linear');
save([path,'/corr_linear_linear.mat'], 'pcimg_cell');
disp('OK')