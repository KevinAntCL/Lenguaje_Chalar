simple: lex.yy.o simple.tab.o
	gcc -o simple $^

simple.tab.h: simple.y
	#bison --debug --verbose -d simple.y
	bison -d simple.y
simple.tab.c: simple.y
	bison  simple.y

lex.yy.c: simple.flex simple.tab.h
	flex  simple.flex

clear:
	rm *.c
	rm *.o
	rm simple
	rm simple.tab.*