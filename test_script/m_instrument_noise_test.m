nx = particle.simulated_size(1);
ny = particle.simulated_size(2);
nz = particle.simulated_size(3);

% ����һЩ��һ���
% subscript_first = ones(10,3);
accuracy_first = zeros(4,10);
for n = 1:10
    index = randi(nx * ny);
    [i,j] = ind2sub([nx, ny], index);
%     subscript_first(n,1:2) = [i,j];
    i = subscript_first(n,1);
    j = subscript_first(n,2);
    img = particle.simulated_projection{i,j,1};
    for test_loop = 1:2
        % ������
        % ML
%         subscript_output = m_par_ML_function(img, particle);
%         match = m_find_correct(subscript_all(n, :), subscript_output);
%         accuracy_all(1, n) = accuracy_all(1, n) + match;
        % Corr
        subscript_output = m_par_corr_method_function(img, particle, pcimg_cell);
        match = m_find_correct(subscript_first(n, :), subscript_output);
        accuracy_first(3, n) = accuracy_first(3, n) + match;
    end
    for test_loop = 1:66

        % poisson ����
        exp_img = poissrnd(img);
        % ML
%         subscript_output = m_par_ML_function(exp_img, particle);
%         match = m_find_correct(subscript_first(n, :), subscript_output);
%         accuracy_first(2, n) = accuracy_first(2, n) + match;
        % Corr
        subscript_output = m_par_corr_method_function(exp_img, particle, pcimg_cell);
        match = m_find_correct(subscript_first(n, :), subscript_output);
        accuracy_first(4, n) = accuracy_first(4, n) + match;
    end
end
    
% �����������
% subscript_all = zeros(20,3);
accuracy_all = zeros(4,20);
for n = 1:20
    index = randi(nx * ny * nz);
%     [i, j, k]= ind2sub([nx, ny, nz], index);
%     if k == 1
%         k = randi(37);
%     end
%     subscript_all(n,1:3) = [i, j, k];
    i = subscript_all(n,1);
    j = subscript_all(n,2);
    k = subscript_all(n,3);
    img = particle.simulated_projection{i,j,k};
    for test_loop = 1:2
        % ������
        % ML
%         subscript_output = m_par_ML_function(img, particle);
%         match = m_find_correct(subscript_all(n, :), subscript_output);
%         accuracy_all(1, n) = accuracy_all(1, n) + match;
        % Corr
        subscript_output = m_par_corr_method_function(img, particle, pcimg_cell);
        match = m_find_correct(subscript_all(n, :), subscript_output);
        accuracy_all(3, n) = accuracy_all(3, n) + match;
    end
    for test_loop = 1:66

        % poisson ����
        exp_img = poissrnd(img);
        % ML
%         subscript_output = m_par_ML_function(exp_img, particle);
%         match = m_find_correct(subscript_all(n, :), subscript_output);
%         accuracy_all(2, n) = accuracy_all(2, n) + match;
        % Corr
        tic
        subscript_output = m_par_corr_method_function(exp_img, particle, pcimg_cell);
        toc
        match = m_find_correct(subscript_all(n, :), subscript_output);
        accuracy_all(4, n) = accuracy_all(4, n) + match;
    end
end
subscript = [subscript_first; subscript_all];
accuracy = [accuracy_first, accuracy_all];
save([result_path, '/the_same_anlge_last_day_poission_withoutsquare.mat'], 'accuracy', 'subscript')
disp('save finish')