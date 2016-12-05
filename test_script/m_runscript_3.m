addpath(genpath('../function/'))
disp('add path successful!')

%% initial a particle
step = 10;
space = 'fourier';
file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
filepath = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_',space,'_125_125_normalized_projector_linear'];

mkdir(filepath)
mypool = parpool(15);

particle = m_initial_particle_normalize(file, 30.4, step, 'fourier', 'linear');
disp('initial successful!')

save([filepath,'/EMD6044_', num2str(step),'.mat'], 'particle')

m_create_pcimg;
disp('pcimg create successful!')


%% do test 1
result_path = '/mnt/data/lqhuang/result/2016-12-05';
mkdir(result_path);
tic
m_sigma_noise_test_corr_fourier
sod_time = toc;
tic
m_sigma_noise_test_fourier
ml_time = toc;
save([result_path, '/time.mat'], 'sod_time', 'ml_time')
% m_sigma_noise_test
% m_sigma_noise_test_corr

delete(mypool)
clear all

exit