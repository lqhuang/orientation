run('/home/lqhuang/Documents/MATLAB/pathdef.m');
addpath(ans)
disp('add path successful!')

step = 10;
file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_unnormalized_projector(linear)'];
% run_path = pwd;
mkdir(path)

particle = m_initial_particle_2(file, 30.4, step, 'real', 'linear');
disp('initial successful!')
save([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
disp('save finish!')

m_create_pcimg;
disp('pcimg create successful!')

step = 10;
file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_unnormalized_projector(cubic)'];
% run_path = pwd;
mkdir(path)

particle = m_initial_particle_2(file, 30.4, step, 'real', 'cubic');
disp('initial successful!')
save([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
disp('save finish!')

step = 3;
file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_unnormalized_projector(linear)'];
% run_path = pwd;
mkdir(path)

particle = m_initial_particle_2(file, 30.4, step, 'real', 'linear');
disp('initial successful!')
save([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
disp('save finish!')

m_create_pcimg;
disp('pcimg create successful!')


