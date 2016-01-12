run('/home/lqhuang/Documents/MATLAB/pathdef.m')
addpath(ans)
disp('add path successful!')

step = 30;

file = '/home/lqhuang/Documents/MATLAB/orientation/particle/EMD-6044.map';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_fourier'];

menu_list = ls('/mnt/data/lqhuang/');
[row, col] = size(menu_list);
for i = 1:row
    if strfind(['EMD_6044_',num2str(step),'_fourier'], menu_list(i,:))
        break
    elseif strfind(['EMD_6044_',num2str(step)], menu_list(i,:))
        break
    else
        mkdir(path)
    end
end

particle = m_initial_particle(file, 30.4, step, 'fft');
disp('initial successful!')
save([path,'/EMD_6044_',num2str(step),'_fourier.mat'], 'particle');
disp('save finish!')

% load = ([path,'EMD_6044_10_fourier.mat'], 'EMD_6044_3_fft');
% particle = EMD_6044_3_fft;
% clear EMD_6044_3_fft

m_create_pcimg;
disp('pcimg create successful!')

euler_angle = repmat(60/step+1,1,3); % input euler angle [60 60 60]

m_sigma_noise_test;
disp('noise_test finish!')

m_pertubation_angle;
disp('pertubation_angle test finish!');

disp('successful!')