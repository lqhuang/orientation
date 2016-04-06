function particle = m_initial_particle(file, filter, step, space, interpolation, resize_radius)
% use to initial a EMD object
% In:
% file: input file. Full filepath and filename is required(.map format).
% filter: filter number of object
% fft: create fourier space or not
% Out:
% particle: struct format. inlude different information
% Angle Conventions
% The first rotation is denoted by phi or rot and is around the Z-axis.
% The second rotation is called theta or tilt and is around the new Y-axis.
% The third rotation is denoted by psi and is around the new Z axis

% check input information
if exist('space','var') == 0
    space = 'real';
end
if exist('interpolation','var') == 0
    space = 'linear';
end
if exist('resize_radius','var') == 0
    resize_radius = 0;
end

% set intervals of simlated projections
if mod(180, step) == 0
    phi = 0 : step : 360 - step;
    theta = 0 : step : 180;
    psi = 0 : step : 360 - step;
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
num_phi = length(phi);
num_theta = length(theta);
num_psi = length(psi);

projection = cell(num_phi, num_theta, num_psi);
disp('begin to caculate projection');

switch space
    case 'real'
        parfor index = 1 : num_phi * num_theta * num_psi
            [i, j, k] = ind2sub([num_phi, num_theta, num_psi], index);
            reprojection = m_projector(object, [phi(i), theta(j), psi(k)], interpolation);
            mat_mean = mean(reprojection(:));
            mat_var = var(reprojection(:));
            projection{index} = (reprojection - mat_mean) ./ sqrt(mat_var); % real sapce case
            disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(k)]);
        end
    case 'fourier'
        oversampling_factor = 5;
        parfor index = 1 : num_phi * num_theta * num_psi
            [i, j, k] = ind2sub([num_phi, num_theta, num_psi], index);
            reprojection = m_projector(object, [phi(i), theta(j), psi(k)], interpolation);
            mat_mean = mean(reprojection(:));
            mat_var = var(reprojection(:));
            norm_projection = (reprojection - mat_mean) ./ sqrt(mat_var);
            projection{index} = m_oversampler(norm_projection, oversampling_factor); % fourier space case
            disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(k)]);
        end
end

% output information:
particle = struct;
particle.file = file;
particle.filter = filter;
particle.simulated_projection = projection;
particle.step = step;
particle.simulated_size = [num_phi, num_theta, num_psi];
particle.object = object;
particle.phi = phi;
particle.theta = theta;
particle.psi = psi;
particle.space = space;
if strcmp(space, 'fourier')
    particle.oversampling_factor = oversampling_factor;
end
end
