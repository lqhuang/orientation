function pcimg_cell = m_initial_particle_pcimg(particle, pcimg_method, weight)
% in:
% out:

% create simulated projections
% set intervals of siMLated projections
step = particle.step;
theta = particle.theta;
psi = particle.psi;
phi = particle.phi;

% save projections into a cell
num_theta = length(theta);
num_psi = length(psi);
% num_phi = length(phi);

pcimg_cell = cell(num_theta, num_psi);
disp('begin to caculate projection');
parfor i = 1: num_theta
    for j = 1:num_psi
        pcimg_cell{i,j} = m_corr_function_fft(particle.simulated_projection{i,j,1}, pcimg_method, weight);
        disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(1)])
    end
end


end