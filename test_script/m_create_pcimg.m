
tic
pcimg_cell = m_initial_particle_pcimg(EMD_6044_3, 'none', 'none');
toc
save /mnt/data/lqhuang/Corr_none_none.mat pcimg_cell
disp('OK')

tic
pcimg_cell = m_initial_particle_pcimg(EMD_6044_3, 'bilinear', 'none');
toc
save /mnt/data/lqhuang/Corr_bilinear_none.mat pcimg_cell
disp('OK')

pcimg_cell = m_initial_particle_pcimg(EMD_6044_3, 'none', 'linear');
save /mnt/data/lqhuang/Corr_none_linear.mat pcimg_cell
disp('OK')

pcimg_cell = m_initial_particle_pcimg(EMD_6044_3, 'bilinear', 'linear');
save /mnt/data/lqhuang/Corr_bilinear_linear.mat pcimg_cell
disp('OK')