function success = m_angle_test(particle, euler_angle, angle_range, test_num, method, pcimg_method, weight)
% global maximum object
save_success = zeros(1, test_num);
theta = euler_angle(1) - 1;
psi = euler_angle(2) - 1;
Phi = euler_angle(3) - 1;
step = particle.step;
% wrong_subscript = [];
parfor iteration = 1:test_num
    angle1 = randi([-angle_range(1)*100, angle_range(1)*100])/100;
    angle2 = randi([-angle_range(2)*100, angle_range(2)*100])/100;
    angle3 = randi([-angle_range(3)*100, angle_range(3)*100])/100;
    projection = m_projector(particle.object,...
                             [theta*step + angle1, psi*step + angle2, Phi*step + angle3]);
    exp_data = m_create_exp_data(projection, 1)+1;
    switch method
        case 'ml'
            subscript = m_relion_function(exp_data, particle.simulated_projection);
        case 'corr'
            subscript = m_corr_method_function(exp_data, particle.simulated_projection, pcimg_method, weight);
    end
    match = m_find_correct(euler_angle, subscript);
    if match == 1
        save_success(iteration) = 1;
%     else
%         wrong_subscript = [wrong_subscript; subscript];
    end
end

success = sum(save_success);

end