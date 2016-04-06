% addtional information
angle_range = [0, 0.5, 1, 1.5, 2, 2.5, 3];
leng = length(angle_range);
euler_angle = [21, 21, 21]; % input euler angle 60 60 60
test_num = 100;

% corr + linear + linear
load([path,'/corr_linear_none.mat'], 'pcimg_cell')
success_corr = zeros(2, leng);
for n = 1:length(angle_range)
    [success_corr(1, n), success_corr(2, n)] = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'corr', 'linear', 'none');
end

disp('Finish')
save([result_path,'/pertubation_test_Corr_linear_none.mat'], 'success_corr');

% Maximum Likelihood
pcimg_cell = cell(1);
success_ML = zeros(2, leng);
for n = 1:length(angle_range)
    [success_ML(1, n), success_ML(2, n)] = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'ML', 'none', 'none');
end

disp('Finish')
save([result_path,'/pertubation_test_ML.mat'], 'success_ML');

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