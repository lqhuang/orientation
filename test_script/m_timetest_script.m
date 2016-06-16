run('/home/lqhuang/Documents/MATLAB/pathdef.m');
addpath(ans)
disp('add path successful!')

step = 10;
space = 'real';

result_path = '/mnt/data/lqhuang/result/2016-05-26';
mkdir result_path;
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_unnormalized_projector_linear'];
load([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
load([path,'/corr_linear_none.mat'], 'pcimg_cell');

mypool = parpool(10);
%% Maximum Likelihood

particle_size = prod(particle.simulated_size);
for i = 1:10
    index = randi(particle_size);
    img = particle.simulated_projection{index};
    subscript = m_par_ML_function(img, particle);
end

exp_img = zeros(125, 125, 100);
for i = 1:100
    index = randi(particle_size);
    exp_img(:,:,i) = particle.simulated_projection{index};
end

ml_time = zeros(1,100);

for i = 1:100
    tic
    subscript = m_par_ML_function(exp_img(:,:,i), particle);
    ml_time(i) = toc;
end

%% Correlation

for i = 1:10
    index = randi(particle_size);
    img = particle.simulated_projection{index};
    subscript = m_par_corr_method_function(img, particle, pcimg_cell, 'linear', 'none');
end

pcimg_size = size(pcimg_cell);

corr_time = zeros(1,100);

for i = 1:100
    tic
    subscript = m_par_corr_method_function(exp_img(:,:,i), particle, pcimg_cell, 'linear', 'none');
    corr_time(i) = toc;
end

ml_time_mean = mean(ml_time);
corr_time_mean = mean(corr_time_mean);

save([resutl_path,'/',space,num2str(step),'.mat'], 'corr_time_mean', 'ml_time_mean');

clear

%%
step = 10;
space = 'fourier';

result_path = '/mnt/data/lqhuang/result/2016-05-26';
mkdir result_path;
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_',space,'_125_125_unnormalized_projector_linear'];
load([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
load([path,'/corr_linear_none.mat'], 'pcimg_cell');

%% Maximum Likelihood

particle_size = prod(particle.simulated_size);
for i = 1:10
    index = randi(particle_size);
    img = particle.simulated_projection{index};
    subscript = m_par_ML_function(img, particle);
end

exp_img = zeros(125, 125, 100);
for i = 1:100
    index = randi(particle_size);
    exp_img(:,:,i) = particle.simulated_projection{index};
end

ml_time = zeros(1,100);

for i = 1:100
    tic
    subscript = m_par_ML_function(exp_img(:,:,i), particle);
    ml_time(i) = toc;
end

%% Correlation

for i = 1:10
    index = randi(particle_size);
    img = particle.simulated_projection{index};
    subscript = m_par_corr_method_function(img, particle, pcimg_cell, 'linear', 'none');
end

pcimg_size = size(pcimg_cell);

corr_time = zeros(1,100);

for i = 1:100
    tic
    subscript = m_par_corr_method_function(exp_img(:,:,i), particle, pcimg_cell, 'linear', 'none');
    corr_time(i) = toc;
end

ml_time_mean = mean(ml_time);
corr_time_mean = mean(corr_time_mean);

save([resutl_path,'/',space,num2str(step),'.mat'], 'corr_time_mean', 'ml_time_mean');

clear
delete(mypool)