# This file is meant to run on GNU/Linux
# 
# Dependencies: dosfstools, mtools
# Ubuntu/Debian: sudo apt install dosfstools mtools

GIT_DIR := $(shell git rev-parse --show-toplevel)
include $(GIT_DIR)/device.sh

OUTPUT_DIR := $(GIT_DIR)/firmware-images-free/output
NAME ?= firmware-free
IMAGE_PATH = $(OUTPUT_DIR)/$(NAME).bin
LOOP_DEV_PATH := loop_dev
DEV = $(shell losetup -j $(IMAGE_PATH) | cut -d: -f1)
FILES_DIR = $(GIT_DIR)/firmware-images-free/files

# Set up the loopback device, emulating an erased 2 MiB flash ROM.
loop: $(OUTPUT_DIR)
	@if [ -z "$(DEV)" ]; then \
		dd if=/dev/zero count=2MiB | LANG=C tr "\0" "\377" > $(IMAGE_PATH) && \
		sudo losetup -f --show $(IMAGE_PATH); \
	fi

fs: $(OUTPUT_DIR)
	@if [ -z "$(DEV)" ]; then \
		echo "Loopback device is missing. Run 'make loop' first." && \
		exit 1; \
	fi

	sudo mkfs -t vfat \
		-i 0xcc00fed9 \
		-R 8 \
		-s 1 \
		-g 1/1 \
		$(DEV)
	# @0x18: Physical sectors per track: 0100
	sync
	echo "MSDOS5.0" | dd of=$(IMAGE_PATH) seek=3B cbs=8B count=8B conv=block,notrunc
	bin2hex $(IMAGE_PATH)

firmware: fs
	mcopy -i $(IMAGE_PATH) -pms $(FILES_DIR)/* ::/
	mdir -i $(IMAGE_PATH)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

clean:
	if [ ! -z "$(DEV)" ]; then \
		sudo losetup -d $(DEV); \
	fi
	rm -f $(LOOP_DEV_PATH)
	rm -rf $(OUTPUT_DIR)
