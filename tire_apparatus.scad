use <axle.scad>
use <pull_bar.scad>
use <parametric_ball_bearing.scad>
$fn = 50;

module tire_apparatus(
  axle_length = 35,
  armature_holder_height = 2,
  armature_holder_width = 8,
  armature_holder_thickness = 7,
  pull_bar_length = 25
) 
{
  axle(fitted_sides = 1, axle_length = axle_length);

translate([0, 1, 0])
  difference() {
      // armature holder
      translate([axle_length -2, -11.5, 3.5])
      rotate([0, 90, 0])
      cube([armature_holder_thickness , armature_holder_width, armature_holder_height]);
   
     color("blue")
     translate([axle_length - armature_holder_height - .1,  -.5, -0])
     rotate([0, 90, 0])
     cylinder(h = armature_holder_height + .2, r = 4.5);
     
     // hole for armature grab bar 
     translate([axle_length - 3, -armature_holder_width -1,  0])
     rotate([0, 90, 0])
     cylinder(h = 4, r = 2);
    }
 
  // armature grab bar
  translate([axle_length + armature_holder_height / 2 - 2, -armature_holder_width ,  -3])
  cylinder(h = 6, r = .4);
  
  translate([axle_length - 4, 0, 0])
  rotate([0, 90, 0])
  parametric_ball_bearing(1.5, 1.6, 1.5, 1.5, 1.5);

  translate([axle_length - 1, -armature_holder_width, 0]) 
  pull_bar(pull_bar_length);
}
tire_apparatus();
