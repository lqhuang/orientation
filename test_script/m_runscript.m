run('/home/lqhuang/Documents/MATLAB/pathdef.m');
addpath(ans)
disp('add path successful!')

%% initial a particle
step = 3;
file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_fourier_125_125_unnormalized_projector_linear'];
run_path = pwd;
mkdir(path)
mypool = parpool(10);

particle = m_initial_particle_2(file, 30.4, step, 'fourier', 'linear');
disp('initial successful!')

save([path,'/EMD6044_3.mat'], 'particle')

m_create_pcimg;
disp('pcimg create successful!')


%% do test 1
% result_path = '/mnt/data/lqhuang/result/2016-03-16';
% mkdir(result_path);
% [accuracy_real, accuracy_fourier, subscript] = m_instrument_noise_test(result_path, subscript);


%% pertubation angle test
step = 3;
% path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_unnormalized_projector_linear'];
result_path = '/mnt/data/lqhuang/result/2016-04-07';
mkdir(result_path);
% load([path,'/EMD_6044_3.mat'], 'particle');
% disp('load successful')
% mypool = parpool(10);
% 
m_pertubation_angle