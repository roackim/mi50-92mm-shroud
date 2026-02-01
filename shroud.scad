// import("ref/shroud.stl"); // ref from https://www.printables.com/model/1227869-radeon-instinct-mi50-80mm-fan-case

use <lib/shapes.scad>
use <letters.scad>

e = 0.001;
th = 2;
w = 98.5;

print_limit = 255;

module mi50_m2_screw() {
  color("orange") m2_screw_hole(h=3.0, head_depth=1.5, drill_depth=6.0, tol=0.3);
}

module helpers() {
  // translate([-print_limit,-100,-50]) color("#FFFFFF11") cube([0.1,200,100]);
  translate([-print_limit +4,-w/2-1,-16.5]) color("#FFFFFF") cube([148,1,1]);

  // end of shroud marker
  translate([-print_limit +4,-w/2-1,-16.5]) rotate([0, 180, 0]) color("#FF00FF") cube([20,1,1]);

  // end of heatsink marker
  translate([-print_limit +4,-w/2-1,-10.5]) color("#00FFFF") cube([8,1,1]);
}

module mi50_screw_holes() {

  // SCREWS MARKERS ====================================================================
  // pci_1
  // translate([-9.5, 0, -16])
  // color("#FFFF00") translate([0.5, -55, -0.5]) rotate([0,0,90]) cube([12,1.0,1.0]);
  translate([-9.5, -48, -16]) rotate([90]) mi50_m2_screw();

  // pci_2
  // translate([-103.5, 0, -16])
  // color("#FFFF00") translate([0.5, -55, -0.5]) rotate([0,0,90]) cube([12,1.0,1.0]);
  translate([-103.5, -50, -16]) rotate([90]) mi50_m2_screw();

  // pci_3
  // translate([-103.5 - 148, 0, -16])
  // color("#FFFF00") translate([0.5, -55, -0.5]) rotate([0,0,90]) cube([12,1.0,1.0]);
  translate([-251.25, -48, -16]) rotate([90]) mi50_m2_screw();

  // void_1
  // translate([-8.5, 0, -16])
  // color("#FFFF00") translate([0.5, 43, -0.5]) rotate([0,0,90]) cube([12,1.0,1.0]);
  translate([-8.5, 48, -16]) rotate([270]) mi50_m2_screw();

  // void_2
  // translate([-110, 0, -16])
  // color("#FFFF00") translate([0.5, 43, -0.5]) rotate([0,0,90]) cube([12,1.0,1.0]);
  translate([-110, 48, -16]) rotate([270]) mi50_m2_screw();

  // void_2
  // translate([-110 - 143, 0, -16 +7])
  // color("#FFFF00") translate([0.5, 43, -0.5]) rotate([0,0,90]) cube([12,1.0,1.0]);
  translate([-253, 46, -8]) rotate([270]) mi50_m2_screw();
}

module vhole(h, r){
  cylinder(h=h, r=r, center=true, $fn=16);
}

fan_h = 25;
gpu_h = 22;
fan_shroud_h = fan_h + th + gpu_h;

module fan_shroud() {
  height = fan_h + th + gpu_h;
  // color("red")
  // union () 
  {
  difference() 
  {
    rvecube(w, w, height, 4);
    
    rad=5.2/2;
    translate([  8,   8, height/2]) vhole(100, r=rad);
    translate([  8, w-8, height/2]) vhole(100, r=rad);
    translate([w-8, w-8, height/2]) vhole(100, r=rad);
    translate([w-8,   8, height/2]) vhole(100, r=rad);
    
    // fan cylinder hole
    translate([w/2, w/2, height/2]) cylinder(h=100, r=88/2, center=true, $fn=48);
    
    
    union() { // block holes
      // interior hole
      translate([th,th,-th]) rvecube(w-2*th, w-2*th, height, 4); 
      translate([-1, th, -fan_h -th]) cube([w + 12, w-2*th, height]) ;
    }
  } // end difference
  
  // pci_2 stub
  color("#00FF00")
  translate([-12, -th/2 + e, 0])
    // cube([25, th, 12.5]);
      hull() {
        translate([7, 0, 4])   rotate([90, 0, 0]) cylinder(h=th, r=4, center=true, $fn=22);
        translate([10, 0, height-1])  rotate([90, 0, 0]) cylinder(h=th, r=1, center=true, $fn=12);
        translate([36, 0, height-1])  rotate([90, 0, 0]) cylinder(h=th, r=1, center=true, $fn=12);
        translate([27, 0, 4])   rotate([90, 0, 0]) cylinder(h=th, r=4, center=true, $fn=22);
      }
   
    // void_2 stub
    color("#00FF00")
    translate([-18, w-th/2 + e, 0])
      // cube([25, th, 12.5]);
      hull() {
        translate([7, 0, 4])   rotate([90, 0, 0]) cylinder(h=th, r=4, center=true, $fn=22);
        translate([12.5, 0, height-1])  rotate([90, 0, 0]) cylinder(h=th, r=1, center=true, $fn=12);
        translate([33, 0, height-1])  rotate([90, 0, 0]) cylinder(h=th, r=1, center=true, $fn=12);
        translate([37, 0, 0.1])   rotate([90, 0, 0]) cylinder(h=th, r=0.1, center=true, $fn=1);
      }
    }
}

module heatsink_shroud(length=160, width=100, height=30) {
  rear_margin = 28;
  heatsink_overlap = 38;
  heatsink_height = 33;
  
  rnd = 1;
  rndi = 6;
  color("#222")
  translate([-length, 0, 0]) {
    difference() {
      
      // outer shape
      rvecube(length, width, height, rnd);
      
      // interior hole
      translate([th, th, -th-1])
        rvecube(length-2*th, width-2*th, height+1, rnd); 
      
      // top hole
      translate([th+rear_margin, th, -e]) 
        rvecube(length-2*th -rear_margin -heatsink_overlap, width-2*th, height+1, rndi);
      
      // incoming airflow opening
      translate([length-10,th,-e]) cube([20, width-2*th, heatsink_height]);
      
      // outcoming airflow opening
      translate([-10,th,-e]) cube([20, width-2*th, heatsink_height]);
      
    } // end diff
    
    // entry top heatsink airflow blocker
    translate([length-heatsink_overlap, 0, heatsink_height]) 
    rvecube(x=heatsink_overlap, y=width, z=height-heatsink_height, rnd=1);
    
    // exit top heatsink airflow blocker
    translate([0, 0, heatsink_height])
    rvecube(x=rear_margin, y=width, z=height-heatsink_height, rnd=1);
    
    // secondary wall (width reducing)
    translate([12, width - 1.75*th +e, 0]) // not full 'th' because blocked by metal stripe below screw hole
      cube([10, th*0.77, height]);
    
    // Honey comb
    honey_l = length-rear_margin-th-heatsink_overlap;
    translate([(honey_l)/2 + rear_margin, width/2, height - th]) 
      honeycomb(
        size=[honey_l, width], 
        side=11, 
        wall=1.5, 
        h=th, 
        type="hex", 
        fn=12,
        shift=[1, 10.25],
        fill_incomplete=true
    );
  } // end translate
}


parts = ["fan", "heatsink", "logo"];
if (is_undef(part)) // Full model preview --------------------------
{
  difference () {
    translate([-w,-w/2,-gpu_h]) color("#222") fan_shroud();
    mi50_screw_holes(); 
  }
  difference () {
    translate([-w,-w/2,-gpu_h]) color("#222") heatsink_shroud(length=172, width=w-th, height=fan_shroud_h);
    mi50_screw_holes(); 
  }
  translate([-250, 51, 0])  rotate([90]) color("#D22") letters_AMD(w);
  translate([-62.5, 51, 0]) rotate([90]) color("#D22") letters_MI(w);
}
else { // Export selector ------------------------------------------
  if (part == "fan")
  {
    difference () {
      translate([-w,-w/2,-gpu_h]) color("#222") fan_shroud();
      mi50_screw_holes(); 
    }
  } else if (part == "heatsink")
  {
    difference () {
      translate([-w,-w/2,-gpu_h]) color("#222") heatsink_shroud(length=172, width=w-th, height=fan_shroud_h);
      mi50_screw_holes(); 
    }
  } else if (part == "logo")
  {
    color("#222") {
      letters_AMD(w);
      translate([0, 20, 0]) letters_MI(w);
    }
  }
}




