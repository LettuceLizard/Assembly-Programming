.PHONY: clean

# Why does this generate an error??
all:
	cd lexyacc-code_lab3 && ./build && gcc -o calc3i calc3b.c y.tab.c lex.yy.c -lfl

clean:
	rm -f lexyacc-code_lab3/*.exe lexyacc-code_lab3/lex.yy.c lexyacc-code_lab3/*.o lexyacc-code_lab3/y.tab.c lexyacc-code_lab3/y.tab.h lexyacc-code_lab3/*.s
