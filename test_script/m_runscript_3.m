addpath(genpath('../function/'))
disp('add path successful!')

%% do test 1
mypool = parpool(20);
result_path = '/mnt/data/lqhuang/result/2016-11-29';
mkdir(result_path);
m_sigma_noise_test_fourier
m_sigma_noise_test_corr_fourier
m_sigma_noise_test
m_sigma_noise_test_corr

delete(mypool)
clear all

%% initial a particle
% step = 3;
% space = 'fourier';
% file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
% filepath = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_',space,'_125_125_normalized_projector_linear'];
% 
% mkdir(filepath)
% mypool = parpool(20);
% 
% particle = m_initial_particle(file, 30.4, step, 'fourier', 'linear');
% disp('initial successful!')
% 
% save([filepath,'/EMD6044_3.mat'], 'particle')
% 
% m_create_pcimg;
% disp('pcimg create successful!')

% delete(mypool)

exit