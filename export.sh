#!/bin/bash

mkdir -p output

openscad shroud.scad -o output/mi50_part_fan.stl -D 'part="fan"' 
openscad shroud.scad -o output/mi50_part_heatsink.stl -D 'part="heatsink"' 
openscad shroud.scad -o output/mi50_part_logo.stl -D 'part="logo"'
