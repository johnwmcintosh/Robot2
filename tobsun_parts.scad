$fa=1;
$fs=0.4;

////////////////////////////////////////////////
tobsun_shelf_width = 67.914;
tobsun_shelf_length = 59.96;
tobsun_shelf_height = 33.02;

cutout_radius = 8.08;
wall_thickness = 2;

module tobsun_tray() {
    difference() {
        translate([0, 0, 0])
        cube([tobsun_shelf_width, tobsun_shelf_length, tobsun_shelf_height]);
        
        // cut out
        translate([wall_thickness, wall_thickness, wall_thickness])
        cube([tobsun_shelf_width - 2 * wall_thickness, tobsun_shelf_length - 2 * wall_thickness, tobsun_shelf_height]);
        
        // tobsun tray wire cutout
        translate([tobsun_shelf_width / 3 + 4, tobsun_shelf_length + wall_thickness, tobsun_shelf_height / 2])
        rotate([90,0,0])
        cylinder(h=4 * wall_thickness, r=cutout_radius);
        
        // tobsun tray wire cutout
        translate([tobsun_shelf_width * 2/3, tobsun_shelf_length + wall_thickness, tobsun_shelf_height / 2])
        rotate([90,0,0])
        cylinder(h=4 * wall_thickness, r=cutout_radius);
    }
}
//tobsun_tray();

////////////////////////////////////////////////
module tobsun_chassis_cutout() {
    tobsun_chassis_cutout_width = 73.914;
    tobsun_chassis_cutout_length = 71.12;
    tobsun_chassis_cutout_height = 35.56;
    
    // tobsun chassis shelf cutout
    translate([0,0,0])
    cube([tobsun_chassis_cutout_width,tobsun_chassis_cutout_length,tobsun_chassis_cutout_height]);
    
    // tobsun chassis wire cutout left
    translate([60.96,22.86,12.7])
    rotate([0,90,0])
    cylinder(h=1, r=.2);

    // tobsun chassis wire cutout right
    translate([-12.7,22.86,12.7])
    rotate([0,90,0])
    cylinder(h=1, r=.2);
}
//tobsun_chassis_cutout();