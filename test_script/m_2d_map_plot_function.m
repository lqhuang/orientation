function [varargout] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, method, pcimg_interpolation, weight)

matrix_size = size(sim_projection_matrix);
leng = matrix_size(3);
prob = zeros(1,leng);
corr = zeros(1,leng);

C2_exp = m_corr_function_fft(exp_projection);
C2_exp(1,:) = [];

parfor index = 1:leng
	sim_projection = sim_projection_matrix(:,:,index);
	switch method
	case  'ml'
		scale_factor = exp_projection(:) \ sim_projection(:);
		prob(index) = sum( sum( ( exp_projection - scale_factor * sim_projection ) .^2 ./ (-2 .* exp_projection) ) );
	case  'correlation'
		C2_sim = m_corr_function_fft(sim_projection, pcimg_interpolation, weight);
		C2_sim(1,:) = [];
		scale_factor = C2_exp(:) \ C2_sim(:);
		corr(index)=sum( sum( (C2_exp - scale_factor * C2_sim ) .^2 ./ (-2 * C2_exp) ) );
	end
end

% output information
switch method
case  'ml'
varargout{1} = prob;
case 'correlation'
varargout{1} = corr;
end

end