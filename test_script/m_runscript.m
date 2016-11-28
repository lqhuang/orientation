addpath(genpath('../function'))
disp('add path successful!')

%% initial a particle
% step = 3;
% space = 'real';
% file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
% filepath = ['/vol7/home/lqhuang/Data/lqhuang/EMD_6044_',num2str(step),'_',space,'_125_125_unnormalized_projector_linear'];

% mkdir(filepath)
% mypool = parpool(10);

% particle = m_initial_particle_2(file, 30.4, step, 'fourier', 'linear');
% disp('initial successful!')

% save([filepath,'/EMD6044_3.mat'], 'particle')

% m_create_pcimg;
% disp('pcimg create successful!')


%% do test 1
mypool = parpool(10);
% result_path = '/vol7/home/lqhuang/Data/lqhuang/result/2016-05-12-1'
result_path = '/mnt/data/lqhuang/result/2016-05-12-1'
mkdir(result_path);
[accuracy_real, accuracy_fourier, subscript] = m_instrument_noise_test(result_path);


%% pertubation angle test
% result_path = '/mnt/data/lqhuang/result/2016-04-19';
% mkdir(result_path);
% angle_range = [0, 0.5, 1, 1.5, 2, 2.5, 3];
% 
% m_pertubation_angle
