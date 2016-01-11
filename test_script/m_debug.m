path = 'D:\lqhuang\Desktop\report-2016-01-11';
a60 = EMD_6044_30.simulated_projection{2,2,2};
a30 = EMD_6044_30.simulated_projection{2,1,2};

a60 = (a60 - mean(a60(:))) / var(a60(:));
a30 = (a30 - mean(a30(:))) / var(a30(:));

a60 = m_create_exp_data(a60, 0.0001);
a30 = m_create_exp_data(a30, 0.0001);

% [pSNR, SNR] = psnr(a60_noise, a60)

a60_fft = abs( fftshift( fft2(a60) ) );
a30_fft = abs( fftshift( fft2(a30) ) );

a60_fft_corr = m_corr_function_fft( a60_fft , 'none', 'none');
a30_fft_corr = m_corr_function_fft( a30_fft , 'none', 'none');

diff = a60_fft_corr - a30_fft_corr;

figure(1)
subplot(1,2,1)
imagesc(a60)
title('angle (60\circ,60\circ,60\circ)')
colorbar
subplot(1,2,2)
imagesc(a30)
title('angle (60^\circ,60^\circ,30^\circ)')
colorbar
print('-painters','-dpng', [path,'\1.png']);

figure(2)
subplot(1,2,1)
imagesc(a60_fft)
title('angle (60\circ,60\circ,60\circ)')
colorbar
subplot(1,2,2)
imagesc(a30_fft)
title('angle (60^\circ,60^\circ,30^\circ)')
colorbar
print('-painters','-dpng', [path,'\2.png']);

figure(3)
subplot(1,2,1)
imagesc(a60_fft_corr)
title('angle (60\circ,60\circ,60\circ)')
colorbar
subplot(1,2,2)
imagesc(a30_fft_corr)
title('angle (60^\circ,60^\circ,30^\circ)')
colorbar
print('-painters','-dpng', [path,'\3.png']);

figure(4)
imagesc(abs(diff))
title('difference of two correction image')
colorbar
print('-painters','-dpng', [path,'\4.png']);