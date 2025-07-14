$fn=50;

module axle(
  axle_length = 95,
  axle_radius = 2.6,
  notch_length = 20,
  notch_cutout = 2,
  fitted_sides = 2
)
{
cutout1 = -notch_cutout;
cutout2 = notch_cutout;

difference() {
      // axle
     rotate([0,90,0])
     cylinder(axle_length, r = axle_radius);
    
    if (fitted_sides ==  2) {
    // axle notch
    translate([axle_length - notch_length + .1, cutout1 - axle_radius, -axle_radius])
    cube([notch_length, axle_radius, 2 * axle_radius]);
    translate([axle_length - notch_length + .1, cutout2, -axle_radius])
    cube([notch_length, axle_radius, 2 * axle_radius]);
    }
     
     // axle notch
    translate([-.1, cutout1 - axle_radius, -axle_radius])
    cube([notch_length, axle_radius, 2 * axle_radius]);
    translate([ -.1, cutout2, -axle_radius])
    cube([notch_length,  axle_radius, 2 * axle_radius]);    
  }
}
 
axle();
