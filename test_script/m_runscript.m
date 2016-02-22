run('/home/lqhuang/Documents/MATLAB/pathdef.m');
addpath(ans)
disp('add path successful!')

%% initial a particle
% step = 10;
% file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
% path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_normalized_projector(linear)'];
% % run_path = pwd;
% mkdir(path)
% 
% particle = m_initial_particle(file, 30.4, step, 'real', 'linear');
% disp('initial successful!')
% save([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
% disp('save finish!')
% 
% m_create_pcimg;
% disp('pcimg create successful!')

%% do test 1
step = 10;
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_normalized_projector(linear)'];
result_path = [path,'/result'];
load([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
m_create_pcimg;
% load([path,'/corr_nearest_none.mat'], 'pcimg_cell')
% m_instrument_noise_test
% load([path,'/corr_linear_none.mat'], 'pcimg_cell');
% m_instrument_noise_test
% do test 2
step = 10;
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_unnormalized_projector(linear)'];
load([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
m_create_pcimg;
% load([path,'/corr_nearest_none.mat'], 'pcimg_cell')
% m_instrument_noise_test
% load([path,'/corr_linear_none.mat'], 'pcimg_cell');
% m_instrument_noise_test
