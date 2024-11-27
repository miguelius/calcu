calcu: calcu.y calcu.l
	bison -d calcu.y
	flex -ocalcu.c calcu.l
	gcc calcu.tab.c calcu.c -o calcu -lm

clean:
	rm -rf *.tab.* calcu
