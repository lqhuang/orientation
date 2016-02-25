run('/home/lqhuang/Documents/MATLAB/pathdef.m');
addpath(ans)
disp('add path successful!')

mypool = parpool(20);

%% initial a particle
% step = 10;
% file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
% path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_fourier_125_125_unnormalized_projector(linear)'];
% run_path = pwd;
% mkdir(path)

% particle = m_initial_particle_2(file, 30.4, step, 'fourier', 'linear');
% disp('initial successful!')
% load([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
% disp('load finish!')

% m_create_pcimg;
% disp('pcimg create successful!')

%% do test 1

[a, b] = m_instrument_noise_test();

