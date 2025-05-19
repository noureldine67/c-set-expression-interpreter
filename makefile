all:
	bison -d src/tp2.y
	lex src/tp2.lex
	mv lex.yy.c src/
	mv tp2.tab.c src/
	mv tp2.tab.h src/
	gcc -lfl -o tp.exe src/lex.yy.c src/tp2.tab.c src/tp2.tab.h

clean:
	rm tp.exe src/tp2.tab.c src/lex.yy.c src/tp2.tab.h
