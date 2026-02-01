
module amd_logo(size=50, thickness=3) {
    // Proportional scaling factor
    // The base design is roughly 100x100 units
    s = size / 100; 

    color("#222")
    linear_extrude(height = thickness) 
    {
      difference() {
      union () 
      {
          color("#00FF0033")
            polygon(points=[
                [0*s, 0*s],       // Bottom tip
                [0*s, 100*s],   // Top right outer
                [100*s, 0*s]   // Bottom right outer
            ]);
          
          translate([-1, -1, 0])
          color("red")
            polygon(points=[
                [30*s, 30*s], 
                [70*s, 30*s],
                [100*s, 60*s],
                [100*s,100*s],
                [60*s, 100*s],
                [30*s, 70*s],
                // [100*s, 66*s],
            ]);
      }
        
        color("white")
        translate([-0.5, -0.5, 0])
        polygon(points=[
                [30*s, 30*s], 
                [70*s, 30*s],
                [70*s, 70*s],
                [30*s, 70*s],
            ]);
      }
    }
}


// LOGOS
module letters_AMD(w, th=2) {
  union () {
  translate([25, 0, 0])
  {
    rotate([180, 0, 0]) 
    {
      color("#222") linear_extrude(height = th/3) { text("AMD", size = 14, font = "Cascadia:style=Bold", halign = "center"); }
      color("#888") {
        translate([9.5, 2.05, 0]) linear_extrude(height = th/3) { text("_", size = 8, font = "Ubuntu:style=Bold", halign = "center"); }
          translate([-8, 2.05, 0]) linear_extrude(height = th/3) { text("_", size = 8, font = "Ubuntu:style=Bold", halign = "center"); }
      }
    }
  }
  translate([65, -14, 0]) scale(0.30) rotate([0, 180, 0]) amd_logo();
}
}

module letters_MI (w, th=2) {
  union () {
    translate([25, 0, 0]) 
    {
      rotate([180, 0, 0]) {
        color("#222")
        linear_extrude(height = th/3) {
            text("MI50", size = 14, font = "Cascadia:style=Bold", halign = "center");
        }
        
        color("#888")
        union () {
          translate([12, 6.5, 0]) linear_extrude(height = th/3) { text("_", size = 8, font = "Ubuntu:style=Bold", halign = "center"); }
          translate([1.5, 2.05, 0]) linear_extrude(height = th/3) { text("_", size = 8, font = "Ubuntu:style=Bold", halign = "center"); }
          translate([-5, 2.05, 0]) linear_extrude(height = th/3) { text("_", size = 8, font = "Ubuntu:style=Bold", halign = "center"); }
        }
      }
    }
  }
}

letters_AMD(100);
translate([0, 20, 0])
letters_MI(100);
