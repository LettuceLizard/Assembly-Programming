.PHONY: clean

all:
	./x86-64-driver.sh src/harmonic.calc
	./x86-64-driver.sh src/looptest.calc
	./x86-64-driver.sh src/test.calc
	./x86-64-driver.sh src/fact.calc
	./x86-64-driver.sh src/pi.calc
	./x86-64-driver.sh src/mytest.calc

clean:
	rm -f src/*.exe src/lex.yy.c src/*.o src/y.tab.c src/y.tab.h src/*.s src/harmonic src/pi src/test src/looptest src/mytest bin/*

