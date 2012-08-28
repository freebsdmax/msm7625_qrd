# Copyright (c) 2009, Code Aurora Forum.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
#  [WIFI] If enable Wi-Fi Support. Set "BOARD_HAVE_WIFI := true"
#  ! NOTICE !
#  The switch is enable wireless support from SYSTEM(outside kernel) ONLY.
#  Please Turn-ON kernel support manual in KernelConfig -> Device Drivers ->
#   Network device support -> Wireless LAN -> Atheros AR6K...
#

#
# config.mk
# 
# Product-specific compile-time definitions.
#

ifeq ($(QC_PROP),true)
    BOARD_USES_QCOM_HARDWARE := true
    BOARD_USE_QCOM_TESTONLY := true

    ifneq ($(BUILD_TINY_ANDROID), true)
    BOARD_GPS_LIBRARIES := libloc
    BOARD_CAMERA_LIBRARIES := libcamera
    BOARD_HAVE_BLUETOOTH := true
    #  [WIFI] If enable Wi-Fi Support. Set "BOARD_HAVE_WIFI := true"
    BOARD_HAVE_WIFI := true
    endif   # !BUILD_TINY_ANDROID

else
    BOARD_USES_GENERIC_AUDIO := true
    USE_CAMERA_STUB := true

endif # QC_PROP

TARGET_HAVE_TSLIB := true

TARGET_NO_BOOTLOADER := false
TARGET_NO_KERNEL := false
TARGET_NO_RADIOIMAGE := true

TARGET_CPU_ABI := armeabi
TARGET_BOARD_PLATFORM := msm7k
TARGET_BOOTLOADER_BOARD_NAME := MSM7625_QRD
QCOM_TARGET_PRODUCT := msm7625_qrd
#TARGET_USES_2G_VM_SPLIT := true

BOARD_KERNEL_BASE    := 0x00200000
BOARD_NAND_PAGE_SIZE := 2048

BOARD_KERNEL_CMDLINE := mem=216M console=ttyMSM2,115200n8 androidboot.hardware=qcom
#BOARD_KERNEL_CMDLINE := mem=216M console=/dev/null androidboot.hardware=qcom lpj=2637824
BOARD_EGL_CFG := device/qcom/$(TARGET_PRODUCT)/egl.cfg

BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00500000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00500000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x08200000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x05A00000
BOARD_FLASH_BLOCK_SIZE := $(BOARD_NAND_PAGE_SIZE) * 64

BOARD_DEVEL_TOOLS := busybox oprofile
ifeq ($(TARGET_BUILD_TYPE),debug)
  ifeq ($(TARGET_BUILD_VARIANT),userdebug)
	QCOM_TARGET_PRODUCT_GCF := QCRIL_UUS
  endif
endif

#  [WIFI] Wi-Fi support
ifeq ($(BOARD_HAVE_WIFI),true)
    BOARD_WIFI_ATH_AR6K := true
    BOARD_WLAN_ATHEROS_SDK := system/wlan/atheros/AR6kSDK.2.2.1.151
    WPA_SUPPLICANT_VERSION := VER_0_6_X
    BOARD_WPA_SUPPLICANT_DRIVER := AR6000
endif # BOARD_HAVE_WIFI
