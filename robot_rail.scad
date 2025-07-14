include <robot_settings.scad>
use <parametric_ball_bearing.scad>
use <engine_holders.scad>
use <tire_apparatus.scad>
use <BY_CRC_absorber.scad>
use <OpenSCAD_Gear_Library_with_Customizer/files/gears.scad>;
$fn = 50;

module robot_rail() {
  
  difference() {
    // rail
    translate([rail_gap, 0, rail_gap])
    cube([main_box_x - rail_gap * wall_thickness, rail_length, rail_thickness]);
    
    // cutout for gears
    translate([main_box_x / 2, gears_setback_distance, rail_gap - 1])
    cylinder(h = rail_thickness + 2, r = 10.5);
    
    // cutout for tire apparatus
    translate([5, 22, .2])
    cylinder(h = rail_thickness + 3, r = 1.8);
  }

  translate([main_box_x / 2, gears_setback_distance, rail_thickness/2])
  parametric_ball_bearing();

  // center post for gears
  translate([main_box_x / 2, gears_setback_distance, -.5]) {
    translate([0, 0, -(pinion_gear_width + rail_thickness) / 2])
    cylinder(h = gear_post_height + pinion_gear_width, r = pinion_gear_bore / 2);
  }

  // upper gear
  translate([main_box_x / 2, 32, rail_thickness + pinion_gear_width ])
  stirnrad(gears_module, pinion_gear_teeth, pinion_gear_width, pinion_gear_bore);

  // lower gear
  translate([main_box_x / 2, 32, -rail_thickness - pinion_gear_width / 4 ])
  stirnrad(gears_module, pinion_gear_teeth, pinion_gear_width , pinion_gear_bore);

  translate([-21, 22, -3])
  tire_apparatus(axle_length = 28);
   
  // rack
  color("blue")
  translate([main_box_x / 2 + 1.5 ,rack_width + 12, -rail_thickness - rack_width / 4])
  rotate([0,0,0])
  zahnstange(rack_module, rack_length, rack_height, rack_width);
  
  translate([116.5, 22,  -3])
  rotate([180, 0, 180])
  tire_apparatus(axle_length = 28);
  
  // apparatus to frame post
  translate([5, 22, 2.2])
  cylinder(h = rail_thickness + 4, r = 1);

  // apparatus to frame post
  translate([90.5, 22, .2])
  cylinder(h = rail_thickness + 3, r = 1);
  
  translate([5, 22, 5.3])
  shock_absorber();
}
robot_rail();
