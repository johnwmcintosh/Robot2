include <robot_settings.scad>
use <parametric_ball_bearing.scad>
use <engine_holders.scad>
use <tire_apparatus.scad>
use <spring_library.scad>
use <OpenSCAD_Gear_Library_with_Customizer/files/gears.scad>;

$fn = 50;

module robot_rail() {
  
  difference() {
    // rail
    translate([rail_gap, 0, rail_gap])
    cube([rail_width - rail_gap * wall_thickness, rail_length, rail_thickness]);
    
    // cutout for gears
    translate([rail_width / 2, gears_setback_distance, rail_gap - 1])
    cylinder(h = rail_thickness + 2, r = 10.5);
    
    // cutout for tire apparatus
    translate([10, 31, .2])
    cylinder(h = rail_thickness + 3, r = 6);
     
    // cutout for tire apparatus
    translate([rail_width - 10, 31, .2])
    cylinder(h = rail_thickness + 3, r = 6);
  }

  translate([rail_width / 2, gears_setback_distance, rail_thickness/2])
  parametric_ball_bearing();

  // center post for gears
  translate([rail_width / 2, gears_setback_distance, -14]) {
    translate([0, 0, -(pinion_gear_width + rail_thickness) / 2])
    cylinder(h = gear_post_height + pinion_gear_width + 14, r = pinion_gear_bore / 2);
  }

  // upper gear
  translate([rail_width / 2, 32, rail_thickness + pinion_gear_width ])
  stirnrad(gears_module, pinion_gear_teeth, pinion_gear_width, pinion_gear_bore);

  // lower gear
  translate([rail_width / 2, 32, -18 ])
  stirnrad(gears_module, pinion_gear_teeth, pinion_gear_width , pinion_gear_bore);

  translate([-21, 31, -16])
  tire_apparatus(axle_length = axle_length, pull_bar_length = rail_width / 2 - rack_length / 2, post_height = 6, flip_spring = false);
   
  // rack
  color("blue")
  translate([rail_width / 2 + 1.5 , rack_width + 12, -18])
  rotate([0,0,0])
  zahnstange(rack_module, rack_length, rack_height, rack_width);
  
  translate([rail_width + 21, 31,  -16])
  rotate([180, 0, 180])
  tire_apparatus(axle_length = axle_length, pull_bar_length = rail_width / 2 - rack_length / 2, post_height = 6, flip_spring = true);
 
  translate([10, 31, 1.5])
  parametric_ball_bearing(
    ball_bearing_diameter = 2.5,
    ball_bearing_channel_diameter = 2.6,
    center_hole_radius = 2,
    inner_component_thickness = 2,
    outer_component_thickness = 2);
    
    translate([190, 31, 1.5])
    parametric_ball_bearing(
    ball_bearing_diameter = 2.5,
    ball_bearing_channel_diameter = 2.6,
    center_hole_radius = 2,
    inner_component_thickness = 2,
    outer_component_thickness = 2);
}
robot_rail();
