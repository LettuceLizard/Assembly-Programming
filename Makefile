.PHONY: clean

all:
	gcc lexyacc-code/y.tab.o lexyacc-code/lex.yy.o lexyacc-code/calc3i.c -o bin/calc3i
	./x86-64-driver.sh calc/harmonic.calc
	./x86-64-driver.sh calc/looptest.calc
	./x86-64-driver.sh calc/test.calc
	./x86-64-driver.sh calc/fact.calc
	./x86-64-driver.sh calc/pi.calc
	./x86-64-driver.sh calc/mytest.calc

clean:
	rm -f bin/* lexyacc-code/*.s lexyacc-code/*.exe


