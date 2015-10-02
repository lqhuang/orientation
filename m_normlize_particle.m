function norm_object = normlize_particle(object);

[nx,ny,nz]=size(object);

maximum = max(max(max(object)));

object = object./maximum;


end