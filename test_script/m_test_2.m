    SIGMA2 = 1:1:20;
    sigma2 = SIGMA2(20);
    
    exp_img = cell(1,400);

    % 先随机生成等待测试的角度 分第一层的和大部分随机的
    sim_subscript = ones(400, 3);
    nx = 36;
    ny = 19;
    nz = 36;
    % 第一平面上
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
    % 全部随机
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
    
    for test_loop = 202:203
        i = sim_subscript(test_loop,1);
        j = sim_subscript(test_loop,2);
        k = sim_subscript(test_loop,3);
        proj = particle.simulated_projection{i, j, k};
%         exp_img{test_loop} = proj;
        exp_img{test_loop} = m_create_exp_data(proj, sigma2, 'Normal');
    end