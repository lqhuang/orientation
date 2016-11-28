addpath(genpath('../function/'))
disp('add path successful!')


%% do test 1
mypool = parpool(15);
result_path = '/mnt/data/lqhuang/result/2016-09-05';
mkdir(result_path);
m_sigma_noise_test
m_sigma_noise_test_corr

exit