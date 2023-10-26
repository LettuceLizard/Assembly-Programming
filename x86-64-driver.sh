#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file.calc>"
    exit 1
fi

INPUT="$1"
BASENAME=$(basename "$INPUT" .calc)

cd lexyacc-code_lab3
pwd
./build

echo "    .data" > "$BASENAME.s"
echo 'format: .asciz "%d\n"' >> "$BASENAME.s"
echo ".text" >> "$BASENAME.s"
echo ".global main" >> "$BASENAME.s"
echo "main:" >> "$BASENAME.s"
./calc3b.exe < ../"$INPUT" >> "$BASENAME.s"
echo $'\tcall\texit' >> "$BASENAME.s"

gcc -c -g -fPIE "$BASENAME.s" -o "$BASENAME.o"
#gcc -nostartfiles -no-pie "$BASENAME.s" -o "$BASENAME.o"
gcc -no-pie "$BASENAME.o" -o "$BASENAME"
rm "$BASENAME.o"
