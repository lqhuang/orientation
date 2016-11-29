SNR = [1:-0.2:0.4, 0.4:-0.02:0.02];
% SIGMA2 = 1:1:25;
SIGMA2 = 1./SNR;
Curve = zeros(400, length(SIGMA2));
step = 10;
filepath = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_fourier_125_125_normalized_projector_linear'];
load([filepath,'/EMD_6044_',num2str(step),'.mat'], 'particle');

for loop = 1:length(SIGMA2);
    
    sigma2 = SIGMA2(loop);
    
    % generate distribution of simulated angle
    sim_subscript = ones(400, 3);
    nx = 36;
    ny = 19;
    nz = 36;
    % Class 1 where gamma angle = 0
    for n = 1:200
        index = randi(nx * ny);
        [i, j]= ind2sub([nx, ny], index);
        while or(j == 1, j == 19)
            index = randi(nx * ny);
            [i, j]= ind2sub([nx, ny], index);
        end
        sim_subscript(n, 1) = i;
        sim_subscript(n, 2) = j;
    end
    % Class 2 all angle lie in random distribution
    for n = 201:400
        index = randi(nx * ny * nz);
        [i, j, k]= ind2sub([nx, ny, nz], index);
        while k == 1 || j == 1 || j == 19
            index = randi(nx * ny * nz);
            [i, j, k]= ind2sub([nx, ny, nz], index);
        end
        sim_subscript(n, 1) = i;
        sim_subscript(n, 2) = j;
        sim_subscript(n, 3) = k;
    end
    
    parfor test_loop = 1:400
        i = sim_subscript(test_loop, 1);
        j = sim_subscript(test_loop, 2);
        k = sim_subscript(test_loop, 3);
        proj = particle.simulated_projection{i, j, k};
        exp_proj = m_create_exp_data(proj, sigma2, 'Normal');
        exp_img{test_loop} = m_oversampler(exp_proj, particle.oversampling_factor)
    end
    
    for test_loop=1:400
        % ML
        subscript = m_par_ML_function_sigma(exp_img{test_loop}, particle, sigma2);
        match = m_find_correct(sim_subscript(test_loop, :), subscript);
        Curve(test_loop, loop) = match;
        
        disp(['Now,sigma2=',num2str(sigma2),',in Loop:',num2str(loop),',in test_Loop:',num2str(test_loop)])
    end
end
save([result_path,'/noise_test_fourier.mat'], 'Curve');