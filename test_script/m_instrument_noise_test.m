function [accuracy_real, accuracy_fourier, subscript] = m_instrument_noise_test(result_path, subscript)

if exist('subscript', 'var') == 0
    % 先随机生成等待测试的角度 分第一层的和大部分随机的
    subscript = ones(100, 3);
    nx = 36;
    ny = 19;
    nz = 36;
    % 第一平面上
    for n = 1:50
        index = randi(nx * ny);
        [i, j]= ind2sub([nx, ny], index);
        subscript(n, 1) = i;
        subscript(n, 2) = j;
    end
    % 全部随机
    for n = 51:100
        index = randi(nx * ny * nz);
        [i, j, k]= ind2sub([nx, ny, nz], index);
        while k == 1
            k = randi(nz);
        end
        subscript(n, 1) = i;
        subscript(n, 2) = j;
        subscript(n, 3) = k;
    end
end

accuracy_real = struct;
accuracy_fourier = struct;

%% REAL SPACE
step = 10;
space = 'real';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_unnormalized_projector_linear'];
load([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
% ML
accuracy_real.ML = test_function(subscript, particle, space, 'ML', 'none', 'linear', 'none');
disp('Finish a test_function - REAL - ML')

% Corr-linear-none
interpolation = 'linear';
weight = 'none';
clear pcimg_cell
load([path,'/corr_linear_none.mat'], 'pcimg_cell');
accuracy_real.corr_linear_none = test_function(subscript, particle, space, 'Corr', pcimg_cell, interpolation, weight);
disp('Finish a test_function - REAL - LN')

% Corr-nearest-none
interpolation = 'nearest';
weight = 'none';
clear pcimg_cell
load([path,'/corr_nearest_none.mat'], 'pcimg_cell');
accuracy_real.corr_nearest_none = test_function(subscript, particle, space, 'Corr', pcimg_cell, interpolation, weight);
disp('Finish a test_function - REAL - NN')

% Corr-linear-nearest
interpolation = 'linear';
weight = 'linear';
clear pcimg_cell
load([path,'/corr_linear_linear.mat'], 'pcimg_cell');
accuracy_real.corr_linear_linear = test_function(subscript, particle, space, 'Corr', pcimg_cell, interpolation, weight);
disp('Finish a test_function - REAL - LL')

% Corr-nearest-none
interpolation = 'nearest';
weight = 'linear';
clear pcimg_cell
load([path,'/corr_nearest_linear.mat'], 'pcimg_cell');
accuracy_real.corr_nearest_none = test_function(subscript, particle, space, 'Corr', pcimg_cell, interpolation, weight);
disp('Finish a test_function - REAL - NL')

save([result_path,'/accuracy_real.mat'], 'accuracy_real'); disp('save successful');

%% Fourier SPACE
step = 10;
space = 'fourier';
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_fourier_125_125_unnormalized_projector_linear'];
clear particle
load([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
% ML
accuracy_fourier.ML = test_function(subscript, particle, space, 'ML', 'none', 'linear', 'none');
disp('Finish a test_function - Fourier - ML')

% Corr-linear-none
interpolation = 'linear';
weight = 'none';
clear pcimg_cell
load([path,'/corr_linear_none.mat'], 'pcimg_cell');
accuracy_fourier.corr_linear_none = test_function(subscript, particle, space, 'Corr', pcimg_cell, interpolation, weight);
disp('Finish a test_function - Fourier - LN')

% Corr-nearest-none
interpolation = 'nearest';
weight = 'none';
clear pcimg_cell
load([path,'/corr_nearest_none.mat'], 'pcimg_cell');
accuracy_fourier.corr_nearest_none = test_function(subscript, particle, space, 'Corr', pcimg_cell, interpolation, weight);
disp('Finish a test_function - Fourier - NN')

% Corr-linear-nearest
interpolation = 'linear';
weight = 'linear';
clear pcimg_cell
load([path,'/corr_linear_linear.mat'], 'pcimg_cell');
accuracy_fourier.corr_linear_linear = test_function(subscript, particle, space, 'Corr', pcimg_cell, interpolation, weight);
disp('Finish a test_function - Fourier - LL')

% Corr-nearest-none
interpolation = 'nearest';
weight = 'linear';
clear pcimg_cell
load([path,'/corr_nearest_linear.mat'], 'pcimg_cell');
accuracy_fourier.corr_nearest_none = test_function(subscript, particle, space, 'Corr', pcimg_cell, interpolation, weight);
disp('Finish a test_function - Fourier - NL')

save([result_path,'/accuracy_fourier.mat'], 'accuracy_fourier'); disp('save successful');
save([result_path,'/subscript.mat'], 'subscript');

end

function accuracy = test_function(subscript, particle, space, method, pcimg_cell, interpolation, weight)

step = particle.step;
if strcmp(space, 'fourier');
    factor = particle.oversampling_factor;
    object = particle.object;
end

[length, ~] = size(subscript);

accuracy = zeros(4, length);

for n = 1:length
    i = subscript(n,1);
    j = subscript(n,2);
    k = subscript(n,3);
    img = particle.simulated_projection{i,j,k};
    % 无噪声
    for test_loop = 1:1
        switch method
            case 'ML'
                % ML
                subscript_output = m_par_ML_function(img, particle);
                % loose
                match = m_find_correct(subscript(n, :), subscript_output);
                accuracy(1, n) = accuracy(1, n) + match;
                % strict
                if strcmp(space, 'real')
                    match = m_find_correct(subscript(n, :), subscript_output(1, :));
                    accuracy(3, n) = accuracy(3, n) + match;
                elseif strcmp(space, 'fourier')
                    match = m_find_correct(subscript(n, :), subscript_output(1:2, :));
                    accuracy(3, n) = accuracy(3, n) + match;
                end
            case 'Corr'                
                % Corr
                subscript_output = m_par_corr_method_function(img, particle, pcimg_cell, interpolation, weight);
                % loose
                match = m_find_correct(subscript(n, :), subscript_output);
                accuracy(1, n) = accuracy(1, n) + match;
                % strict
                if strcmp(space, 'real')
                    match = m_find_correct(subscript(n, :), subscript_output(1, :));
                    accuracy(3, n) = accuracy(3, n) + match;
                elseif strcmp(space, 'fourier')
                    match = m_find_correct(subscript(n, :), subscript_output(1:2, :));
                    accuracy(3, n) = accuracy(3, n) + match;
                end
        end
    end
    
    for test_loop = 1:100
        % poisson noise
        switch space
            case 'real'
                exp_img = poissrnd(img);
            case 'fourier'
                exp_img = poissrnd( m_projector(object, [(i-1)*step, (j-1)*step, (k-1)*step], 'linear') );
                exp_img = m_oversampler(exp_img, factor);
        end
        switch method
            case 'ML'
                % ML
                tic
                subscript_output = m_par_ML_function(exp_img, particle);
                ML_time = toc
                % loose
                match = m_find_correct(subscript(n, :), subscript_output);
                accuracy(2, n) = accuracy(2, n) + match;
                % strict
                if strcmp(space, 'real')
                    match = m_find_correct(subscript(n, :), subscript_output(1, :));
                    accuracy(4, n) = accuracy(4, n) + match;
                elseif strcmp(space, 'fourier')
                    match = m_find_correct(subscript(n, :), subscript_output(1:2, :));
                    accuracy(4, n) = accuracy(4, n) + match;
                end
            case 'Corr'
                % Corr
                tic
                subscript_output = m_par_corr_method_function(exp_img, particle, pcimg_cell, interpolation, weight);
                Corr_time = toc
                % loose
                match = m_find_correct(subscript(n, :), subscript_output);
                accuracy(2, n) = accuracy(2, n) + match;
                % strict
                if strcmp(space, 'real')
                    match = m_find_correct(subscript(n, :), subscript_output(1, :));
                    accuracy(4, n) = accuracy(4, n) + match;
                elseif strcmp(space, 'fourier')
                    match = m_find_correct(subscript(n, :), subscript_output(1:2, :));
                    accuracy(4, n) = accuracy(4, n) + match;
                end
        end
    end
end

end