#!/bin/bash -e
topdir=$PWD
libdir=lib/
OUTPUT=intel_mcu
MCUBIN_FILE=$OUTPUT.bin
MCULIB_FILE=$libdir/$OUTPUT.a
ELF_FILE=$OUTPUT.elf
RAW_FILE=$OUTPUT.raw
DUMP_FILE=$OUTPUT.dump
GCCLIB_FILE="$MCUSDK_PATH/toolchain/$MCUSDK_OS/i686-elf-gcc/i686-elf/lib"
LDS_FILE=$libdir/mcu.lds
OBJCOPYFLAGS_FILE=$libdir/objcopyflags
LDFLAGS="-X -N --gc-section -X -N -Ttext 0xFF300000 -e __Start -static --no-undefined -nostartfiles -nostdlib -nodefaultlibs"
OBJCOPY_FLAGS="-j .pshinit -j .builtin_fw -O binary -j .text -j .rodata -j .data -j .bss --set-section-flags .bss=alloc,load,contents"
function generate_mcu_elf {
	if [ -e $ELF_FILE ]; then rm $ELF_FILE;fi
	i686-elf-ld -T $LDS_FILE $LDFLAGS -L"$GCCLIB_FILE" $MCULIB_FILE $1 -lc -o $ELF_FILE
}

function binstring ()
{
        h1=$(($1%256))
        h2=$((($1/256)%256))
        h3=$((($1/256/256)%256))
        h4=$((($1/256/256/256)%256))
        binstr=`printf "\x5cx%02x\x5cx%02x\x5cx%02x\x5cx%02x" $h1 $h2 $h3 $h4`
}

function generate_mcu_bin {
	if [ -e $MCUBIN_FILE ]; then rm $MCUBIN_FILE;fi
	i686-elf-objdump -D $ELF_FILE > $DUMP_FILE
	i686-elf-objcopy $OBJCOPY_FLAGS $ELF_FILE $RAW_FILE
	dd if=/dev/zero of=VRL bs=1 count=728
	if [ "$MCUSDK_OS" = "darwin-x86_64" ]; then
		binstring $((`stat -L -f %z $RAW_FILE`/4))
	else
		binstring $((`stat -L -c %s $RAW_FILE`/4))
	fi
	printf $binstr | dd of=VRL bs=1 seek=724 conv=notrunc
	cat VRL $RAW_FILE > $MCUBIN_FILE
	echo Create $MCUBIN_FILE
	rm -rf VRL
	rm -r $ELF_FILE
	rm $DUMP_FILE
	rm $RAW_FILE
}

generate_mcu_elf $1
generate_mcu_bin
