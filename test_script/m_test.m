figure(10)

S = EMD_6044_30.simulated_projection{2,2,2};
S = ( S - mean(S(:)) ) / sqrt(var(S(:)));
N = random('norm', 0, sqrt(10), 120, 120);
img = S + N;
img = ( img - mean(img(:)) ) / sqrt(var(img(:)));

subplot(1,3,1)
imshow(S,[])
title('S')
colorbar
subplot(1,3,2)
imshow(N,[])
title('N')
colorbar
subplot(1,3,3)
imshow(img,[])
title('Final image')
colorbar