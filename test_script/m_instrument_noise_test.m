function [accuracy, subscript, num_first_second] = m_instrument_noise_test(particle, pcimg_cell, space, interpolation, weight, first_num, second_num)
nx = particle.simulated_size(1);
ny = particle.simulated_size(2);
nz = particle.simulated_size(3);
step = particle.step;
if strcmp(space, 'fourier');
    factor = particle.particle.oversampling_factor;
end
% 先造一些第一层的
subscript_first = ones(first_num,3);
accuracy_first = zeros(4, first_num);
for n = 1:first_num
    index = randi(nx * ny);
    [i,j] = ind2sub([nx, ny], index);
    subscript_first(n,1:2) = [i,j];
    img = particle.simulated_projection{i,j,1};
    % without noise
    for test_loop = 1:1
        % ML
        subscript_output = m_par_ML_function(img, particle);
        match = m_find_correct(subscript_first(n, :), subscript_output);
        accuracy_first(1, n) = accuracy_first(1, n) + match;
        % Corr
        subscript_output = m_par_corr_method_function(img, particle, pcimg_cell);
        match = m_find_correct(subscript_first(n, :), subscript_output);
        accuracy_first(3, n) = accuracy_first(3, n) + match;
    end
    % poisson noise
    for test_loop = 1:100
        switch space
            case 'real'
                exp_img = poissrnd(img);
            case 'fourier'
                exp_img = poissrnd(img);
        % ML
        subscript_output = m_par_ML_function(exp_img, particle);
        match = m_find_correct(subscript_first(n, :), subscript_output);
        accuracy_first(2, n) = accuracy_first(2, n) + match;
        % Corr
        subscript_output = m_par_corr_method_function(exp_img, particle, pcimg_cell);
        match = m_find_correct(subscript_first(n, :), subscript_output);
        accuracy_first(4, n) = accuracy_first(4, n) + match;
    end
end
    
% 后面是随机的
subscript_all = zeros(second_num,3);
accuracy_all = zeros(4,second_num);
for n = 1:second_num
    index = randi(nx * ny * nz);
    [i, j, k]= ind2sub([nx, ny, nz], index);
    if k == 1
        k = randi(nz);
    end
    subscript_all(n,1:3) = [i, j, k];
    img = particle.simulated_projection{i,j,k};
    % 无噪声
    for test_loop = 1:1
        % ML
        subscript_output = m_par_ML_function(img, particle);
        match = m_find_correct(subscript_all(n, :), subscript_output);
        accuracy_all(1, n) = accuracy_all(1, n) + match;
        % Corr
        subscript_output = m_par_corr_method_function(img, particle, pcimg_cell, interpolation, weight);
        match = m_find_correct(subscript_all(n, :), subscript_output);
        accuracy_all(3, n) = accuracy_all(3, n) + match;
    end
    for test_loop = 1:100
        % poisson noise
        exp_img = poissrnd(img);
        % ML
        subscript_output = m_par_ML_function(exp_img, particle);
        match = m_find_correct(subscript_all(n, :), subscript_output);
        accuracy_all(2, n) = accuracy_all(2, n) + match;
        % Corr
        subscript_output = m_par_corr_method_function(exp_img, particle, pcimg_cell, interpolation, weight);
        match = m_find_correct(subscript_all(n, :), subscript_output);
        accuracy_all(4, n) = accuracy_all(4, n) + match;
    end
end
subscript = [subscript_first; subscript_all];
accuracy = [accuracy_first, accuracy_all];
num_first_second = [first_num, second_num];
end