// BY_CRC absorber
// 2013-08
//

$fn = 60; // facets, bigger values -> memory probs
          // start with smaller values (like 12),
          // set height, twist and step to
          // desired values
          // then increase fn until you run out
          // of memory, use biggest working value
          
 module shock_absorber (
 
  height = 12, // the taller, the more twists needed
  twist = 0.7, // helix #turns around center
             // watch printability !!
             // more turns -> smaller angle
  step = 8, // draw step helixes
            // should be divisor of 360
            // more helixes -> less space in between
  offset = 4, // distance from center, kind of radius
  radius = .7 // helix and torus radius
              // the more, the harder it will be
)
{
  union() {
    for (i = [0:360/step:360]) { 
      rotate ( [0,0,i] ) {
        linear_extrude(height = height, center = true	,
        convexity = 5, twist = twist*360)
        translate([offset, 0, 0])
        circle(r = radius);
        }
      }

    translate ( [0, 0, -height/2] ) {
      rotate_extrude(convexity = 5)
      translate([offset, 0, 0])
      circle(r = radius);
      }

    translate ( [0, 0, height/2] ) {
      rotate_extrude(convexity = 5)
      translate([offset, 0, 0])
      circle(r = radius);
		}
	}
}
shock_absorber();
