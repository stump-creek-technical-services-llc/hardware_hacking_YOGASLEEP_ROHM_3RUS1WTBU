# This file contains information about the device associated with this repo,
# and other
# This file is meant to be used as follows:
#   cat myscript
#   #!/usr/bin/env sh
#   . device.sh
#   echo "Nice ${DEV_NAME} you have there."

export DEV_MFR=YOGASLEEP
export DEV_NAME=ROHM
export DEV_PN=3RUS1WTBU
export DEV_VER=

export DEV_TAG=YOGASLEEP_ROHM_3RUS1WTBU
export DEV_TAG_SC=yogasleep_rohm_3rus1wtbu

export FW_RESET_FILENAME=${DEV_TAG_SC}.reset.bin
export FW_FILENAME=${DEV_TAG_SC}.bin
export FW_UPDATE_FILENAME=${DEV_TAG_SC}.update.bin

export FW_RESET_PATH=firmware-images/${FW_RESET_FILENAME}
export FW_PATH=firmware-images/${FW_FILENAME}
export FW_UPDATE_PATH=firmware-images/${FW_UPDATE_FILENAME}
