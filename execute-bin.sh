#!/bin/bash

# Check if the bin folder exists
if [ -d "bin" ]; then
    # Loop through each file in the bin folder
    for file in bin/*; do
        # Check if the file is executable
        if [ -x "$file" ]; then
            # Print the name of the file
            echo "Executing file: $file"
            # Execute the file
            "$file"
        else
            echo "Skipping non-executable file: $file"
        fi
    done
else
    echo "Folder 'bin' does not exist!"
fi
