function particle = m_initial_particle(filter)
% in:
% out:

% read EMD map file
[filename, filepath] = uigetfile([pwd,'\particle\*'],'Select the EMD map file')
file = [filepath,filename];
object = m_readMRCfile(file);

object(object < filter) = 0; % filter

% Does the object need to resize or not

resize_radius = input('radius after resize object, default as a cube, input a number is better:')
object_size = size(object);
object_radius = round(object_size(1)/2)-1;
resize_range = object_radius-resize_radius+1 : object_radius+resize_radius;
object = object(resize_range, resize_range, resize_range);
close


% create simulated projections
% set intervals of simlated projections
step = 7;
while mod(180, step) not 0
step = input('input interval of projection:');
if mod(180, step) == 0
    theta = 0 : step : 360;
    psi = 0 : step : 180;
    phi = 0 : step : 360;
else
    disp('this interval is not allowed, please input again.')
end
end

% save projections into a cell
num_theta = length(theta);
num_psi = length(psi);
num_phi = length(phi);

projection = cell(num_theta, num_psi, num_phi);
disp('begin to caculate projection');
parfor i = 1: num_theta
    for j = 1:num_psi
        for k = 1:num_phi
            projection{i,j,k} = m_projector(object, [theta(i), psi(j), phi(k)]);
            disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(k)]);
        end
    end
end


% normalize projection cell value
maximum_value = find_max_value(projection);
if maximum_value >= 255
    for i = 1: num_theta
        for j = 1:num_psi
            for k = 1:num_phi
                projection{i,j,k} = projection{i,j,k} ./ maximum_value .* 255;
            end
        end
    end
end


% output information:
particle = struct;
particle.filename = filename;
particle.fileter = filter;
particle.simulated_projection = projection;
particle.step = step;
particle.siumlated_size = [num_theta, num_psi, num_phi];
particle.object = object;
particle.theta = theta;
particle.psi = psi;
particle.phi = phi;
particle.maximum_value = maximum_value;
end

function maximum = find_max_value(projection)
[nx, ny, nz] = size(projection);
maximum = 0;
for i = 1:nx
    for j = 1:ny
        for k = 1:nz
           
            max_value = max( max( projection{i,j,k} ) );
%             min_value = min( min( projection{i,j,k} ) );
            if max_value > maximum
                maximum = max_value;
            end
           
        end
    end
end
end