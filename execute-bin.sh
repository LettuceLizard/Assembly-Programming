#!/bin/bash

if [ -d "bin" ]; then
    for file in bin/*; do
        if [[ "$(basename "$file")" == "calc3i" ]]; then
            echo "Skipping calc3i file: $file"
            continue
        fi

        if [ -x "$file" ]; then
            echo "Executing file: $file"
            "$file"
        else
            echo "Skipping non-executable file: $file"
        fi
    done
else
    echo "Folder 'bin' does not exist!"
fi
