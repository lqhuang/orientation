SIGMA2 = 1:1:25;
Curve = zeros(400, length(SIGMA2));
step = 10;
path = ['/mnt/data/lqhuang/EMD_6044_',num2str(step),'_real_125_125_normalized_projector_linear'];
load([path,'/EMD_6044_',num2str(step),'.mat'], 'particle');
load([path,'/corr_linear_none.mat'], 'pcimg_cell')

for loop = 1:length(SIGMA2);
    
    sigma2 = SIGMA2(loop);
    
    % ��������ɵȴ����ԵĽǶ� �ֵ�һ��ĺʹ󲿷������
    sim_subscript = ones(400, 3);
    nx = 36;
    ny = 19;
    nz = 36;
    % ��һƽ����
    for n = 1:200
        index = randi(nx * ny);
        [i, j]= ind2sub([nx, ny], index);
        while j == 1
            index = randi(nx * ny);
            [i, j]= ind2sub([nx, ny], index);
        end
        sim_subscript(n, 1) = i;
        sim_subscript(n, 2) = j;
    end
    % ȫ�����
    for n = 201:400
        index = randi(nx * ny * nz);
        [i, j, k]= ind2sub([nx, ny, nz], index);
        while or(k == 1, j == 1)
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
        exp_img{test_loop} = m_create_exp_data(proj, sigma2, 'Normal');
    end
    
    for test_loop=1:400
        % correlation
        subscript = m_par_corr_method_function_sigma(exp_img{test_loop}, particle, pcimg_cell, sigma2, 'linear', 'none');
        match = m_find_correct(sim_subscript(test_loop, :), subscript);
        Curve(test_loop, loop) = match;
        
        disp(['Now,sigma2=',num2str(sigma2),',in Loop:',num2str(loop),',in test_Loop:',num2str(test_loop)])
    end
end
save([result_path,'/noise_test_corr.mat'], 'Curve');