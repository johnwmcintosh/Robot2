module support_angle(length = 150, width = 10, rot_vec = [90,0,0]) {
    rotate(rot_vec)
    difference() {
        cube([width, length, 4]);
        
        translate([10,-10,-1])
        rotate([0,0,45])
        cube([10, 30, 6]);
        
        translate([-10,length - 10,-1])
        rotate([0,0,-45])
        cube([10, 30, 6]);
    }
}
support_angle();