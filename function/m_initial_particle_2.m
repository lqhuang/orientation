function particle = m_initial_particle_2(file, filter, step, space, interpolation, resize_radius)
% use to initial a EMD object
% In:
% file: input file. Full filepath and filename is required(.map format).
% filter: filter number of object
% fft: create fourier space or not
% Out:
% particle: struct format. inlude different information

% check input information
if exist('space','var') == 0
    space = 'none';
end
if exist('resize_radius','var') == 0
    resize_radius = 0;
end

% set intervals of simlated projections
if mod(180, step) == 0
    theta = 0 : step : 360;
    psi = 0 : step : 180;
    phi = 0 : step : 360;
else
    disp('this interval is not recommended, please consider to input again.')
    error('step can not be divided by 360 degree')
end

% read EMD map file
object = m_readMRCfile(file);
object(object < filter) = 0; % filter

% Does the object need to resize or not
object_size = size(object);
disp(['The size of object now is ', num2str(object_size(1))]);
if resize_radius == 0
else
    resize_radius = input('radius after resize object, default as a cube, input a number is better:');
    object_radius = round(object_size(1)/2)-1;
    resize_range = object_radius-resize_radius+1 : object_radius+resize_radius;
    object = object(resize_range, resize_range, resize_range);
    disp('resize successful.')
end

% create simulated projections
% save projections into a cell
num_theta = length(theta);
num_psi = length(psi);
num_phi = length(phi);

projection = cell(num_theta, num_psi, num_phi);
disp('begin to caculate projection');

switch space
    case 'real'
        parfor index = 1 : num_theta * num_psi * num_phi
            [i, j, k] = ind2sub([num_theta, num_psi, num_phi], index);
            reprojection = m_projector(object, [theta(i), psi(j), phi(k)], interpolation);
            projection{index} = reprojection + 1; % real space case
            disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(k)]);
        end
    case 'fourier'
        parfor index = 1 : num_theta * num_psi * num_phi
            [i, j, k] = ind2sub([num_theta, num_psi, num_phi], index);
            reprojection = m_projector(object, [theta(i), psi(j), phi(k)], interpolation);
%             mat_mean = mean(reprojection(:));
%             mat_var = var(reprojection(:));
            projection{index} = m_oversampler; % fourier space case
            disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(k)]);
        end
end

% output information:
particle = struct;
particle.file = file;
particle.filter = filter;
particle.simulated_projection = projection;
particle.step = step;
particle.simulated_size = [num_theta, num_psi, num_phi];
particle.object = object;
particle.theta = theta;
particle.psi = psi;
particle.phi = phi;
particle.space = space;
if strcmp(space, 'fourier')
    particle.oversampling_factor = factor;
end
end
