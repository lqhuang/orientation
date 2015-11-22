function [subscript, varargout] = m_par_relion_function(exp_projection, projection_cell)

[nx, ny, nz] = size(projection_cell);
prob = zeors(1, nx*ny*nz);
m = zeros(nx,ny,10000);
parfor index = 1: nx*ny*nz
    img = m(:,:,index);
    [k, j, i] = ind2sub([nz, ny, nx], index);
    sim_projection = projection_cell{i,j,k};
    scale_factor = exp_projection(:) \ (:);
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