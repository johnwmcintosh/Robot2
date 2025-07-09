include <robot_settings.scad>

$fa=1;
$fs=0.4;

////////////////////////////////////////////////
module engine_holder_cutouts() {
    translate([-.03, 1,-.10])
    cube([.11, .45, rail_thickness ]);

    translate([.73, 1,-.10])
    cube([.11, .45, rail_thickness ]);

    translate([1.88,0,-.10])
    rotate([0,0,90])
    cube([.15, 1.9, rail_thickness]);
}
scale([100,100,100])
engine_holder_cutouts();