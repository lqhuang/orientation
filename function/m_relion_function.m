function [Prob, subscript] = m_relion_function(exp_data, projection_cell)

[nx, ny, nz] = size(projection_cell);
Prob = zeros(1, nx*ny*nz);
Prob_index = 1;

for i = 1 : nx
    for j = 1 : ny
        for k = 1 : nz
            scale_factor = exp_data(:) \ projection_cell{i,j,k}(:);
            Prob(Prob_index) = sum( sum( ( exp_data - scale_factor * projection_cell{i,j,k} ) .^2 ./ (-2 .* exp_data) ) );
            Prob_index = Prob_index + 1;
        end
    end
end

index = find ( Prob == max(Prob) );
[sub_k, sub_j, sub_i] = ind2sub([nz, ny, nx], index);
subscript = [sub_i; sub_j; sub_k]';
end