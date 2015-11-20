function [subscript, varargout] = m_relion_function(exp_projection, projection_cell)

[nx, ny, nz] = size(projection_cell);
prob = zeros(1, nx*ny*nz);
prob_index = 1;

for i = 1 : nx
    for j = 1 : ny
        for k = 1 : nz
            scale_factor = exp_projection(:) \ projection_cell{i,j,k}(:);
            prob(prob_index) = sum( sum( ( exp_projection - scale_factor * projection_cell{i,j,k} ) .^2 ./ (-2 .* exp_projection) ) );
            prob_index = prob_index + 1;
        end
    end
end

% normalization?.. is it right?
minimum = min(prob);
maximum = max(prob);
likelihood = (prob-minimum)./(maximum-minimum);

index = find(prob == max(prob));
[sub_k, sub_j, sub_i] = ind2sub([nz, ny, nx], index);

% output information
subscript = [sub_i; sub_j; sub_k]';
varargout{1} = likelihood;
end