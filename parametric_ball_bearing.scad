$fn = 50;

module parametric_ball_bearing (
    ball_bearing_diameter = 4.5,
    ball_bearing_channel_diameter = 4.6,
    center_hole_radius = 2,
    inner_component_thickness = 5,
    outer_component_thickness = 4
  ) 
  {
    outer_raceway_radius = inner_component_thickness + ball_bearing_channel_diameter;

    overall_thickness = 4;

    rotate_extrude() {
      difference() {
        union() {
          translate([center_hole_radius,0,0])
          square([inner_component_thickness, overall_thickness]);

          translate([outer_raceway_radius,0,0])
          square([outer_component_thickness, overall_thickness]);
        }
        translate([center_hole_radius + inner_component_thickness + ball_bearing_channel_diameter/4, overall_thickness/2,0])
        circle(d = ball_bearing_channel_diameter);

    }
  }

  for (ball = [0:40:360]) {
      rotate([0,0,ball])
      translate([center_hole_radius + inner_component_thickness + ball_bearing_diameter/4 + .1, 0, overall_thickness/2])
      sphere(r = ball_bearing_diameter / 2);
  }
}
parametric_ball_bearing();