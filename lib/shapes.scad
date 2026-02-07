// Creates a cube with rounded vertical edges 
module rvecube (x, y, z, rnd, fn=16)
{
  hull() {
  translate([  rnd,   rnd, z/2]) cylinder(h=z, r=rnd, center=true, $fn=fn);
  translate([  rnd, y-rnd, z/2]) cylinder(h=z, r=rnd, center=true, $fn=fn);
  translate([x-rnd, y-rnd, z/2]) cylinder(h=z, r=rnd, center=true, $fn=fn);
  translate([x-rnd,   rnd, z/2]) cylinder(h=z, r=rnd, center=true, $fn=fn);
  }
}

module honeycomb(size=[100,100], side=10, wall=2, h=2, type="hex", fn=24, shift=[0,0], fill_incomplete=true) {
    row_h = side * sin(60); 
    
    // Hole radii
    r_hex_outer = (side - wall) / sqrt(3); // Vertex radius
    r_hex_inner = (side - wall) / 2;       // Flat-to-flat radius
    r_cir = (side - wall) / 2;
    
    // Select the "collision radius" for boundary checking
    check_r = (type == "hex") ? r_hex_outer : r_cir;

    linear_extrude(height = h) {
        difference() {
            // 1. The solid plate
            square(size, center=true);
            
            // 2. The hole generation
            translate([shift.x, shift.y]) {
                for (y = [-size.y/2 - row_h*2 : row_h : size.y/2 + row_h*2]) {
                    offset_row = (round(y/row_h) % 2 == 0) ? 0 : side/2;
                    
                    for (x = [-size.x/2 - side*2 : side : size.x/2 + side*2]) {
                        // Current hole center point
                        pos = [x + offset_row, y];
                        
                        // Check if hole center + its radius is inside the size box
                        // We account for the 'shift' by adjusting the boundary check
                        is_inside = (abs(pos.x + shift.x) + check_r <= size.x/2) && 
                                    (abs(pos.y + shift.y) + check_r <= size.y/2);

                        if (!fill_incomplete || is_inside) {
                            translate(pos) {
                                if (type == "hex") {
                                    rotate([0, 0, 30]) circle(r = r_hex_outer, $fn = 6);
                                } else {
                                    circle(r = r_cir, $fn = fn);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

module m2_screw_hole(h=5, head_depth=1.5, drill_depth=5, tol=0.2) {
    // Standard M2 Countersink Dimensions
    drill_dia = 2.0 + tol;      // Shaft
    head_dia_max = 4.4 + tol;   // Top of the "V"
    
    extra = 0.1; // Overlap for clean boolean cuts

    translate([0, 0, - head_depth])
    union() {
        // 1. The Tapered Head Recess (Countersink)
        // Positioned at the very top of the hole (height 'h')
        translate([0, 0, h - head_depth])
            cylinder(d1=drill_dia, d2=head_dia_max, h=head_depth + extra, $fn=32);
        
        // 2. The Main Shaft
        // It starts from the bottom of the head recess and goes DOWN by 'drill_depth'
        translate([0, 0, h - drill_depth])
            cylinder(d=drill_dia, h=drill_depth, $fn=32);
        
        // 3. Clean-cut extension (Top)
        // Ensures the subtraction clears the top surface perfectly
        translate([0, 0, h])
            cylinder(d=head_dia_max, h=extra, $fn=32);
    }
}

module m3_screw_hole(h=10, head_depth=2.0, drill_depth=10, tol=0.3) {
    // Standard M3 Countersink Dimensions
    drill_dia = 3.0 + tol;      // Shaft (Clearance hole)
    head_dia_max = 6.0 + tol;   // Top of the countersink "V"
    
    extra = 0.1; // Overlap for clean boolean cuts

    // We keep your translation logic to align the top of the hole with 'h'
    translate([0, 0, -head_depth])
    union() {
        // 1. The Tapered Head Recess (M3 Countersink)
        translate([0, 0, h - head_depth])
            cylinder(d1=drill_dia, d2=head_dia_max, h=head_depth + extra, $fn=64);
        
        // 2. The Main Shaft
        translate([0, 0, h - drill_depth])
            cylinder(d=drill_dia, h=drill_depth, $fn=64);
        
        // 3. Clean-cut extension (Top)
        translate([0, 0, h])
            cylinder(d=head_dia_max, h=extra, $fn=64);
    }
}

// tol = 0.1 to 0.2 is usually perfect for most FDM printers
module m3_nut(bolt_len = 10, nut_height = 2.4, nut_depth = 0, tol = 0.2) {

    // add tolerance to the flat-to-flat width (5.5mm is standard)
    // We also add a tiny bit to the height (2.4mm) for a flush fit
    flat_to_flat = 5.5 + (tol * 2); 
    
    translate([0, 0, nut_depth])
        cylinder(h = nut_height + tol, d = flat_to_flat / cos(30), $fn = 6); 
}

