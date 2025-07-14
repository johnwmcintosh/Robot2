$fn = 50;
module pull_bar(bar_length = 15) {
  union() {
  // push bar
  difference() {
    rotate([0, 90, 0])
    cylinder(h = bar_length, r = 1);
    translate([-.5, 0, -1])
    cylinder(h = 2, r = 1);
    }

    // grabber
    translate([0, 0, -1])
    difference() {
      translate([0, 0,  0])
      cylinder(h = 2, r = 1);
      translate([0, 0,  -1])
      cylinder(h = 4, r = .75);
    }
  }
}
pull_bar();