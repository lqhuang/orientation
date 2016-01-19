function a = m_readMRCfile(file)
% readMRCfile readMRCfile (fname) 
%
% http://ami.scripps.edu/software/mrctools/mrc_specification.php
% nx, ny, nz means number of x, y, z;
%

[fid, ~] = fopen(file, 'r');
if fid == -1
    error('can''t open file');
    a = -1;
    return;
end
nx = fread(fid, 1, 'long');
ny = fread(fid, 1, 'long');
nz = fread(fid, 1, 'long');
type = fread(fid, 1, 'long');
fprintf(1, 'nx= %d ny= %d nz= %d type= %d \n', nx, ny, nz, type);
% Seek to start of data
status = fseek(fid, 1024, -1);
% Shorts
if type == 1
    a = fread(fid, nx * ny * nz, 'int16');
end
% floats
if type == 2
    a =fread(fid,nx*ny*nz,'float32');
end
fclose(fid);
a = reshape(a, [nx ny nz]);
if nz == 1
    a = reshape(a, [nx ny]);
end
end