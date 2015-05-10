
all:
	make -C getAnalog
	make -C setPinState
	make -C readDigitalPin
	cd servomotor && sh ./compile.sh && cd ..

	mkdir build
	cp ./getAnalog/getAnalog ./build
	cp ./setPinState/setPinState ./build
	cp ./readDigitalPin/readDigitalPin ./build
	cp ./servomotor/bin/* ./build

.PHONY:	all clean

clean:
	rm -rf build

re:	clean all