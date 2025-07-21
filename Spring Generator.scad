include <BOSL2/std.scad>;

/**
 * Spring Generator
 *      
 * Author: Jason Koolman  
 * Version: 1.0 
 *
 * Description:
 * This OpenSCAD script generates a fully parametric compression spring with  
 * customizable options for coil configuration, pitch, profile, and more. 
 *
 * License:
 * Licensed under a Standard Digital File License.
 *
 * Changelog:
 * [v1.1]
 * - Added support for grounded (flat) ends.
 */
    
/* [⚙️️️ Spring] */

// Free length of the spring.
Length = 30;

// Outer diameter of the spring.
Diameter = 11.5;

// Total number of active coils.
Coils = 5;

/* [🌀 Coil] */

// Dead coils at [top, bottom] (no active compression).
Dead_Coils = [1, 1];

// Pitch spread factor (0 = uniform, 1 = max spread).
Spread = 0; // [0:0.05:1]

// Midpoint of the spread (0 = start, 1 = end).
Midpoint = 0.5; // [0:0.05:1]

// Wire diameter of the spring.
Wire = 3;

// Use rectangular wire profile.
Plastic = false;

// Use grounded (flat) ends.
Grounded = true;

// Use octagonal coil shape for easier printing.
Poly = false;

// Add solid base(s) for attachment.
// Base = false;

/* [📷 Render] */

// Toggle debug mode.
Debug = false;

// Render resolution to control detail level.
Resolution = 2; // [3: High, 2: Medium, 1: Low]

// Color of the model.
Color = "#cdcdcd"; // color

// Determine face angle and size based on resolution
Face = (Resolution == 3) ? [2, 0.2]
    : (Resolution == 2) ? [3, 0.3]
    : [4, 0.6];

/* [Hidden] */

$fa = Face[0];
$fs = Face[1];
$slop = 0.1;

// Render
generate();

module generate() {
    color(Color)
    compression_spring(
        l=Length,
        d=Diameter,
        coils=Coils,
        wire_d=Wire,
        plastic=Plastic,
        dead_coils=Dead_Coils,
        coil_spread=Spread,
        coil_mid=Midpoint,
        poly=Poly,
        grounded=Grounded
        //base=Base,
    );
}

/**
 * Calculates the variable pitch for a compression spring along its length.
 * The function adjusts pitch smoothly between active and dead coils, supporting 
 * spread control and custom midpoint adjustment for advanced spring designs.
 *
 * @param t                 Position along the spring's length (0 to 1).
 * @param l                 Free length of the spring.
 * @param coils             Total number of coils.
 * @param wire_d            Diameter of the wire.
 * @param spread            Spread factor (0 = uniform, 1 = max spread).
 * @param dead_coils_top    Number of dead coils at the top.
 * @param dead_coils_bottom Number of dead coils at the bottom.
 * @param mid               Midpoint of the spread effect (0 = start, 1 = end). Default: 0.5
 *
 * @return                  Pitch value at position t.
 */
law_curve_pitch = function (t, l, coils, wire_d, spread, dead_coils_top, dead_coils_bottom, mid=0.5) 
    let (
        pitch_min = wire_d + get_slop(),    
        pitch_max = (l - (dead_coils_top + dead_coils_bottom) * pitch_min) / (coils - (dead_coils_top + dead_coils_bottom)),  
        spread_factor = spread * 10,
        
        dead_range_bottom = dead_coils_bottom / coils,  // Bottom dead coil range
        dead_range_top = 1 - (dead_coils_top / coils),  // Top dead coil range

        // Normalize transition space, ensuring dead coils remain constant
        t_remap = (t < dead_range_bottom) ? 0 :
                  (t > dead_range_top) ? 1 :
                  (t - dead_range_bottom) / (dead_range_top - dead_range_bottom)
    )
    (t < dead_range_bottom || t > dead_range_top)
        ? pitch_min
        : pitch_min + (pitch_max - pitch_min) * exp(-spread_factor * pow(t_remap - mid, 2));

/**
 * Creates a compression spring with a variable pitch and optional radius increase.
 *
 * @param l             Free length of the spring.
 * @param d             Base diameter of the spring.
 * @param coils         Number of active coils (not counting dead coils).
 * @param wire_d        Diameter of the wire.
 * @param dead_coils    Number of dead coils [top, bottom].
 * @param coil_spread   Coil spread factor (0 = uniform, 1 = max spread).
 * @param coil_mid      Midpoint of coil spread adjustment (0 = bottom, 1 = top).
 * @param radius_inc    Increase in radius from bottom to top (0 = uniform).
 * @param plastic       Use plastic profile?
 * @param poly          Use an 8-sided polygon instead of a smooth circle?
 * @param grounded      Add solid grounded ends at the top and bottom.
 */
module compression_spring(
    l=50,
    d=20,
    coils=10,
    wire_d=2, 
    dead_coils=[0,0],
    coil_spread=0.5,
    coil_mid=0.5,
    radius_inc=0,
    plastic=false,
    poly=false,
    grounded=false,
    base=false, 
    anchor=CENTER,
    spin=0,
    orient=UP
) {
    radius_base = d / 2;
    free_l = l - wire_d;
    steps = segs(radius_base) * coils;

    // Generate pitch variation for the spring using the law function
    pitch_samples = [
        for (i = [0:steps])
            law_curve_pitch(
                t = i / steps,
                l = free_l,
                coils = coils,
                wire_d = wire_d,
                spread = coil_spread,
                dead_coils_top = dead_coils[0],
                dead_coils_bottom = dead_coils[1],
                mid = coil_mid
            ) / steps
    ];

    full_height = sum(pitch_samples);
    z_values = cumsum(pitch_samples) / full_height * free_l;
    radius_values = [for (i = [0:steps]) radius_base + (radius_inc * (i / steps))];

    // Generate the helical path
    helix = [
        for (i = [0:steps]) [
            radius_values[i] * cos(360 * i / steps * coils),
            radius_values[i] * sin(360 * i / steps * coils),
            z_values[i]
        ]
    ];
    
    // Path resampling for improved smoothing and accuracy
    n = poly ? 8 * coils + 1 : segs(d / 2) * (coils - 1);
    path = resample_path(helix, n=n, closed=false);

    // Define shape profile
    shape = plastic
        ? rect([wire_d * 2, wire_d], anchor=LEFT)
        : circle(d=wire_d, anchor=LEFT);
    
    // Perform path sweeping to create the spring body
    vnf = path_sweep(shape, path, method="manual", normal=UP);
    vnf_bounds = pointlist_bounds(vnf_vertices(vnf));
    vnf_size = vnf_bounds[1] - vnf_bounds[0];
    
    // Attachable spring instance
    attachable(anchor, spin, orient, vnf=vnf) {
        difference() {
            vnf_polyhedron(vnf) {        
                // Add base
                if (base) {
                    position([TOP, BOTTOM]) 
                        cyl(d = d, l = wire_d, $fn = poly ? 8 : 0);
                }
            }
            
            // Flatten ends
            if (grounded) {
                cube([d, d, wire_d], anchor=TOP);
                up(vnf_size.z) cube([d, d, wire_d], anchor=TOP);
            }
        }
        children();
    }
    
    // Render debug info
    if (Debug) {
        
        ndead = sum(dead_coils);
        nactive = coils - ndead;
    
        fwd(d/2 + 6)
        color("#AAAAAA")
        linear_extrude(height = 0.1)
            write([
                "Compression Spring",
                str("Outer diameter: ", d, "mm"),
                str("Wire thickness: ", wire_d, "mm"),
                str("Free length: ", l, "mm"),
                str("Compressed length: ", (coils + 1) * wire_d, "mm"),
                str("Coils: ", coils, " (",nactive," active, ",ndead, " dead)"),
            ], size = 2);
    }
}
    
/**
 * Writes multiline text with proper spacing and alignment.
 *
 * @param lines       List of text strings (one per line).
 * @param font        Font name.
 * @param size        Font size.
 * @param spacing     Letter spacing.
 * @param lineheight  Line height.
 * @param halign      Horizontal alignment for each line ("left", "center", "right").
 * @param valign      Vertical alignment for the entire block ("top", "center", "bottom").
 */
module write(lines, font = "Liberation Sans", size = 4, spacing = 1, lineheight = 1, halign = "center", valign = "top") {
    // Compute font metrics and interline spacing
    fm = fontmetrics(size = size, font = font);
    interline = fm.interline * lineheight;
    n = len(lines);

    // Calculate total bounding box dimensions
    bbox = [
        // Calculate the widest line
        max([for (line = lines) textmetrics(text = line, font = font, size = size, spacing = spacing).size.x]),
        // Calculate total height
        interline * len(lines)
    ];
    total_height = bbox[1];

    // Determine vertical offset for block alignment
    y_offset = 
        (valign == "top") ? 0 : 
        (valign == "center") ? -total_height / 2 : 
        -total_height;

    // Render text lines with appropriate alignment
    translate([0, -y_offset]) {
        for (i = [0 : n - 1]) {
            translate([0, -(interline * i + interline / 2)])
                text(
                    text = lines[i],
                    font = i == 0 ? str(font, ":style=Bold") : font,
                    size = size,
                    spacing = spacing,
                    halign = halign,
                    valign = "center"
                );
        }
    }
}
