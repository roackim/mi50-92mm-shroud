// Global Parameters
global_th = 2;

module amd_logo(size=50, th=2) {
    s = size / 100; 
    scale_val = 0.30;
  
    // Added translate [0, 0, th] to bring base to Z=0
    translate([0, 0, th])
    color("#222")
    rotate([0, 180, 0])
    scale([scale_val, scale_val, 1]) 
    linear_extrude(height = th) 
    {
        difference() {
            union () 
            {
                polygon(points=[
                    [0*s, 0*s],   
                    [0*s, 100*s], 
                    [100*s, 0*s]  
                ]);
                
                translate([-1, -1, 0])
                polygon(points=[
                    [30*s, 30*s], 
                    [70*s, 30*s],
                    [100*s, 60*s],
                    [100*s,100*s],
                    [60*s, 100*s],
                    [30*s, 70*s]
                ]);
            }
            
            translate([-1, -1, 0])
            polygon(points=[
                    [30*s, 30*s], 
                    [68*s, 30*s],
                    [70*s, 68*s],
                    [30*s, 68*s]
                ]);
        }
    }
}

module letters_AMD(th=2) {
    translate([25, 0, th])
    rotate([180, 0, 0]) 
    {
        color("#222") linear_extrude(height = th) { 
            text("AMD", size = 14, font = "Cascadia:style=Bold", halign = "center"); 
        }
        color("#888") {
            translate([9.5, 2.05, 0]) linear_extrude(height = th) { text("_", size = 8, font = "Ubuntu:style=Bold", halign = "center"); }
            translate([-8, 2.05, 0]) linear_extrude(height = th) { text("_", size = 8, font = "Ubuntu:style=Bold", halign = "center"); }
        }
    }
}

module letters_MI (th=2) {
    translate([25, 0, th]) 
    rotate([180, 0, 0]) {
        color("#222")
        linear_extrude(height = th) {
            text("MI50", size = 14, font = "Cascadia:style=Bold", halign = "center");
        }
        
        color("#888")
        union () {
            translate([12, 6.5, 0]) linear_extrude(height = th)   { text("_", size = 8, font = "Ubuntu:style=Bold", halign = "center"); }
            translate([1.5, 2.05, 0]) linear_extrude(height = th) { text("_", size = 8, font = "Ubuntu:style=Bold", halign = "center"); }
            translate([-5, 2.05, 0]) linear_extrude(height = th)  { text("_", size = 8, font = "Ubuntu:style=Bold", halign = "center"); }
        }
    }
}

// Main Assembly
union() {
    letters_AMD(th=global_th);
    
    translate([0, 20, 0])
    letters_MI(th=global_th);
    
    translate([65, -15, 0])
    amd_logo(th=global_th);
}