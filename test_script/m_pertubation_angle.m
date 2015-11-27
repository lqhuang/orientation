% addtional information
angle_range = [0, 0.5, 1, 1.5, 2, 2.5, 3];
leng = length(angle_range);
euler_angle = [21, 21, 21]; % input euler angle 60 60 60
particle = EMD_6044_3;
path = '/mnt/data/lqhuang/EMD_6044_3/';
test_num = 100;
% Maximum Likelihood
tic
total_success1 = zeros(1,leng);
pcimg_cell = cell(1);
for n = 1:length(angle_range)
    success = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'ml', 'none', 'none');
    disp(['range:',num2str(n),'accuracy:',num2str(success)]);
    total_success1(n) = success;
end
toc
disp('Finish 1')

% corr + none + none
tic
total_success2 = zeros(1,leng);
load([path,'corr_none_none.mat'], 'pcimg_cell')
for n = 1:length(angle_range)
	success = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'corr', 'none', 'none');
    disp(['range:',num2str(n),'accuracy:',num2str(success)]);
    total_success2(n) = success;
end
toc
disp('Finish 2')

% corr + Bilinear + none
tic
total_success3 = zeros(1,leng);
load([path,'corr_bilinear_none.mat'], 'pcimg_cell')
for n = 1:length(angle_range)
    success = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'corr', 'bilinear', 'none');
    disp(['range:',num2str(n),'accuracy:',num2str(success)]);
    total_success3(n) = success;
end
toc
disp('Finish 3')

% corr + none + weight
total_success4 = zeros(1,leng);
load([path,'corr_none_linear.mat'], 'pcimg_cell')
for n = 1:length(angle_range)
    success = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'corr', 'none', 'linear');
    disp(['range:',num2str(n),'accuracy:',num2str(success)]);
    total_success4(n) = success;
end
disp('Finish 4')

% corr + bilinear + weight
total_success5 = zeros(1,leng);
load([path,'corr_bilinear_linear.mat'], 'pcimg_cell')
for n = 1:length(angle_range)
    success = m_angle_test(particle, pcimg_cell, euler_angle, [angle_range(n) angle_range(n) angle_range(n)], test_num, 'corr', 'bilinear', 'linear');
    disp(['range:',num2str(n),'accuracy:',num2str(success)]);
    total_success5(n) = success;
end
disp('Finish 5')

total_success = [total_success1; total_success2; total_success3; total_success4; total_success5];

plot(angle_range, total_success, '-o')
xlabel('angle range [-, +]');
ylabel('accuracy');
title('input angle (60, 60, 60) degree,\it t value in sigma noise equal to 1')
legend('Maximum Likelihood', 'Corr+None+None', 'Corr+Bilinear+None', 'Corr+None+Linear Weight', 'Corr+Bilinear+Linear Weight')

save([path,'total_success'], 'total_success');
% savefig('/mnt/data/lqhuang/angle_pertubation_test.fig')