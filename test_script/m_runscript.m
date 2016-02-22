run('/home/lqhuang/Documents/MATLAB/pathdef.m');
addpath(ans)
disp('add path successful!')

%% initial a particle
step = 10;
file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_fourier_125_125_unnormalized_projector(linear)'];
% run_path = pwd;
mkdir(path)

particle = m_initial_particle_2(file, 30.4, step, 'fourier', 'linear');
disp('initial successful!')
save([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
disp('save finish!')

m_create_pcimg;
disp('pcimg create successful!')

%% do test 1
% do test 2
step = 10;
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_unnormalized_projector(linear)'];
load([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
load([path,'/corr_linear_none.mat'], 'pcimg_cell');
[accuracy, subscript, num_first_second] = m_instrument_noise_test(particle, space, interpolation, weight, first_num, second_num);
save([path,'result/poission_noise_test(linear_none).mat'], 'accuracy', 'subscript', 'num_first_second');
load([path,'/corr_nearest_none.mat'], 'pcimg_cell');
[accuracy, subscript, num_first_second] = m_instrument_noise_test(particle, space, interpolation, weight, first_num, second_num);
save([path,'result/poission_noise_test(nearest_none).mat'], 'accuracy', 'subscript', 'num_first_second');
