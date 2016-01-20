m_instrument_noise_test
run('/home/lqhuang/Documents/MATLAB/pathdef.m');
addpath(ans)
disp('add path successful!')

step = 10;
file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_fourier_125_125'];
% path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step)];
% run_path = pwd;
% mkdir(path)

particle = m_initial_particle(file, 30.4, step, 'fft');
disp('initial successful!')
save([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
disp('save finish!')
% load([path,'/EMD_6044_',num2str(step),'_fourier.mat'], 'particle');

result_path = '/mnt/data/lqhuang/result/2016-01-20/';

m_create_pcimg;
load([path,'/corr_none_none.mat'], 'pcimg_cell');
disp('pcimg create successful!')

m_instrument_noise_test