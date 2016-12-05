object = m_readMRC('../particle/EMD-6044.map');
object(object<30.4) = 0;
step = 10;

ijk = [1 1 1]
proj = m_projector(object, (ijk-1)*step);
proj = (proj - mean(proj(:))) ./ sqrt(var(proj(:)));


SNR = 1;
sigma2 = 1./SNR;

exp_img = m_create_exp_data(proj, sigma2, 'Normal');
exp_img = abs(fftshift(fft2(exp_img)));

tic
[subscript, prob] = m_par_corr_method_function_sigma(exp_img, particle, pcimg_cell, sigma2, 'linear', 'none');
toc

subscript

figure(1)
plot(prob)

figure(2)

imshow(exp_img{test_loop}, [])

% img_mean = mean(exp_img{test_loop}(:))
% img_var = var(exp_img{test_loop}(:))