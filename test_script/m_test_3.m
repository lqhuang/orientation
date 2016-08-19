test_loop = 202
sim_subscript_1 = sim_subscript(test_loop, :)

tic
[subscript, prob] = m_par_ML_function_sigma(exp_img{test_loop}, particle, sigma2);
toc

subscript

figure(1)
plot(prob)

figure(2)

imshow(exp_img{test_loop}, [])

img_mean = mean(exp_img{test_loop}(:))
img_var = var(exp_img{test_loop}(:))


