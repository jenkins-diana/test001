CC=gcc
CFLAGS=-Wall

all: bin001 bin002 bin003

bin001: code001/main.c
	$(CC) -o $@ $^ $(CLFAGS)
	
bin002: code002/main.c
	$(CC) -o $@ $^ $(CLFAGS)

bin003: code003/main.c
	$(CC) -o $@ $^ $(CLFAGS)

.PHONY: all clean


clean:
	rm bin001 bin002 bin003
