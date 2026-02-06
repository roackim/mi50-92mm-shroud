#!/bin/bash

mkdir -p output

echo "Exporting fan shroud part"
openscad shroud.scad -o output/mi50_part_fan.stl -D 'part="fan"' 

echo "Exporting heatsink shroud part"
openscad shroud.scad -o output/mi50_part_heatsink.stl -D 'part="heatsink"' 

echo "Exporting logo part"
openscad shroud.scad -o output/mi50_part_logo.stl -D 'part="logo"'

echo "Exporting ramp part"
openscad shroud.scad -o output/mi50_part_ramp.stl -D 'part="ramp"'
