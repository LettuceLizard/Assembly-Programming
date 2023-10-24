#!/bin/bash

if [ $# -lt 1 ]; then
    echo "input *.calc file needed"
    exit 1
fi

INPUT="$1" # Path to file
INPUT_FILE=$(basename "$INPUT" .s) # Just filename (*.calc)


as -o "${INPUT_FILE}.o" "$INPUT"
#ld -o "$INPUT_FILE" "${INPUT_FILE}.o" || exit 3

#echo "$INPUT_FILE"