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
simulated_projection = particle.simulated_projection;
sigma2 = particle.sigma2; % ugly code

parfor index = 1: nx*ny*nz
    sim_projection = simulated_projection{index};
    scale_factor = exp_projection(:) \ sim_projection(:);
%     prob(index) = sum( sum( ( exp_projection - scale_factor * sim_projection ) .^2 ) ) ./ ( -2 .* var(exp_projection(:)) );
    prob(index) = sum( sum( ( exp_projection - scale_factor * sim_projection ) .^2 ) ) ./ ( -2 .* sigma2 );
end

% normalization?.. is it right?

% index_of_max = find(prob == max(prob));
[~, index_sort] = sort(prob);
index_of_max = index_sort(end-1 : end);


% [sub_k, sub_j, sub_i] = ind2sub([nz, ny, nx], max_index); % old method way depend on the forloop
[sub_i, sub_j, sub_k] = ind2sub([nx, ny, nz], index_of_max);

% output information
subscript = [sub_i; sub_j; sub_k]';
varargout{1} = prob;
end