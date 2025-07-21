use <Spring Generator.scad>

// === Parameters ===
outer_dia  = 10;
outer_height  = 30;

rod_dia  = 8;
rod_length  = 25;

eye_dia  = 15;
eye_thickness  = 3;

// === Anchors for placement ===
bottom_eye_z = 0;
outer_tube_z = bottom_eye_z + eye_thickness;
top_eye_z    = outer_tube_z + outer_height + rod_length;

// === Modules ===
module outer_tube() {
    color("silver")
    translate([0, 0, outer_tube_z])
      difference() {
        cylinder(h = outer_height, d = outer_dia, $fn=64);
        translate([0,0,.1])
        cylinder(h = outer_height + 2, d=rod_dia + .5, $fn=65);
        
        translate([0, 0,outer_height - eye_thickness])
        cube([outer_dia / 2 - rod_dia / 2 + .2, 10, 15]);
   
        translate([-23.4, -4.5, 2.1])
          difference() {
            rotate([0,0,-3])
            translate([-(outer_dia / 2 - rod_dia / 2) / 2 + 23.7, 12, outer_height - eye_thickness -5.1])
            rotate([90,0,-20])
            cube([7, 3, 3]);
            }   

            
          translate([0,-(outer_dia / 2 - rod_dia / 2) / 2 + 1, eye_thickness])
          cube([10, outer_dia / 2 - rod_dia / 2 + .2, outer_height - eye_thickness - outer_tube_z ]);
            
            translate([-(outer_dia / 2 - rod_dia / 2) / 2 + 23.1,  3, outer_height - eye_thickness - 7.1])
            cylinder(7, d = outer_dia);

        }
 }

module inner_rod() {
    color("gray")
    //translate([0, 0, outer_tube_z + outer_height ]) {
        cylinder(h = rod_length, d = rod_dia, $fn=64);
        mount_eye(rod_length);             // Top eye
  
        translate([-(outer_dia / 2 - rod_dia / 2) / 2, 4, 0])
        cube([outer_dia / 2 - rod_dia / 2, 3, 3]);
    //}
}

module mount_eye(z_pos) {
    color("gold")
    translate([0, 0, z_pos])
        cylinder(h = eye_thickness, d = eye_dia, $fn=64);
}

module coil_spring() {
  generate();
}

// === Final Assembly ===
module shock_absorber() {
    mount_eye(bottom_eye_z);           // Bottom eye
    outer_tube();                      // Cylinder housing
  
  translate([30, 40, rod_length + eye_thickness])
  rotate([180,0,0])
    inner_rod();                       // Piston rod
  translate([-40, 40, 0])
    coil_spring();                     // Full-length coil
}

shock_absorber();
