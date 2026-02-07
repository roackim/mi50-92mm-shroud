#!/bin/bash

# Define the part to export ($1 is the first argument passed to the script)
SELECTED_PART=$1

mkdir -p output

export_part() {
    local part_name=$1
    echo "Exporting $part_name part..."
    openscad shroud.scad -o "output/mi50_part_${part_name}.stl" -D "part=\"${part_name}\""
}

# Logic to decide what to export
if [ -z "$SELECTED_PART" ]; then
    echo "No part specified. Exporting ALL parts..."
    export_part "fan"
    export_part "heatsink"
    export_part "logo"
    export_part "ramp"
    export_part "test"
else
    # Check if the part is valid (optional but helpful)
    case "$SELECTED_PART" in
        fan|heatsink|logo|ramp|test)
            export_part "$SELECTED_PART"
            ;;
        *)
            echo "Error: '$SELECTED_PART' is not a recognized part."
            echo "Usage: ./export.sh [fan|heatsink|logo|ramp|test]"
            exit 1
            ;;
    esac
fi

echo "Done!"
