
CC = gcc

NAME = readDigitalPin

SRC = readDigitalPin.c
OBJ = $(SRC:.c=.o)


CFLAGS = -Wall -Wextra -ansi -pedantic -D _BSD_SOURCE

LDFLAGS = -lmraa


all:	$(NAME)

$(NAME):	$(OBJ)
		$(CC) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

.PHONY:	all clean mrproper

clean:
		rm -rf $(OBJ)

mrproper:	clean
		rm -f $(NAME)

re:	mrproper all