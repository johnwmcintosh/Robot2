$fn = 50;

// Curved vertical slot on outer wall
module curved_vertical_slot(r=20, h=10, slot_depth=.5, slot_width=.5, length=1, angle=0) {
    for (i = [0 : length - 1]) {
        z = h - length + i;
        a = angle * PI / 180;
        x = (r - slot_depth ) * cos(a);
        y = (r - slot_depth) * sin(a);

        rotate([0, 0, angle])
        translate([x, y, z])
            cube([slot_depth, slot_width, 1.1], center=false);
    }
}

// Curved horizontal leg of the L-slot
module curved_horizontal_slot(r=20, slot_depth=.5, slot_width=.6, arc_span=20, angle=0, start_z=8.6) {
    for (a = [0 : 1 : arc_span]) {
        current_angle = angle + a;
        a_rad = current_angle * PI / 180;
        x = (r - slot_depth) * cos(a_rad);
        y = (r - slot_depth) * sin(a_rad);

        rotate([0, 0, current_angle])
        translate([x, y, start_z])
            cube([slot_depth, slot_width, slot_depth], center=false);
    }
}

// Base cylinder with curved L-notch
module base_with_l_notch(height = 10, radius = 3) {
  
  vertical_slot_height = 1;
  
  difference() {
  
   cylinder(h=height, r=radius);
    union() {
        curved_vertical_slot(r = radius, h = height, length = vertical_slot_height);
        curved_horizontal_slot(r  = radius, start_z = height - vertical_slot_height);
      
       curved_vertical_slot(r = radius, angle = 90, h = height, length = vertical_slot_height);
       curved_horizontal_slot(r = radius, angle = 90, start_z = height  - vertical_slot_height);
      
        curved_vertical_slot(r = radius, angle = 180, h = height, length = vertical_slot_height);
        curved_horizontal_slot(r = radius, angle = 180, start_z = height  - vertical_slot_height);
      
        curved_vertical_slot(r = radius, angle = 260, h = height, length = vertical_slot_height);
        curved_horizontal_slot(r = radius, angle = 260, start_z = height  - vertical_slot_height);
     }
   }
}

// Cap with internal notch lug
module cap_with_internal_lug(r=3, cap_thickness = .5, h=2, wall=.25, lug_depth=.25, lug_width=.25, lug_height=.5, angle=0) {
    difference() {
        // Outer shell
        cylinder(h=h, r=r + cap_thickness);

        // Hollow cavity
        translate([0, 0, - wall])
            cylinder(h=h, r= r - wall);
    }

    // Internal lug
    a_rad = angle * PI / 180;
    x = (r - wall - lug_depth) * cos(a_rad);
    y = (r - wall - lug_depth) * sin(a_rad);

    rotate([0, 0, angle])
    translate([x, y, 0])
        cube([lug_depth, lug_width, lug_height], center=false);
}

module cap_with_four_lugs() {
    union() {
      cap_with_internal_lug();
      cap_with_internal_lug(angle=90);
      cap_with_internal_lug(angle=180);
      cap_with_internal_lug(angle=260);
    }
}

// Assembly
base_with_l_notch();

translate([0, 8, 0])
cap_with_four_lugs();

