function [subscript, varargout] = m_par_ML_function(exp_projection, particle)
% parallel version of Maximum Likelihood method in orientation
% input:
% exp_projection: experiment image need to orientate
% particle: struct of particle information. 
%           PAY ATTENTION: all simulated projections are saved as
%           cell format.
% output:
% subscript: the subscript in simulated_projection.
% prob(optional): maximum likelihood probability.

nx = particle.simulated_size(1);
ny = particle.simulated_size(2);
nz = particle.simulated_size(3);
prob = zeros(1, nx*ny*nz);
reference_projections = particle.simulated_projection;

parfor index = 1: nx*ny*nz
    ref_projection = reference_projections{index};
    scale_factor = exp_projection(:) \ ref_projection(:);
    exp_up_term = ( exp_projection - scale_factor * ref_projection ) .^2 ./ ( -2 .* exp_projection );
    exp_up_term(isnan(exp_up_term)) = 0;
    exp_up_term(isinf(exp_up_term)) = 0;
    prob(index) = sum( exp_up_term(:) );
end

[prob_sort, index_sort] = sort(prob, 'descend');
diff_prob_sort = diff(prob_sort);
num_of_max = find( diff_prob_sort(1:24) == min(diff_prob_sort(1:24)) );
index_of_max = index_sort(1:num_of_max);

% [sub_k, sub_j, sub_i] = ind2sub([nz, ny, nx], max_index); % old method way depend on the forloop
[sub_i, sub_j, sub_k] = ind2sub([nx, ny, nz], index_of_max);

% output information
subscript = [sub_i; sub_j; sub_k]';
varargout{1} = prob;
end