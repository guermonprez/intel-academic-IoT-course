
NAME = mcu_customsignal
ARCHIVE_NAME = $(NAME).a

MCUSDK_PATH = /home/root/mcu-sdk
TOOLCHAINPATH = $(MCUSDK_PATH)/toolchain/linux-x86/i686-elf-gcc/
BINPATH = $(TOOLCHAINPATH)/bin
LIBPATH = $(TOOLCHAINPATH)/lib


SRC = src/main.c

OBJ = $(SRC:.c=.o)

CC = $(BINPATH)/i686-elf-gcc
AR = $(BINPATH)/i686-elf-ar

CFLAGS = -I"./include"
CFLAGS += -I$(TOOLCHAINPATH)/"i686-elf/include"
CFLAGS += -I$(TOOLCHAINPATH)/"i686-elf/usr/include"
CFLAGS += -I$(TOOLCHAINPATH)/"lib/gcc/i686-elf/4.6.1/include"
CFLAGS += -I$(TOOLCHAINPATH)/"lib/gcc/i686-elf/4.6.1/include-fixed"
CFLAGS += -O3 -Wall -c -fmessage-length=0
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)"



INTERNALTOOLS_PATH = ./internal_tools

$(ARCHIVE_NAME):	$(OBJ)
	./scripts/envsetup.sh
	@echo 'Building target: $@'
	@echo 'Invoking: Cross GCC Archiver'
	$(AR) -r  $(ARCHIVE_NAME) $(OBJ)$(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '
	MCUSDK_PATH=$(MCUSDK_PATH) $(MAKE) --no-print-directory generate_mcu_bin

%.o:%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	$(CC) $(CFLAGS) -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

generate_mcu_bin:
	echo 'Generate binary internal'
	PATH=${PATH}:$(BINPATH) ./internal_tools/generate_mcu_bin.sh  $(ARCHIVE_NAME)
	echo ' '

clean:
		rm -rf $(OBJ)
	rm -f $(ARCHIVE_NAME)
	rm -f intel_mcu.bin

install:
	cp intel_mcu.bin /lib/firmware
