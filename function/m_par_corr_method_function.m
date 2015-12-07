function [subscript, varargout]= m_par_corr_method_function(exp_projection, particle, pcimg_cell, pcimg_interpolation, weight)
% parallel version of Correlation-ML method in orientation
% input:
% exp_projection: experiment image need to orientate
% particle: struct of particle information. 
%           PAY ATTENTION: all simulated projections are saved as
%           matrix format. And the index increasing in order of
%           phi(k), psi(j), thata(i)
% pcimg_cell: all C2 image in polar cart should calculate previously
% pcimg_interpolation: the interpolation method in creating C2 image.
% weight: weight method in C2 image.
% output:
% subscript: the subscript in simulated_projection.
% corr(optional): corrlation-maximum likelihood probability.
% prob_k(optional): maximum likelihood probability in Phi angle.

if exist('pcimg_interpolation', 'var') == 0;
    pcimg_interpolation = 'none';
end
if exist('weight', 'var') == 0;
    weight = 'none';
end

nx = particle.simulated_size(1);
ny = particle.simulated_size(2);
nz = particle.simulated_size(3);

Corr = zeros(1,nx*ny);
C2_exp = m_corr_function_fft(exp_projection, pcimg_interpolation, weight);
C2_exp(1, :) = [];  % extreme error happens in first line

parfor index = 1:nx*ny
    C2_sim = pcimg_cell{index};
    C2_sim(1, :) = []; % extreme error happens in first line
    scale_factor = C2_exp(:) \ C2_sim(:);
    Corr(index)=sum( sum( (C2_exp - scale_factor * C2_sim ) .^2 ./ (-2 * C2_exp) ) );
end

% normlization ????
% minimum = min(Corr);
% maximum = max(Corr);
% Corr = (Corr-minimum)./(maximum-minimum);

% centrosymmetry problem
[~, index_sort] = sort(Corr);
index_of_max = index_sort(end-1 : end);

[sub_i, sub_j] = ind2sub([nx, ny], index_of_max);

Prob_k= zeros(length(sub_i), nz);
max_prob_k = zeros(1, length(sub_i));
sub_k = zeros(1, length(sub_i));

for n = 1:length(sub_i)
    simulated_projection_k = cell(1, nz);
    simulated_projection_k(:) = particle.simulated_projection(sub_i(n), sub_j(n), :);
    parfor k = 1:nz
        Prob_k(n, k) = sum( sum( (exp_projection - simulated_projection_k{k}) .^2 ./ (-2 * exp_projection) ) ) ;
    end
    max_prob_k(n) = max(Prob_k(n, :));
%     sub_k(n) = find( Prob_k(n, :) == max_prob_k(n) ); % 原代码
%%% 第三个角度出现多个相同最大值？？...bug不太好复现
    t = find( Prob_k(n, :) == max_prob_k(n) ); %%???
    if length(t) ~= 1
        sub_k(n) = t(1); 
        disp('There are more than one max Phi angle found')
    else
        sub_k(n) = t;
    end
end

max_sub =  max_prob_k == max(max_prob_k); % tricky method instead of ''max_sub = find( max_prob_k == max(max_prob_k) );''

% normalization ???
% minimum = min(max_prob_k);
% maximum = max(max_prob_k);
% max_prob_k = (max_prob_k-minimum)./(maximum-minimum);

% Output information
subscript = [sub_i; sub_j; sub_k]';
subscript = subscript(max_sub, :);

varargout{1}=Corr;
varargout{2}=Prob_k;
end