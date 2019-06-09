include <threads.scad>

inner_diameter = 40.0;      // diameter of inside of adapter ring
thread_diameter = 47.8;     // outside diameter where the threads contact the lens
thread_pitch = 0.75;        // threads per mm
thread_length = 4;          // length, in mm of threads
outer_band_height = 5;      // length, in mm of bands sandwiching indent where screws on LED ring go
indent_band_height = 2.5;   // lenght, in mm, of indented middle band= (where the LED ring screws in)

$fn = 360;                  // resolution for curves. Comment out for quickly prototyping

/* Internal constants. These are calculated using values specified above. */
outside_diameter = round(thread_diameter) + 2;
indent_diameter = outside_diameter - 2;

translate([0, 0, ((outer_band_height * 2) + indent_band_height)]) {
    difference() {
        union() {
            metric_thread(diameter = thread_diameter, pitch = thread_pitch, length = thread_length, square = true);
            translate([0, 0, -(outer_band_height / 2)]) {
                cylinder(d = outside_diameter, h = outer_band_height, center = true);
            }
            translate([0, 0, -(outer_band_height + (indent_band_height / 2))]) {
                cylinder(d = indent_diameter, h = indent_band_height, center = true);
            }
            translate([0, 0, -(outer_band_height * 2)]) {
                cylinder(d = outside_diameter, h = outer_band_height, center = true);
            }
        }
        cylinder(d = inner_diameter, h = (thread_length + (outer_band_height * 2) + indent_band_height) * 2, center = true);
    }
}