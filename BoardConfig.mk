#
# Copyright 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

LOCAL_DIR := device/zuk/mustang

TARGET_OTA_ASSERT_DEVICE := z2_row,mustang

TARGET_BOARD_PLATFORM := msm8996
TARGET_BOOTLOADER_BOARD_NAME := msm8996

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
ifneq ($(TARGET_USES_AOSP), true)
TARGET_2ND_CPU_VARIANT := cortex-a53
else
TARGET_2ND_CPU_VARIANT := cortex-a9
endif

TARGET_NO_BOOTLOADER := false
TARGET_NO_KERNEL := false
BOOTLOADER_PLATFORM := msm8996 # use msm8996 LK configuration

TARGET_USES_OVERLAY := true
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096

BOARD_USES_GENERIC_AUDIO := true
USE_CAMERA_STUB := true
-include $(QCPATH)/common/msm8996/BoardConfigVendor.mk

# Some framework code requires this to enable BT
BOARD_HAVE_BLUETOOTH := true
BOARD_USES_WIPOWER := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/qcom/common

USE_OPENGL_RENDERER := true
BOARD_USE_LEGACY_UI := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x04000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
ifneq ($(TARGET_USES_AOSP),true)
TARGET_USES_QCOM_BSP := true
endif

# Kernel
BOARD_KERNEL_CMDLINE := console=tty60,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 cma=32M@0-0xffffffff androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00008000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_APPEND_DTB := true
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/zuk/mustang
TARGET_KERNEL_CONFIG := cm_mustang_defconfig
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-

MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

TARGET_NO_RPC := true

TARGET_PLATFORM_DEVICE_BASE := /devices/soc/
# TARGET_INIT_VENDOR_LIB := libinit_msm

#Enable Peripheral Manager
TARGET_PER_MGR_ENABLED := true

#Enable HW based full disk encryption
TARGET_HW_DISK_ENCRYPTION := true

#Enable SW based full disk encryption
TARGET_SWV8_DISK_ENCRYPTION := false

#Enable PD locater/notifier
TARGET_PD_SERVICE_ENABLED := true

BOARD_QTI_CAMERA_32BIT_ONLY := true
TARGET_BOOTIMG_SIGNED := true

#System Properties for MSM8996
TARGET_SYSTEM_PROP := $(LOCAL_DIR)/system.prop

# Enable dex pre-opt to speed up initial boot
ifeq ($(HOST_OS),linux)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_PIC := true
      ifneq ($(TARGET_BUILD_VARIANT),user)
        # Retain classes.dex in APK's for non-user builds
        DEX_PREOPT_DEFAULT := nostripping
      endif
    endif
endif

# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

TARGET_LDPRELOAD := libNimsWrap.so

#TARGET_COMPILE_WITH_MSM_KERNEL := true

#TARGET_KERNEL_APPEND_DTB := true

# SELinux
BOARD_SEPOLICY_DIRS += \
    device/zuk/mustang/sepolicy

include device/qcom/sepolicy/Android.mk

# Added to indicate that protobuf-c is supported in this build
PROTOBUF_SUPPORTED := false

#Add NON-HLOS files for ota upgrade
ADD_RADIO_FILES := true
TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_msm
TARGET_RECOVERY_UI_LIB := librecovery_ui_msm

TARGET_CRYPTFS_HW_PATH := device/qcom/common/cryptfs_hw

#Add support for firmare upgrade on 8996
HAVE_SYNAPTICS_DSX_FW_UPGRADE := true

# Enable MDTP (Mobile Device Theft Protection)
TARGET_USE_MDTP := true

BOARD_HAL_STATIC_LIBRARIES := libhealthd.msm
