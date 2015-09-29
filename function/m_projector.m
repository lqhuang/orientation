function [projection, varargout] = m_projector(object, euler_angle)
%  create a projection in certain Euler angle of object
%  Input:
%  object: model to be project, 3d matrix
%  euler_angle: the orientation of the slice plane in degree
%  Output:
%  projection:  from model, 2d matrix, size defined by input object

% rotate matrix
object_size = size(object);
center = round(object_size/2);

% T1. Translate the center of the object to the origin.
% T2. Rotate the object.
% T3. Translate the rotated object back to its starting location.
T1 = [1  0  0  0;
      0  1  0  0;
      0  0  1  0;
      -center  1];
T2 = m_eul2tform(euler_angle);
T3 = [1  0  0  0;
      0  1  0  0;
      0  0  1  0;
       center  1];
T = T1 * T2 * T3;
tform = maketform('affine', T);
R = makeresampler('linear', 'fill'); % resampler
TDIMS_A = [1 2 3];
TDIMS_B = [1 2 3];
output_size = object_size;
TMAP_B = [];
F = 0;
robject = tformarray(object, tform, R, TDIMS_A, TDIMS_B, output_size, TMAP_B, F); % key function
projection(:,:) = sum(robject, 3);

% output rotated object
varargout{1} = robject;

end

function T = m_eul2tform(euler_angle)
% Rotation Matrix in ZXZ
% input euler_angle in degree
euler_angle = deg2rad(euler_angle);
Rx=@(t)[1 0 0 0;
        0 cos(t) -sin(t) 0;
        0 sin(t)  cos(t) 0;
        0 0 0 1];
Rz=@(t)[cos(t) -sin(t) 0 0;
        sin(t)  cos(t) 0 0;
        0 0 1 0;
        0 0 0 1];
T = Rz(euler_angle(1)) * Rx(euler_angle(2)) * Rz(euler_angle(3));
end

function rad = deg2rad(deg)
rad = deg * pi / 180;
end