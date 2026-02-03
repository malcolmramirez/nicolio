#!/bin/bash

convert_thumb () {
    if [ -f "$dir/thumb.png" ]; then
        echo "Skipping conversion for $dir, thumb.png already exists"
    else
        # Get the width of the image
        width=$(identify -format "%w" "$dir/art.png")
        # Crop the image to a square based on its width
        magick "$dir/art.png" -gravity center -crop "${width}x${width}+0+0" "$dir/thumb.png"
        echo "Created thumbnail in $dir"
    fi
}

# Navigate to the art directory
cd ../content/art || exit

# Loop through each directory in art
for dir in */; do
    # Check if art.png exists
    if [ -f "$dir/art.png" ]; then
        convert_thumb
    else
        # Handle other image formats (art.PNG, art.HEIC)
        for img in "$dir"/*.{png,PNG,HEIC,heic,jpg,JPG,jpeg,JPEG}; do
            if [ -f "$img" ]; then
                # convert
                magick "$img" -quality 100 "$dir/art.png"
                convert_thumb
                break
            fi
        done
    fi
done
