#!/bin/bash
INPUT="$1"
BASENAME=$(basename "$INPUT" .calc)

cd lexyacc-code
./build

echo "    .data" > "$BASENAME.s"
echo 'format: .asciz "%d\n"' >> "$BASENAME.s"
echo ".text" >> "$BASENAME.s"
#FACT HERE
cat ../lib/fact >> "$BASENAME.s"
echo ".global main" >> "$BASENAME.s"
echo "main:" >> "$BASENAME.s"
echo $'\tpushq\t%rbp' >> "$BASENAME.s"
echo $'\tmovq\t%rsp, %rbp' >> "$BASENAME.s"
echo $'\tsubq\t$80, %rsp' >> "$BASENAME.s"
./calc3i.exe < ../"$INPUT" >> "$BASENAME.s"
echo $'\taddq\t$80, %rsp' >> "$BASENAME.s"
echo $'\tpopq\t%rbp' >> "$BASENAME.s"
echo $'\tcall\texit' >> "$BASENAME.s"

gcc -c -g -fPIE "$BASENAME.s" -o "$BASENAME.o"
#gcc -nostartfiles -no-pie "$BASENAME.s" -o "$BASENAME.o"
gcc -no-pie "$BASENAME.o" -o "$BASENAME"
mv "$BASENAME" ../bin
rm "$BASENAME.o"
