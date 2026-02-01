#!/bin/bash

# Navigate to the art directory
cd ../content/art || exit

# Loop through each directory in art
for dir in */; do
    # Check if art.png exists
    if [ -f "$dir/art.png" ]; then
        # Get the width of the image
        width=$(identify -format "%w" "$dir/art.png")

        # Crop the image to a square based on its width
        convert "$dir/art.png" -gravity center -crop "${width}x${width}+0+0" "$dir/thumb.png"

        echo "Processed $dir/art.png -> $dir/thumb.png"
    else
        # Handle other image formats (art.PNG, art.HEIC)
        for img in "$dir"/art.*; do
            if [[ $img == *.png || $img == *.PNG || $img == *.HEIC || $img == *.heic ]]; then
                # Get the width of the image
                width=$(identify -format "%w" "$img")

                # Crop the image to a square based on its width
                convert "$img" -gravity center -crop "${width}x${width}+0+0" "$dir/thumb.png"

                echo "Processed $img -> $dir/thumb.png"
                break
            fi
        done
    fi
done

