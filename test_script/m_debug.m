path = 'D:\lqhuang\Desktop\report-2016-01-11';
a60 = EMD_6044_30.simulated_projection{2,2,2};
a30 = EMD_6044_30.simulated_projection{2,2,1};

a60 = (a60 - mean(a60(:))) ./ sqrt(var(a60(:)));
a30 = (a30 - mean(a30(:))) ./ sqrt(var(a30(:)));

a60_noise = m_create_exp_data(a60, 2);
a30_noise = m_create_exp_data(a30, 2);

% [pSNR, SNR] = psnr(a60_noise, a60)

a60_fft = abs( fftshift( fft2(a60_noise) ) );
a30_fft = abs( fftshift( fft2(a30_noise) ) );

a60_fft_corr = m_corr_function_fft( a60_fft , 'none', 'none');
a30_fft_corr = m_corr_function_fft( a30_fft , 'none', 'none');

diff = a60_fft_corr - a30_fft_corr;

figure(1)
subplot(1,3,1)
imagesc(a60)
axis image
title(['reference of', 10, 'angle (60\circ,60\circ,60\circ)'])
colorbar
subplot(1,3,2)
imagesc(normrnd(0,sqrt(2),120,120))
axis image
title(['Noise Matrix follows',10,'N(0, 2)'])
colorbar
subplot(1,3,3)
imagesc(a60_noise)
axis image
colorbar
title(['simulated experimental',10,'image SNR=0.5'])
set(gcf,'PaperPositionMode','auto')
% print('-painters','-depsc', [path,'\1.eps'], '-r0');

figure(2)
subplot(2,2,1)
imagesc(a60_noise)
axis image
xlabel('(a)')
title('angle (60\circ,60\circ,60\circ)')
colorbar
subplot(2,2,2)
imagesc(a30_noise)
xlabel('(b)')
axis image
title('angle (60\circ,60\circ,30\circ)')
colorbar
subplot(2,2,3)
imagesc(a60_fft)
axis image
xlabel('(c)')
title(['angle (60\circ,60\circ,60\circ)',10,'in Fourier Space'])
colorbar
subplot(2,2,4)
imagesc(a30_fft)
axis image
xlabel('(d)')
title(['angle (60\circ,60\circ,30\circ)',10,'in Fourier Space'])
colorbar
set(gcf,'PaperPositionMode','auto')
% print('-painters','-depsc', [path,'\2.eps'], '-r0');

figure(4)
subplot(1,3,1)
imagesc(a60_fft_corr)
xlabel('(a)')
axis tight
title(['correlation image of', 10, 'angle (60\circ,60\circ,60\circ)'])
colorbar
subplot(1,3,2)
imagesc(a30_fft_corr)
xlabel('(b)')
axis tight
title(['correlation image of', 10, 'angle (60\circ,60\circ,30\circ)'])
colorbar
subplot(1,3,3)
imagesc( abs(diff ./ a60_fft_corr) )
xlabel('(c)')
axis tight
title(['error range of two correlation image',10,'abs(diff / image)'])
colorbar
set(gcf,'PaperPositionMode','auto')
% print('-painters','-depsc', [path,'\3.eps'], '-r0');
