function success = m_angle_test(particle, pcimg_cell, euler_angle, angle_range, test_num, method, pcimg_method, weight)

save_success = zeros(1, test_num);
theta = euler_angle(1) - 1;
psi = euler_angle(2) - 1;
phi = euler_angle(3) - 1;
step = particle.step;
object = particle.object;
SNR = 5;  %%%%!!!!!!!!!!!!!!!! need to notice
% simulated_projection = particle.simulated_projection;

theta_angle_range = angle_range(1);
psi_angle_range = angle_range(2);
phi_angle_range = angle_range(3);

for iteration = 1:test_num
    angle1 = randi([-theta_angle_range*100, theta_angle_range*100])/100;
    angle2 = randi([-psi_angle_range*100, psi_angle_range*100])/100;
    angle3 = randi([-phi_angle_range*100, phi_angle_range*100])/100;
    reprojection = m_projector(object,...
                   [theta*step + angle1, psi*step + angle2, phi*step + angle3]) ;
    mat_mean = mean(reprojection(:));
    mat_var = var(reprojection(:));
    reprojection = (reprojection - mat_mean) / sqrt(mat_var);
    exp_data = m_create_exp_data(reprojection, SNR);
    
    %%%%%%%%%%%%%%%%%%%%%%%
    exp_data = abs( fftshift( fft2(exp_data) ) );
    %%%%%%%%%%%%%%%%%%%%%%%
    
    switch method
        case 'ML'
            subscript = m_par_ML_function(exp_data, particle);
        case 'corr'
            subscript = m_par_corr_method_function(exp_data, particle, pcimg_cell, pcimg_method, weight);
    end
    match = m_find_correct(euler_angle, subscript);
    if match == 1
        save_success(iteration) = 1;
    end
end

success = sum(save_success);

end