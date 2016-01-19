function pcimg_cell = m_initial_particle_pcimg(particle, pcimg_method, weight)
% in:
% out:

% create simulated projections
% set intervals of siMLated projections
theta = particle.theta;
psi = particle.psi;
% phi = particle.phi;

% save projections into a cell
num_theta = length(theta);
num_psi = length(psi);
% num_phi = length(phi);

pcimg_cell = cell(num_theta, num_psi);
sim_projection_cell = cell(num_theta, num_psi);
sim_projection_cell(:,:) = particle.simulated_projection(:,:,1);
disp('begin to caculate projection');
parfor index = 1 : num_theta * num_psi
    pcimg_cell{index} = m_corr_function_fft(sim_projection_cell{index}, pcimg_method, weight);
    [i,j] = ind2sub([num_theta, num_psi], index);
    disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(1)])
end

end