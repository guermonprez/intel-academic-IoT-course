
CC = gcc

BLINKLED = blinkled
SRCBLINKLED = blinkLed.c
OBJBLINKLED = $(SRCBLINKLED:.c=.o)

GETANALOG = getanalog
SRCGETANALOG = getAnalog.c
OBJGETANALOG = $(SRCGETANALOG:.c=.o)

LEDSENSOR = ledsensor
SRCLEDSENSOR = ledSensor.c
OBJLEDSENSOR = $(SRCLEDSENSOR:.c=.o)


CFLAGS = -Wall -Wextra -ansi -pedantic -D _BSD_SOURCE

LDFLAGS = -lmraa


all:	$(BLINKLED) $(GETANALOG) $(LEDSENSOR)

$(BLINKLED):	$(OBJBLINKLED)
		$(CC) -o $@ $^ $(LDFLAGS)

$(GETANALOG):	$(OBJGETANALOG)
		$(CC) -o $@ $^ $(LDFLAGS)

$(LEDSENSOR):	$(OBJLEDSENSOR)
		$(CC) -o $@ $^ $(LDFLAGS)


%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

.PHONY:	all clean mrproper

clean:
		rm -rf $(OBJBLINKLED)
		rm -rf $(OBJGETANALOG)
		rm -rf $(OBJLEDSENSOR)
		rm -rf $(LEDSENSOR)

mrproper:	clean
		rm -f $(BLINKLED)
		rm -f $(GETANALOG)
		rm -f $(LEDSENSOR)

re:	mrproper all
