function [subscript, varargout] = m_par_relion_function(exp_projection, particle)

nx = particle.simulated_size(1);
ny = particle.simulated_size(2);
nz = particle.simulated_size(3);
prob = zeors(1, nx*ny*nz);

for index = 1: nx*ny*nz
    sim_projection = particle.simulated_projection(:,:,index);
    scale_factor = exp_projection(:) \ sim_projection(:);
    prob(index) = sum( sum( ( exp_projection - scale_factor * sim_projection ) .^2 ./ (-2 .* exp_projection) ) );
end

% normalization?.. is it right?
% minimum = min(prob);
% maximum = max(prob);
% likelihood = (prob-minimum)./(maximum-minimum);

index = find(prob == max(prob));
[sub_k, sub_j, sub_i] = ind2sub([nz, ny, nx], index);

% output information
subscript = [sub_i; sub_j; sub_k]';
varargout{1} = prob;
end