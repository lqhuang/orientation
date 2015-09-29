function [Prob, subscript] = m_relion_function(exp_data, projection_cell)

[nx, ny, nz] = size(projection_cell);

Prob = [];

for i = 1 : nx
    for j = 1 : ny
        for k = 1 : nz
            scale_factor = exp_data(:) \ projection_cell{i,j,k}(:);
            Prob = [Prob, ...
               sum( sum( ( exp_data - scale_factor * projection_cell{i,j,k} ).^2 ./ (-2 .* exp_data ) ) )];
        end
    end
end

Prob = exp( Prob ./ 1e7);
index = find ( Prob == max(Prob) );
[sub_k, sub_j, sub_i] = ind2sub([nz, ny, nx], index);

subscript = [sub_i; sub_j; sub_k]';

end