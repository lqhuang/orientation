nx = particle.simulated_size(1);
ny = particle.simulated_size(2);
nz = particle.simulated_size(3);

% 先造一些第一层的
subscript_first = ones(10,3);
for n = 1:10
    index = randi(nx * ny);
    [i,j] = ind2sub([nx, ny], index);
    subscript_first(n,1:2) = [i,j];
    img = particle.simulated_projection{i,j,1};
    accuracy_first = zeros(4,10);
    
    for test_loop = 1:5
        % 无噪声
        % ML
        tic
        subscript_output = m_par_ML_function(img, particle);
        toc
        match = m_find_correct(subscript_first(n, :), subscript_output);
        accuracy_first(1, n) = accuracy_first(1, n) + match;
        % Corr
        subscript_output = m_par_corr_method_function(img, particle, pcimg_cell);
        match = m_find_correct(subscript_first(n, :), subscript_output);
        accuracy_first(3, n) = accuracy_first(3, n) + match;
    end
    for test_loop = 1:33

        % poisson 噪声
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
subscript_all = zeros(30,3);
for n = 1:20
    index = randi(nx * ny * nz);
    [i, j, k]= ind2sub([nx, ny, nz], index);
    subscript_all(n,1:3) = [i, j, k];
    img = particle.simulated_projection{i,j,k};
    accuracy_all = zeros(4,20);
    for test_loop = 1:5
        % 无噪声
        % ML
        subscript_output = m_par_ML_function(img, particle);
        match = m_find_correct(subscript_all(n, :), subscript_output);
        accuracy_all(1, n) = accuracy_all(1, n) + match;
        % Corr
        subscript_output = m_par_corr_method_function(img, particle, pcimg_cell);
        match = m_find_correct(subscript_all(n, :), subscript_output);
        accuracy_all(3, n) = accuracy_all(3, n) + match;
    end
    for test_loop = 1:33

        % poisson 噪声
        exp_img = poissrnd(img);
        % ML
        subscript_output = m_par_ML_function(exp_img, particle);
        match = m_find_correct(subscript_all(n, :), subscript_output);
        accuracy_all(2, n) = accuracy_all(2, n) + match;
        % Corr
        subscript_output = m_par_corr_method_function(exp_img, particle, pcimg_cell);
        match = m_find_correct(subscript_all(n, :), subscript_output);
        accuracy_all(4, n) = accuracy_all(4, n) + match;
    end
end
subscript = [subscript_first, subscript_all];
accuracy = [accuracy_first, accuracy_all];
save([result_path, '/poission.mat'], 'accuracy', 'subscript')
disp('save finish')
