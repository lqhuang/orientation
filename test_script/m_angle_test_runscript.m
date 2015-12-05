run('/home/lqhuang/Documents/MATLAB/pathdef.m')
addpath(ans)
disp('add path successful!')

file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map'
% EMD_6044_3 = m_initial_particle(file, 30.4, 3, 'half');
% save('/mnt/data/lqhuang/EMD_6044_3_half/EMD_6044_3_half.mat','EMD_6044_3');
% disp('save successful!')

load('/mnt/data/lqhuang/EMD_6044_3_half/EMD_6044_3_half.mat','EMD_6044_3');
m_create_pcimg;
disp('pcimg create successful!')

m_pertubation_angle;
disp('all finish!');