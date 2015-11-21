
angle_range = [0, 0.5, 1, 1.5, 2, 2.5, 3];
leng = length(angle_range);

% relion
tic
total_success1 = zeros(1,leng);
parfor n = 1:length(angle_range)
   success = m_angle_test(EMD_6044_3, [21,21,21], [n n n], 100, 'ml', 'none', 'none');
   disp(['range:',num2str(n),'accuracy:'])
   total_success1(n) = success
end
toc
disp('Finish 1')

% corr + none + none
tic
total_success2 = zeros(1,leng);
parfor n = 1:length(angle_range)
   success = m_angle_test(EMD_6044_3, [21,21,21], [n n n], 100, 'corr', 'none', 'none');
   disp(['range:',num2str(n),'accuracy:'])
   total_success2(n) = success
end
toc
disp('Finish 2')

% corr + Bilinear + none
tic
total_success3 = zeros(1,leng);
parfor n = 1:length(angle_range)
   success = m_angle_test(EMD_6044_3, [21,21,21], [n n n], 100, 'corr', 'bilinear', 'none');
   disp(['range:',num2str(n),'accuracy:'])
   total_success3(n) = success
end
toc
disp('Finish 3')

% corr + none + weight
total_success4 = zeros(1,leng);
parfor n = 1:length(angle_range)
   success = m_angle_test(EMD_6044_3, [21,21,21], [n n n], 100, 'corr', 'none', 'linear');
   disp(['range:',num2str(n),'accuracy:'])
   total_success4(n) = success
end
disp('Finish 4')


% corr + bilinear + weight
total_success5 = zeros(1,leng);
parfor n = 1:length(angle_range)
   success = m_angle_test(EMD_6044_3, [21,21,21], [n n n], 100, 'corr', 'bilinear', 'linear');
   disp(['range:',num2str(n),'accuracy:'])
   total_success5(n) = success
end
disp('Finish 5')

total_success = [total_success1; total_success2; total_success3; total_success4; total_success5];

plot(angle_range, total_success, '-o')
axis([0 3 20 120])
xlabel('angle range [-, +]');
ylabel('accuracy');
title('input angle (60, 60, 60) degree,\it t value in sigma noise equal to 1')
legend('Maximum Likelihood', 'Corr+None+None', 'Corr+Bilinear+None', 'Corr+None+Linear Weight', 'Corr+Bilinear+Linear Weight')
% print('-painters','-d
savefig('/mnt/data/lqhuang/angle_pertubation_test.fig')