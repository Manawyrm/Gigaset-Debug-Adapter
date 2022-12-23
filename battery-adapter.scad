// Written by Tobias Mädel <t.maedel@alfeld.de>
// https://github.com/manawyrm
// https://tbspace.de/

circle_segments = 360;
battery_diameter = 10.36;
battery_length   = 40.00;
battery_length_pole = 1.20;
battery_pole_diameter = 3.80;

pcb_height = 1.6;
platform_height = (battery_diameter / 2) - pcb_height;

pogo_passthru_length = 8;
pogo_passthru_height = 4;

// battery minus to pogo center
battery_to_pogo = 12.85;

// battery minus to screw hole center
battery_to_screw = 20.21;

// fit for M3 brass threaded insert
screw_hole_diameter = 4;
screw_hole_depth = 7.2;
screw_hole_distance = 5.45;

difference() {
    union() {
        // plattform for the PCB
        color("black")
            translate([0,0,battery_diameter / 2 + (platform_height / 2)])
                cube([
                    battery_length,
                    battery_diameter * 2,
                    platform_height
                ],center=true);

        // AAA batteries
        difference() {
            union() 
            {
                color("white")
                {
                    for (i=[0:1])
                    {
                        translate([
                            0,
                            (0.5 * battery_diameter) - (i * battery_diameter),
                            battery_diameter / 2
                        ])
                        {
                            // swapped polarity
                            rotate([0, 270 - (i * 180), 0])
                            {
                                // main battery
                                linear_extrude(height = battery_length, center = true)
                                    circle(d = battery_diameter, $fn=circle_segments);

                                // battery positive pole
                                //translate([0,0,battery_length / 2 + (battery_length_pole / 2)])
                                //    linear_extrude(height = battery_length_pole, center = true)
                                //        circle(d = battery_pole_diameter, $fn=circle_segments);
                            }
                        }
                    }
                }
            }
            translate([0,0,10])
            {
                 cube([
                        battery_length,
                        battery_diameter * 2,
                        platform_height
                    ],center=true);
             }
        }
    }

    // pogo pin hole
    translate([-1 * (battery_length / 2 - pogo_passthru_height / 2) + battery_to_pogo,
                0,
                battery_diameter / 2 + (platform_height / 2)
              ])
        cube([
            pogo_passthru_height,
            pogo_passthru_length,
            50
        ],center=true);
    
    // screw holes
    translate([-1 * (battery_length / 2) + battery_to_screw,
                screw_hole_distance,
                battery_diameter / 2 + (platform_height / 2)
              ])
        cylinder(h=screw_hole_depth,
                 r1=screw_hole_diameter / 2,
                 r2=screw_hole_diameter / 2,
                 center = true,
                 $fn=circle_segments);
                 
    translate([-1 * (battery_length / 2) + battery_to_screw,
                -screw_hole_distance,
                battery_diameter / 2 + (platform_height / 2)
              ])
        cylinder(h=screw_hole_depth,
                 r1=screw_hole_diameter / 2,
                 r2=screw_hole_diameter / 2,
                 center = true,
                 $fn=circle_segments);
}