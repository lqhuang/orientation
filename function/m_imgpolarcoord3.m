function polar_img=m_imgpolarcoord3(img)
% IMGPOLARCOORD converts a given image from cartesian coordinates to polar
% coordinates.
%
% Input:
%      img  : bidimensional image.
%      radius : radius length (# of pixels to be considered).
%      Na: # of angles to be considered for decomposition.
%
% Output:
%       pcimg : polar coordinate image.
%
% Usage Example:
%  im=double(imread('cameraman.tif'));
%  fim=fft2(im);
%  pcimg=iapolarcoord(im);
%  fpcimg=iapolarcoord(fim);
%  figure; subplot(2,2,1); imagesc(im); colormap gray; axis image;
%  title('Input image');  subplot(2,2,2);
%  imagesc(log(abs(fftshift(fim)+1)));  colormap gray; axis image;
%  title('FFT');subplot(2,2,3); imagesc(pcimg); colormap gray; axis image;
%  title('Polar Input image');  subplot(2,2,4);
%  imagesc(log(abs(fpcimg)+1));  colormap gray; axis image;
%  title('Polar FFT');
%
% Notes:
%  The software is provided "as is", without warranty of any kind.
%  Javier Montoya would like to thank prof. Juan Carlos Gutierrez for his
%  support and suggestions, while studying polar-coordinates.
%  Authors: Juan Carlos Gutierrez & Javier Montoya.
%
% Image center:
% The center of rotation of a 2D image of dimensions xdim x ydim is defined
% by ((int)xdim/2, (int)(ydim/2)) (with the first pixel in the upper left 
% being (0,0). Note that for both xdim=ydim=65 and for xdim=ydim=64, the 
% center will be at (32,32). This is the same convention as used in SPIDER 
% and XMIPP. Origin offsets reported for individual images translate the 
% image to its center and are to be applied BEFORE rotations.
% 
% IN MATLAB
% Due to the first pixel in the upper left being (1,1), the center will be
% at (33, 33) for both xdim=ydim=65 and for xdim=ydim=64

if nargin < 1
    error('Please specify an image!');
end

img         = double(img);
[rows,cols] = size(img);

cy = floor(rows/2)+1;
cx = floor(cols/2)+1;
if floor(rows/2)-(rows/2) == 0
    radius = min([rows-cy, cols-cx]) + 1; % even size
else
    radius = min([rows-cy, cols-cx]); % odd size
end
angle = 360;

x_range = -radius+1:radius-1;
y_range = -radius+1:radius-1;
[x_grid, y_grid] = meshgrid(x_range, y_range);

rho_range = 0:radius-1;
theta_range = 0:2*pi/angle:2*pi-2*pi/angle;
[theta_grid, rho_grid] = meshgrid(theta_range, rho_range);
[new_x, new_y] = pol2cart(theta_grid, rho_grid);

z = img(2:cy+radius-1, 2:cx+radius-1);
polar_img = interp2(x_grid, y_grid, z, new_x, new_y, 'linear');