use <axle.scad>
use <pull_bar.scad>
use <parametric_ball_bearing.scad>
use <spring_library.scad>
$fn = 50;

module tire_apparatus(
  axle_length = 35,
  armature_holder_height = 9,
  armature_holder_thickness = 4,
  armature_holder_width = 14,
  pull_bar_length = 25,
  flip_spring = false,
  post_height = 10
) 
{
  armature_edge = armature_holder_width +  19.1 / 2;
  
  axle(fitted_sides = 1, axle_length = axle_length);

  translate([axle_length - 4, 0, 0])
  rotate([0, 90, 0])
  parametric_ball_bearing();

difference() { 
    translate([axle_length - armature_holder_thickness,  - armature_edge,  -armature_holder_height / 2])
    cube([armature_holder_thickness, armature_holder_width, armature_holder_height]);
  
    translate([axle_length - armature_holder_thickness - 3,  -armature_edge + armature_holder_width / 2 - 1.5,  0])
    rotate([0, 90, 0])
    cylinder(h = 10, r = 3);
}

  // armature grab bar
    translate([axle_length -  armature_holder_thickness / 2,  -armature_edge + armature_holder_width / 2 - 1.5,  -3])
  cylinder(h = 6, r = 1.25);

  translate([axle_length - 1.75, -armature_edge+ (armature_holder_width / 2)  - 1.5, 0]) 
  pull_bar(pull_bar_length);

  flip = flip_spring ?  -1 : 1;
  translate([axle_length + armature_holder_thickness / 2 - 4, 0, flip * 15])
  springLeaf(3, 30, 2, .4);

  spring_z = flip_spring ? 16.9  : 16.9;
  translate([axle_length + armature_holder_thickness / 2 - 4, 0, flip * spring_z])
   rotate([flip_spring ? 180 : 0, 0, 0])
  cylinder(h = post_height, r = 2);
}
tire_apparatus();
