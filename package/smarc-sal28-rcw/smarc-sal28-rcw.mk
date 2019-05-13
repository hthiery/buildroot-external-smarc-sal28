SMARC_SAL28_RCW_VERSION = 70eed8f53785f18be91bd5e3fea105f9c40d5f1d
SMARC_SAL28_RCW_SITE = $(call github,kontron,rcw-smarc-sal28,$(SMARC_SAL28_RCW_VERSION))
SMARC_SAL28_RCW_LICENSE = BSD-2-Clause
SMARC_SAL28_RCW_LICENSE_FILES = COPYING
SMARC_SAL28_RCW_INSTALL_TARGET = NO
SMARC_SAL28_RCW_INSTALL_IMAGES = YES

SMARC_SAL28_RCW_VARIANT = $(call qstrip,$(BR2_PACKAGE_SMARC_SAL28_RCW_VARIANT))

define SMARC_SAL28_RCW_INSTALL_IMAGES_CMDS
	cp $(@D)/sl28-$(SMARC_SAL28_RCW_VARIANT).bin $(BINARIES_DIR)/rcw.bin
endef

$(eval $(generic-package))
