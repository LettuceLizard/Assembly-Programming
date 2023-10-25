#!/bin/bash
# Check for correct usage
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file.calc>"
    exit 1
fi


# Get the input file and the base name for the output files
INPUT="$1"
BASENAME=$(basename "$INPUT" .calc)

cd ~/Programmering-i-UNIX-Labb-2/Assembly-Programming/lexyacc-code_lab3
./build
#gcc -o calc3i calc3b.c y.tab.c lex.yy.c -lfl


#echo "./calc3i < ../"$INPUT" "
./calc3b.exe < ../"$INPUT" > "$BASENAME.s"

# Assemble the generated assembly code to produce an object file
gcc -c "$BASENAME.s" -o "$BASENAME.o"

# Link the object file to produce the final executable
gcc "$BASENAME.o" -o "$BASENAME"

# Cleanup
rm "$BASENAME.o"
