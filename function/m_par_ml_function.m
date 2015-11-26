function [subscript, varargout] = m_par_ml_function(exp_projection, particle)
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
prob = zeors(1, nx*ny*nz);
simulated_projection = particle.simulated_projection;

parfor index = 1: nx*ny*nz
    sim_projection = simulated_projection{index};
    scale_factor = exp_projection(:) \ sim_projection(:);
    prob(index) = sum( sum( ( exp_projection - scale_factor * sim_projection ) .^2 ./ (-2 .* exp_projection) ) );
end

% normalization?.. is it right?
% minimum = min(prob);
% maximum = max(prob);
% likelihood = (prob-minimum)./(maximum-minimum);

index_of_max = find(prob == max(prob));
% [sub_k, sub_j, sub_i] = ind2sub([nz, ny, nx], max_index); % old method
[sub_i, sub_j, sub_k] = ind2sub([nx, ny, nz], index_of_max);

% output information
subscript = [sub_i; sub_j; sub_k]';
varargout{1} = prob;
end