a1 = particle.simulated_projection{4,5,6};
% a2 = particle.simulated_projection{4,3,4};
% a1 = poissrnd(a1);
b = pcimg_cell{2,3};

a1_C2 = m_corr_function_fft(a1);
a2_C2 = m_corr_function_fft(a2);

figure(1)
imagesc( (a1_C2 - b) ./ a_C2 );
colorbar


figure(2)
imagesc(a);
axis image

figure(3)
% [script, prob] = m_par_ML_function(a1, particle);
[script, prob, prob_k] = m_par_corr_method_function(a1, particle, pcimg_cell);
script
[prob_sort, index_sort] = sort(prob,'descend');
subplot(1,4,1)
plot(prob)
subplot(1,4,2)
plot(prob_sort);
subplot(1,4,3);
plot(1:length(prob_k), prob_k)
subplot(1,4,4)
plot(diff(prob_sort));
