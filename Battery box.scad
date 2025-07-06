include <tobsun_parts.scad>
use <support_angle.scad>

main_box_x = 94;
main_box_y = 74;
main_box_z = 100;
wall_thickness = 2;

translate([0,0,6])
difference() {
// battery box
cube([main_box_x, main_box_y, main_box_z]);

// battery box cutout    
translate([wall_thickness, wall_thickness, wall_thickness])
cube([main_box_x - 2 * wall_thickness, main_box_y - 2 * wall_thickness, main_box_z]);

// front back windows
translate([2, -2, 25])
cube([90, 78, 42]);

// size windows
translate([-2, 15, 40])
cube([98, 45, 50]);
}

// tobsun
translate([main_box_x / 2 - tobsun_shelf_width / 2, main_box_y, main_box_z - tobsun_shelf_height])
tobsun_tray();

// tobsun support
translate([main_box_x / 2, main_box_y - 11, 5])
support_angle(102, 6, [90,45,90]);

// rail
translate([0, 0, 0])
cube([2, main_box_y, 7]);
cube([7, main_box_y, 2]);

translate([main_box_x - 2, 0, 0]) 
cube([2, main_box_y, 7]);
translate([main_box_x - 7, 0 ,0])
cube([7, main_box_y, 2]);

