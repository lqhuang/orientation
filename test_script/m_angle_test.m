function success = m_angle_test(particle, pcimg_cell, euler_angle, angle_range, test_num, method, pcimg_method, weight)

save_success = zeros(1, test_num);
theta = euler_angle(1) - 1;
psi = euler_angle(2) - 1;
phi = euler_angle(3) - 1;
step = particle.step;
maximum = particle.maximum_value;
object = particle.object;
projection_cell = particle.simulated_projection;

theta_angle_range = angle_range(1);
psi_angle_range = angle_range(2);
phi_angle_range = angle_range(3);

parfor iteration = 1:test_num
    angle1 = randi([-theta_angle_range*100, theta_angle_range*100])/100;
    angle2 = randi([-psi_angle_range*100, psi_angle_range*100])/100;
    angle3 = randi([-phi_angle_range*100, phi_angle_range*100])/100;
    projection = m_projector(object,...
                             [theta*step + angle1, psi*step + angle2, phi*step + angle3]) ;
    projection = projection ./ maximum * 255
    exp_data = m_create_exp_data(projection, 1)+1;
    switch method
        case 'ml'
            subscript = m_relion_function(exp_data, projection_cell);
        case 'corr'
            subscript = m_corr_method_function(exp_data, projection_cell, pcimg_cell, pcimg_method, weight);
    end
    match = m_find_correct(euler_angle, subscript);
    if match == 1
        save_success(iteration) = 1;
    end
end

success = sum(save_success);

end