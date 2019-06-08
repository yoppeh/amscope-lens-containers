
// Adjust these constants as appropriate
total_height = 44.85; // inside height needed to accomodate the lens
inner_diameter = 37.00; // inside diameter needed to accomodate the lens
wall_thickness = 2.5; // thickness of container walls
thin_wall_thickness = 1.5; // thickness of thinner wall where endcap goes over
lip_thickness = 0.5; // thickness of lip at the very ends for grasping
cap_room = 0.40; // room to leave between the endcap and the thin_diameter wall - bigger makes the endcap more loose
cap_thickness = 2; // thickness of the flat disk that caps each end
text_depth = 1.0; // how deep to etch the lens size marker text
marker_text = "10"; // text to etch into the cap

// These are calculated using the settings above: don't bother with these
cap_height = total_height / 2; // the height of the cap that fits on the main body
outer_diameter = inner_diameter + (wall_thickness * 2);
thin_diameter = inner_diameter + (thin_wall_thickness * 2); // diameter given thin_wall_thickness

$fn = 360;

// body
translate([0, 0, (total_height / 2) + cap_thickness]) {
    union() {
        translate([0, (outer_diameter - wall_thickness) / 2, 0]) {
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
        }
        translate([0, -(outer_diameter - wall_thickness) / 2, 0]) {
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
        }
        difference() {
            union() {
                translate([0, 0, -(cap_height / 2) - 1]) {
                    cube([outer_diameter, outer_diameter, cap_height + cap_thickness], center = true);
                }
                translate([0, 0, (cap_height / 2)]) {
                    cube([thin_diameter, thin_diameter, cap_height], center = true);
                }
                translate([0, 0, -(cap_height + lip_thickness * 2)]) {
                    cube([outer_diameter + lip_thickness * 2, outer_diameter, lip_thickness], center = true);
                }
            }
            translate([0, -(outer_diameter - wall_thickness) / 2, 0]) {
                cylinder(d = inner_diameter, h = total_height + cap_thickness, center = true);
            }
            translate([0, (outer_diameter - wall_thickness) / 2, 0]) {
                cylinder(d = inner_diameter, h = total_height + cap_thickness, center = true);
            }
        }
    }
} 


// cap
translate([floor(inner_diameter) / 2 * 3, 0, (cap_height / 2) + cap_thickness]) {
    difference() {
        union() {
            translate([0, (outer_diameter - wall_thickness) / 2, 0]) {
                union() {
                    cylinder(d = outer_diameter, h = cap_height, center = true);
                    translate([0, 0, 0 - ((cap_height / 2) + 1)]) {
                        union() {
                            cylinder(d = outer_diameter + lip_thickness * 2, h = lip_thickness, center = true);
                            cylinder(d = outer_diameter, h = cap_thickness, center = true);
                        }
                    }
                }
            }
            translate([0, -(outer_diameter - wall_thickness) / 2, 0]) {
                union() {
                    cylinder(d = outer_diameter, h = cap_height, center = true);
                    translate([0, 0, 0 - ((cap_height / 2) + 1)]) {
                        union() {
                            cylinder(d = outer_diameter + lip_thickness * 2, h = lip_thickness, center = true);
                            cylinder(d = outer_diameter, h = cap_thickness, center = true);
                        }
                    }
                }
            }
            translate([0, 0, -1]) {
                cube([outer_diameter, outer_diameter, cap_height + cap_thickness], center = true); 
            }
            translate([0, 0, (-cap_height / 2) - lip_thickness * 2]) {
                cube([outer_diameter + lip_thickness * 2, outer_diameter + lip_thickness * 2, lip_thickness], center = true);
            }
        }
        translate([0, (outer_diameter - wall_thickness) / 2, 0]) {
            cylinder(d = thin_diameter + cap_room, h = cap_height, center = true);
        }
        translate([0, -(outer_diameter - wall_thickness) / 2, 0]) {
            cylinder(d = thin_diameter + cap_room, h = cap_height, center = true);
        }
        cube([thin_diameter + cap_room, thin_diameter + cap_room, cap_height], center = true);
        translate([0, 0, -((cap_height / 2) + text_depth * 1.5)])
            rotate([180, 0, 90]) 
                linear_extrude(height = text_depth * 2, center = true)
                    text(marker_text, valign="center", halign="center");
    }
}