function [success, strict_success] = m_angle_test(particle, pcimg_cell, euler_angle, angle_range, test_num, method, pcimg_method, weight)

% 做微扰测试..
% 输出严格正确的角度，和通过斜率方式输出的角度

save_success = zeros(1, test_num);
save_strict_success = zeros(1, test_num);

% need to * step
phi = euler_angle(1) - 1;
theta = euler_angle(2) - 1;
psi = euler_angle(3) - 1;

step = particle.step;
object = particle.object;
space = particle.space;
fourier_factor = 1;
if strcmp(space, 'fourier')
    fourier_factor = particle.factor;
end

phi_angle_range = angle_range(1);
theta_angle_range = angle_range(2);
psi_angle_range = angle_range(3);

exp_data = cell(1, test_num);
parfor iteration = 1:test_num
    angle1 = randi([-phi_angle_range*100, phi_angle_range*100])/100;
    angle2 = randi([-theta_angle_range*100, theta_angle_range*100])/100;
    angle3 = randi([-psi_angle_range*100, psi_angle_range*100])/100;
    reprojection = m_projector(object,...
                               [phi*step + angle1, theta*step + angle2, psi*step + angle3]) ;
%     mat_mean = mean(reprojection(:));
%     mat_var = var(reprojection(:));
%     reprojection = (reprojection - mat_mean) / sqrt(mat_var);
    if strcmp(space, 'real')
        exp_data{iteration} = poissrnd(reprojection+1);
    elseif strcmp(space, 'fourier')
        exp_img = poissrnd(reprojection+1);
        exp_data{iteration} = m_oversampler(exp_img, fourier_factor);
    end
end

for iteration = 1:test_num
    tic
    switch method
        case 'ML'
            subscript = m_par_ML_function(exp_data{iteration}, particle);
            [loose_match, strict_match] = m_find_correct(euler_angle, subscript, space);
            save_success(iteration) = loose_match;
            save_strict_success(iteration) = strict_match;
        case 'corr'
            subscript = m_par_corr_method_function(exp_data{iteration}, particle, pcimg_cell, pcimg_method, weight);
            [loose_match, strict_match] = m_find_correct(euler_angle, subscript, space);
            save_success(iteration) = loose_match;
            save_strict_success(iteration) = strict_match;
    end
    orientation_time = toc
end

success = sum(save_success);
strict_success = sum(save_strict_success);

end