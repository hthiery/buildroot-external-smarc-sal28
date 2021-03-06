################################################################################
#
# ls1028a-dp-firmware
#
################################################################################

LS1028A_DP_FIRMWARE_VERSION = ls1028a_bsp_01
LS1028A_DP_FIRMWARE_SITE = https://www.nxp.com/lgfiles/sdk/$(LS1028A_DP_FIRMWARE_VERSION)
LS1028A_DP_FIRMWARE_SOURCE = ls1028a-dp-fw.bin
LS1028A_DP_FIRMWARE_INSTALL_TARGET = NO
LS1028A_DP_FIRMWARE_INSTALL_IMAGES = YES

LS1028A_DP_FIRMWARE_LICENSE = NXP Semiconductor Software License Agreement
LS1028A_DP_FIRMWARE_LICENSE_FILES = EULA COPYING
LS1028A_DP_FIRMWARE_REDISTRIBUTE = NO

define LS1028A_DP_FIRMWARE_EXTRACT_CMDS
	$(call FREESCALE_EXTRACT_HELPER,$(LS1028A_DP_FIRMWARE_DL_DIR)/$(LS1028A_DP_FIRMWARE_SOURCE))
endef

define LS1028A_DP_FIRMWARE_INSTALL_IMAGES_CMDS
	cp $(@D)/cadence/mhdp_fw_1_0_51-dptx-hdcp-mcu2.bin $(BINARIES_DIR)/ls1028a-dp-fw.bin
endef

$(eval $(generic-package))
