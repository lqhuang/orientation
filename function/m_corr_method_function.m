function [subscript, varargout]= m_corr_method_function(exp_data, projection_cell, pcimg_interpolation, weight)
if exist('pcimg_interpolation', 'var') == 0;
    pcimg_interpolation = 'none';
end
if exist('weight', 'var') == 0;
    weight = 'none';
end

[nx, ny, nz] = size(projection_cell);

Corr = zeros(1,nx*ny);
C2_exp = m_corr_function_fft(exp_data, pcimg_interpolation, weight);
C2_exp(1, :) = [];  % 第一行有极大的误差

index_Corr = 1;

for i = 1:nx
    for j = 1:ny
        C2_projection = m_corr_function_fft(projection_cell{i,j,1}, pcimg_interpolation, weight);
        C2_projection(1, :) = []; % 第一行有极大的误差
        scale_factor = C2_exp(:) \ C2_projection(:);
        Corr(index_Corr)=sum( sum( (C2_exp - scale_factor * C2_projection ) .^2 ./ (-2 * C2_exp) ) );
        index_Corr = index_Corr + 1;
    end
end

% Corr = exp(Corr ./ 1e11 );

%% centrosymmetry effect
[~, index_sort] = sort(Corr);
index = index_sort(end-1 : end);

[sub_j, sub_i] = ind2sub([ny, nx], index);

Prob_k= zeros(length(sub_i), nz);
max_prob_k = zeros(1, length(sub_i));
sub_k = zeros(1, length(sub_i));

for n = 1: length(sub_i)
    for k = 1:nz
        Prob_k(n, k) = sum( sum( (exp_data - projection_cell{sub_i(n), sub_j(n), k}) .^2 ./ (-2 * exp_data) ) ) ;
    end
    max_prob_k(n) = max(Prob_k(n, :));
%     sub_k(n) = find( Prob_k(n, :) == max_prob_k(n) ); 原代码
    %%%%%%%   第三个角度里面也有手性？？...bug不太好复现
    t = find( Prob_k(n, :) == max_prob_k(n) ); %%???
    if length(t) ~= 1
        sub_k(n) = t(1);%
    else
        sub_k(n) = find( Prob_k(n, :) == max_prob_k(n) );
    end
end

max_sub = find( max_prob_k == max(max_prob_k) );

%% Output information
subscript = [sub_i; sub_j; sub_k]';
subscript = subscript(max_sub, :);

varargout{1}=Corr;
varargout{2}=Prob_k;
end