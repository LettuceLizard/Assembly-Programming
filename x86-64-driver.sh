#!/bin/bash
INPUT="$1"
BASENAME=$(basename "$INPUT" .calc)

cd lexyacc-code
./build


echo "    .data" > "$BASENAME.s"
echo 'format: .asciz "%d\n"' >> "$BASENAME.s"
echo ".text" >> "$BASENAME.s"
cat ../src/fact.s >> "$BASENAME.s"
echo ".global main" >> "$BASENAME.s"
echo "main:" >> "$BASENAME.s"
echo $'\tpushq\t%rbp' >> "$BASENAME.s"
echo $'\tmovq\t%rsp, %rbp' >> "$BASENAME.s"
echo $'\tsubq\t$80, %rsp' >> "$BASENAME.s"
cd ../bin && ./calc3i < "../$INPUT" >> "../lexyacc-code/$BASENAME.s" && cd - > /dev/null
echo $'\taddq\t$80, %rsp' >> "$BASENAME.s"
echo $'\tpopq\t%rbp' >> "$BASENAME.s"
#echo $'\tcall\texit' >> "$BASENAME.s" -> seg faults
echo $'\tmovq\t$0, %rdi\n\tmovq\t$60, %rax\n\tsyscall' >> "$BASENAME.s"

gcc -c -g -fPIE "$BASENAME.s" -o "$BASENAME.o" > /dev/null 2>&1
#gcc -nostartfiles -no-pie "$BASENAME.s" -o "$BASENAME.o"
gcc "$BASENAME.o" -o "$BASENAME" > /dev/null 2>&1
mv "$BASENAME" ../bin
mv "$BASENAME.s" ../build
rm "$BASENAME.o"
