CC = gcc
FILES = 
MAIN = main.o
LIBS = 
NAME = forth

%.o: %.c
	$(CC) -g -c -o $@ $< $(LIBS)

make: $(MAIN) $(FILES)
	$(CC) -g  -o $(NAME) $(FILES) $(MAIN) $(LIBS)

clean:
	rm *.o $(NAME)
