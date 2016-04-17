function [success, strict_success] = m_angle_test(particle, pcimg_cell, euler_angle, angle_range, test_num, method, pcimg_method, weight)

% 做微扰测试..
% 输出严格正确的角度，和通过斜率方式输出的角度

save_success = zeros(1, test_num);
save_strict_success = zeros(1, test_num);

step = particle.step;
object = particle.object;
space = particle.space;
oversampling_factor = 1;
if strcmp(space, 'fourier')
    oversampling_factor = particle.oversampling_factor;
end

phi_angle_range = angle_range(1);
theta_angle_range = angle_range(2);
psi_angle_range = angle_range(3);

nx = 120;
ny = 61;
nz = 120;
% check size of input euler angle
[num_euler_angle, ~] = size(euler_angle);
if num_euler_angle == 0
    num_euler_angle = 2500;
    euler_angle = zeros(num_euler_angle, 3);
    for n = 1:num_euler_angle
        j = 1;
        while j == 1
            index = randi(nx * ny * nz);
            [i, j, k]= ind2sub([nx, ny, nz], index);
        end
        euler_angle(n, 1) = i;
        euler_angle(n, 2) = j;
        euler_angle(n, 3) = k;
    end
end


% need to * step
% phi = euler_angle(1) - 1;
% theta = euler_angle(2) - 1;
% psi = euler_angle(3) - 1;

exp_data = struct;
parfor iteration = 1:num_euler_angle
    angle = euler_angle(iteration, :);
    phi = angle(1) - 1;
    theta = angle(2) - 1;
    psi = angle(3) - 1;
    angle1 = randi([-phi_angle_range*100, phi_angle_range*100])/100;
    angle2 = randi([-theta_angle_range*100, theta_angle_range*100])/100;
    angle3 = randi([-psi_angle_range*100, psi_angle_range*100])/100;
    reprojection = m_projector(object,...
                               [phi*step + angle1, theta*step + angle2, psi*step + angle3]) ;
%     mat_mean = mean(reprojection(:));
%     mat_var = var(reprojection(:));
%     reprojection = (reprojection - mat_mean) / sqrt(mat_var);
    if strcmp(space, 'real')
        exp_data(iteration).image = poissrnd(reprojection+1);
    elseif strcmp(space, 'fourier')
        exp_img = poissrnd(reprojection);
        exp_data(iteration).image = m_oversampler(exp_img, oversampling_factor);
    end
end


for iteration = 1:num_euler_angle
    tic
    switch method
        case 'ML'
            subscript = m_par_ML_function(exp_data(iteration).image, particle);
            [loose_match, strict_match] = m_find_correct(euler_angle(iteration, :), subscript, space);
            save_success(iteration) = loose_match;
            save_strict_success(iteration) = strict_match;
        case 'corr'
            subscript = m_par_corr_method_function(exp_data(iteration).image, particle, pcimg_cell, pcimg_method, weight);
            [loose_match, strict_match] = m_find_correct(euler_angle(iteration, :), subscript, space);
            save_success(iteration) = loose_match;
            save_strict_success(iteration) = strict_match;
    end
    toc
    disp(['total:',num2str(num_euler_angle),'-iteration:',num2str(iteration),'-remaining:',num2str(num_euler_angle-iteration)]);
end

success = sum(save_success);
strict_success = sum(save_strict_success);

end
