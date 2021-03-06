object = m_readMRCfile('../particle/EMD-6044.map');
object(object < 30.4) = 0;
S = m_projector(object, [60, 30, 60]);
S = ( S - mean(S(:)) ) / sqrt(var(S(:)));
e_sig = zeros(1,100);
ee_sig = zeros(1,100);
for i = 1:100
    for loop = 1:10

        N = random('norm', 0, sqrt(i), size(S,1), size(S,2));
        img = S + N;
        % img = ( img - mean(img(:)) ) / sqrt(var(img(:)));

        sigma2 = ones(size(S,1), size(S,2)) .* 5;

        C2_sigma2 = m_corr_function_fft(sigma2);
        C2_S = m_corr_function_fft(S);
        C2_N = m_corr_function_fft(N);
        C2_img = m_corr_function_fft(img);

        e = (C2_img - C2_S);
        e_sig(i) =  e_sig(i) +  var(e(:)) ;
        
        l = C2_N - e;
%         ee = ( img - S ) ;
%         ee_sig(i) = ee_sig(i) + var(ee(:));
    end
end

figure(1)
subplot(1,2,1)
plot(1:100, [1:100].^2 * 360, '-o')
subplot(1,2,2)
plot(1:100, e_sig./10, '-o')
