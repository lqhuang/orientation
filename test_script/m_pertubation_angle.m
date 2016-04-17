% % addtional information
% angle_range = [0, 0.5, 1, 1.5, 2, 2.5, 3];
% leng = length(angle_range);
% euler_angle = [21, 21, 21]; % input euler angle 60 60 60
% test_num = 100;
% 
% % corr + linear + linear
% load([path,'/corr_linear_none.mat'], 'pcimg_cell')
% success_corr = zeros(2, leng);
% for n = 1:length(angle_range)
%     [success_corr(1, n), success_corr(2, n)] = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'corr', 'linear', 'none');
% end
% 
% disp('Finish')
% save([result_path,'/pertubation_test_corr_linear_none.mat'], 'success_corr');
% 

% Maximum Likelihood
% pcimg_cell = cell(1);
% success_ML = zeros(2, leng);
% for n = 1:length(angle_range)
%     [success_ML(1, n), success_ML(2, n)] = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'ML', 'none', 'none');
% end
% 
% disp('Finish')
% save([result_path,'/pertubation_test_ML.mat'], 'success_ML');

% 
% 
% 
% total_success = [total_success1; total_success2; total_success3; total_success4; total_success5];
% 
% plot(angle_range, total_success, '-o')
% xlabel('angle range [-, +]');
% ylabel('accuracy');
% title('input angle (60, 60, 60) degree,\it t value in sigma noise equal to 1')
% legend('Maximum Likelihood', 'Corr+None+None', 'Corr+Bilinear+None', 'Corr+None+Linear Weight', 'Corr+Bilinear+Linear Weight')
% 
% save([path,'/pertubation_test.mat'], 'total_success');


% build random euler angle
nx = 120;
ny = 61;
nz = 120;

% num_euler_angle = 5000;
% euler_angle = zero(num_euler_angle, 3);
% for n = 1:num_euler_angle
%     while j == 1
%         index = randi(nx * ny * nz);
%         [i, j, k]= ind2sub([nx, ny, nz], index);
%     end
%     euler_angle(n, 1) = i;
%     euler_angle(n, 2) = j;
%     euler_angle(n, 3) = k;
% end
% save([result_path, '/input_euler_angle.mat'])
euler_angle = [];

% 只计算 real space 和 fourier space 的 correlation 方法..不然耗时太长了
% fourier space
step = 3;
space = 'fourier';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_',space,'_125_125_unnormalized_projector_linear'];

load([path,'/EMD_6044_3.mat'], 'particle');
 
leng = length(angle_range);
% euler_angle = [21, 21, 21]; % input euler angle 60 60 60
test_num = 100;
% corr + linear + linear
load([path,'/corr_linear_none.mat'], 'pcimg_cell')
success_corr = zeros(2, leng);
for n = 1:length(angle_range)
    [success_corr(1, n), success_corr(2, n)] = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'corr', 'linear', 'none');
end
disp('Finish')
success_corr_real = success_corr;
save([result_path,'/pertubation_test_corr_linear_none_real.mat'], 'success_corr_real');

clear pcimg_cell
clear particle
clear m_angle_test

% real space
step = 3;
space = 'real';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_',space,'_125_125_unnormalized_projector_linear'];

load([path,'/EMD_6044_3.mat'], 'particle');

p = gcp('nocreate'); % If no pool, do not create new one.
if isempty(p)
    mypool = parpool(10);
end

leng = length(angle_range);
% euler_angle = [21, 21, 21]; % input euler angle 60 60 60
test_num = 100;
% corr + linear + linear
load([path,'/corr_linear_none.mat'], 'pcimg_cell')
success_corr = zeros(2, leng);
for n = 1:length(angle_range)
    [success_corr(1, n), success_corr(2, n)] = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'corr', 'linear', 'none');
end
disp('Finish')
success_corr_fourier = success_corr;
save([result_path,'/pertubation_test_corr_linear_none_fourier.mat'], 'success_corr_fourier');
