run('/home/lqhuang/Documents/MATLAB/pathdef.m')
addpath(ans)
disp('add path successful!')

file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
path = '/mnt/data/lqhuang/EMD_6044_3_fourier/';
% EMD_6044_3_fft = m_initial_particle(file, 30.4, 3, 'fft');
% save([path,'EMD_6044_3_fourier.mat'], 'EMD_6044_3_fft');
% disp('save finish!')

load = ([path,'EMD_6044_3_fourier.mat'], 'EMD_6044_3_fft');
particle = EMD_6044_3_fft;
clear EMD_6044_3_fft

m_create_pcimg;
disp('pcimg create successful!')

m_sigma_noise_test.m
disp('noise_test finish!')

m_pertubation_angle;
disp('pertubation_angle test finish!');

disp('successful!')