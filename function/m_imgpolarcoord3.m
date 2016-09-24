function polar_img=m_imgpolarcoord3(img, xs, ys, cx, cy, radius, N_r, N_theta)
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

   if nargin < 1
      error('Please specify an image!');
   end
   
   img         = double(img);
   
   if exist('radius','var') == 0
      %radius = min(round(rows/2),round(cols/2))-1;
      radius = min(rows-cy, cols-cx, cx, cy)-1;
   end
   
   if exist('N_theta','var') == 0
      N_theta = 360;
   end
  
   xs = xs - cx;
   ys = ys - cy;

   [theta_i, r_i] = meshgrid(1:N_theta, 1:N_r);
 
   delta_angle = 2*pi/N_theta;
   delta_r     = radius/N_r;

   theta_array = theta_i * delta_angle;
   r_array     = r_i * delta_r;
   
   [new_x, new_y] = pol2cart(theta_array, r_array);
   
   polar_img = interp2(xs, ys, img, new_x, new_y, 'linear');

end
