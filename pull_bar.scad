$fn = 50;

bar_radius = 2;

module pull_bar(bar_length = 15) {
  union() {
  // push bar
  difference() {
    rotate([0, 90, 0])
    cylinder(h = bar_length, r = bar_radius);
    translate([-.5, 0, -bar_radius])
    cylinder(h = 2 * bar_radius, r = bar_radius);
    }

    // grabber
    translate([0, 0, -1])
    difference() {
      translate([0, 0, 1 - bar_radius])
      cylinder(h = 2 * bar_radius, r = bar_radius);
      translate([0, 0,  -bar_radius])
      cylinder(h = 3* bar_radius, r = bar_radius - .5);
    }
  }
}
pull_bar();