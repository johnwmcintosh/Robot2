$fn = 75;

module ball_bearing() {
  rotate_extrude() {
    difference() {
      union() {
        translate([9,0,0]) square([14,5], center = true);
        translate([17.5,0,0]) square([6,5], center = true);
      }
      translate([14.75,0,0]) circle(3);
    }
  }

  for (ball = [0:30:360]) {
    rotate([0,0,ball])
    translate([14.75,0,0])
      sphere(r = 2.8);
  }
}
ball_bearing();