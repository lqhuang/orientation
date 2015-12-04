function  m_display_object(object)
%  a review for 3D object
%  Input:
%  filename: filename of map docmuments from EMDB
%  filter: decide detail filter of object
%  display: 0 or 1 decide to display object or not
%  Output:
%  projection: from model, 2d matrix, size defined by input object

p = patch(isosurface(object, 0.0001));
set(p, 'FaceColor', 'red', 'EdgeColor', 'none');
object_size = size(object);
axis([0 object_size(1) 0 object_size(2) 0 object_size(3)])
xlabel('x');
ylabel('y');
zlabel('z');
daspect([1 1 1]);
view(3)
% view(2) % for Z axis
grid on

end