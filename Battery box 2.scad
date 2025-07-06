include <tobsun_parts.scad>
include <robot_settings.scad>
use <support_angle.scad>
use <robot_rail.scad>

translate([0,0,6])
difference() {
    // battery box
    cube([main_box_x, main_box_y, main_box_z]);

    // battery box cutout    
    translate([wall_thickness, wall_thickness, wall_thickness])
    cube([main_box_x - 2 * wall_thickness, main_box_y + wall_thickness, main_box_z - 2 * wall_thickness]);

    // side windows
    translate([-wall_thickness, wall_thickness + 4 * wall_thickness, main_box_z / 4])
    cube([main_box_x + 2 * wall_thickness, main_box_y - 10 * wall_thickness, main_box_z / 2]);

    // back window
    translate([main_box_x / 4, -wall_thickness, main_box_z / 4])
    cube([main_box_x / 2, 4 * wall_thickness, main_box_z / 2]);
}

// tobsun
translate([main_box_x / 2 - tobsun_shelf_width / 2, main_box_y - tobsun_shelf_length, main_box_z + rail_gap + 2 * wall_thickness])
tobsun_tray();

// rail attachments
translate([0, 0, 0])
cube([rail_gap, main_box_y, rail_inset]);
cube([rail_inset, main_box_y, rail_gap]);

translate([main_box_x - rail_gap, 0, 0]) 
cube([rail_gap, main_box_y, rail_inset]);
translate([main_box_x - rail_inset, 0 ,0])
cube([rail_inset, main_box_y, rail_gap]);

