
// Adjust these constants as appropriate
total_height = 32; // inside height needed to accomodate the lens
inner_diameter = 50.75; // inside diameter needed to accomodate the lens
wall_thickness = 2.5; // thickness of container walls
thin_wall_thickness = 1.5; // thickness of thinner wall where endcap goes over
lip_thickness = 0.5; // thickness of lip at the very ends for grasping
cap_room = 0.20; // room to leave between the endcap and the thin_diameter wall - bigger makes the endcap more loose
cap_thickness = 2; // thickness of the flat disk that caps each end
text_depth = 1.0; // how deep to etch the lens size marker text
marker_text = "0.5"; // text to etch into the cap

// These are calculated using the settings above: don't bother with these
cap_height = total_height / 2; // the height of the cap that fits on the main body
outer_diameter = inner_diameter + (wall_thickness * 2);
thin_diameter = inner_diameter + (thin_wall_thickness * 2); // diameter given thin_wall_thickness

$fn = 360;

translate([0, 0, (total_height / 2) + cap_thickness])
    difference() {
        union() {
            difference() {
                cylinder(d = outer_diameter, h = total_height, center = true);
                cylinder(d = inner_diameter, h = total_height, center = true);
            }
            translate([0, 0, 0 - ((total_height / 2) + (cap_thickness - 1))])
                union() {
                    cylinder(d = outer_diameter, h = cap_thickness, center = true);
                    cylinder(d = outer_diameter + lip_thickness * 2, h = lip_thickness, center = true);
                }
        }
        translate([0, 0, total_height / 2])
            difference() {
                cylinder(d = outer_diameter, h = total_height, center = true);
                cylinder(d = thin_diameter, h = total_height, center = true);
            }
    }
    
translate([0, floor(inner_diameter) / 2 * 3, (cap_height / 2) + cap_thickness]) {
    union() {
        difference() {
            cylinder(d = outer_diameter, h = cap_height, center = true);
            cylinder(d = thin_diameter + cap_room, h = cap_height, center = true);
        }
        translate([0, 0, 0 - ((cap_height / 2) + 1)]) {
            union() {
                cylinder(d = outer_diameter + lip_thickness * 2, h = lip_thickness, center = true);
                difference() {
                    cylinder(d = outer_diameter, h = cap_thickness, center = true);
                    translate([0, 0, 0 - (cap_thickness - text_depth)])
                        rotate([180, 0, 0]) 
                            linear_extrude(height = text_depth * 2, center = true)
                                text(marker_text, valign="center", halign="center");
                }
            }
        }
    }
}
