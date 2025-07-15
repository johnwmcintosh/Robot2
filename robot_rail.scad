include <robot_settings.scad>
use <parametric_ball_bearing.scad>
use <engine_holders.scad>
use <tire_apparatus.scad>
use <BY_CRC_absorber.scad>
use <lock_cap_on_cylinder.scad>
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
    cylinder(h = rail_thickness + 3, r = 5);
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

  translate([-21, 31, -15])
  tire_apparatus(axle_length = axle_length, pull_bar_length = rail_width / 2 - rack_length / 2);
   
  // rack
  color("blue")
  translate([rail_width / 2 + 1.5 , rack_width + 12, -rail_thickness - rack_width / 4])
  rotate([0,0,0])
  zahnstange(rack_module, rack_length, rack_height, rack_width);
  
  translate([rail_width + 21, 31,  -15])
  rotate([180, 0, 180])
  tire_apparatus(axle_length = axle_length, pull_bar_length = rail_width / 2 - rack_length / 2);
  
  // apparatus to frame post
  translate([5, -22, 2.2])
  cylinder(h = rail_thickness + 4, r = 1);

  // apparatus to frame post
  translate([90.5, -22, .2])
  cylinder(h = rail_thickness + 3, r = 1);
  
  translate([10, -31, 4])
  shock_absorber();
  
  
// Assembly
translate([10, 31, -2])
  base_with_l_notch();

translate([0, -10, 0])
cap_with_four_lugs();
}
robot_rail();
