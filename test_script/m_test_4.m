test_loop = 240
sim_subscript_1 = sim_subscript(test_loop, :)

tic
[subscript, prob] = m_par_corr_method_function_sigma(exp_img{test_loop}, particle, pcimg_cell, sigma2, 'linear', 'none');
toc

subscript

figure(1)
plot(prob)

figure(2)

imshow(exp_img{test_loop}, [])

img_mean = mean(exp_img{test_loop}(:))
img_var = var(exp_img{test_loop}(:))