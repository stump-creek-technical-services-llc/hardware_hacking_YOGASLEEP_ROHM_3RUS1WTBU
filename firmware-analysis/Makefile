# This file is meant to run on GNU/Linux
#
# Dependencies: sleuthkit, binwalk, xxd, sha256sum
# Ubuntu/Debian: sudo apt install sleuthkit binwalk xxd sha256sum

GIT_DIR := $(shell git rev-parse --show-toplevel)
include $(GIT_DIR)/device.sh

FILE ?= $(GIT_DIR)/firmware-images/firmware-free.bin
FILENAME := $(shell echo $(FILE) | rev | cut -d/ -f1 | rev)
OUTPUT_DIR := $(GIT_DIR)/firmware-analysis/output/$(FILENAME).analysis
LOCAL_BINWALK := $(GIT_DIR)/../../tools/binwalk/target/release/binwalk

all:
	make clean
	make analysis FILE=$(GIT_DIR)/firmware-images/yogasleep_rohm_3rus1wtbu.bin
	make analysis FILE=$(GIT_DIR)/firmware-images/firmware-free.bin

analysis: $(OUTPUT_DIR) \
		extractions \
		$(OUTPUT_DIR)/entropy \
		$(OUTPUT_DIR)/fsstat \
		check \
		$(OUTPUT_DIR)/bootloader.bin \

clean:
	rm -rf output

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

extractions: $(OUTPUT_DIR)
	cd $(OUTPUT_DIR) && $(LOCAL_BINWALK) -l $(OUTPUT_DIR)/binwalk.log -Me $(FILE)

$(OUTPUT_DIR)/entropy: $(OUTPUT_DIR)
	binwalk -E $(FILE)

$(OUTPUT_DIR)/fsstat: $(OUTPUT_DIR)
	fsstat $(FILE) > $(OUTPUT_DIR)/fsstat

hash: $(OUTPUT_DIR)
	sha256sum $(FILE) >> $(OUTPUT_DIR)/sha256sums

check: $(OUTPUT_DIR)
	sha256sum -c $(OUTPUT_DIR)/sha256sums || true

$(OUTPUT_DIR)/bootloader.bin: $(OUTPUT_DIR)
	# Extract the bootloader, which lies between offsets 0x3e and 0x1fd
	dd if=$(FILE) of=$(OUTPUT_DIR)/bootloader.bin bs=1 skip=62 count=448
	bin2hex $(OUTPUT_DIR)/bootloader.bin
