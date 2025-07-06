include <robot_settings.scad>
use <engine_holders.scad>

module robot_rail() {
    // rail
    translate([rail_gap, 0, rail_gap])
    cube([main_box_x - rail_gap * wall_thickness, rail_length, rail_thickness]);
}

translate([-20, 0, 0])
engine_holder_cutouts();
robot_rail();