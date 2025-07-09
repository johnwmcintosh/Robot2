include <robot_settings.scad>
use <ball_bearing.scad>
use <engine_holders.scad>
use <OpenScad Rack & Pinion generator/files/Rack_and_pinion_-_with_backboard_and_end_stops.scad>;
$fn = 50;

module robot_rail() {
  difference() {
    // rail
    translate([rail_gap, 0, rail_gap])
    cube([main_box_x - rail_gap * wall_thickness, rail_length, rail_thickness]);
    

    translate([main_box_x / 2, 22, rail_gap - 1])
    cylinder(h = rail_thickness + 2, r = 19.5);
    
  }
}

translate([main_box_x / 2, 22, rail_thickness])
ball_bearing();

translate([-20, 0, 0])
engine_holder_cutouts();
robot_rail();


translate([32, 12,-3.8])
InvoluteGear_rack();


translate([main_box_x / 2, 22, -1.5]) {
  gear(hole_diameter = pinion_gear_hole_diameter, thickness = pinion_gear_thickness);
  translate([0,0,-pinion_gear_thickness +  pinion_gear_thickness / 2])
  cylinder(h = 2 * pinion_gear_thickness + rail_thickness, r = pinion_gear_hole_diameter / 2);
  translate([0,0,rail_thickness + pinion_gear_thickness])
  gear(hole_diameter = pinion_gear_hole_diameter, thickness = pinion_gear_thickness);
}
