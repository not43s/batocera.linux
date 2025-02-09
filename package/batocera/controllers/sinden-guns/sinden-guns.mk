################################################################################
#
# sinden-guns
#
################################################################################
SINDEN_GUNS_VERSION = 1.07
SINDEN_GUNS_SOURCE=SindenLightgunSoftwareReleaseV$(SINDEN_GUNS_VERSION).zip
SINDEN_GUNS_SITE=https://www.sindenlightgun.com/software

ifeq ($(BR2_x86_64),y)
  SINDEN_GUNS_ARCHIVE_DIR_PLAYER1=SindenLightgunSoftwareReleaseV$(SINDEN_GUNS_VERSION)/SindenLightgunLinuxSoftwareV$(SINDEN_GUNS_VERSION)/X86/64bit/Lightgun/Player1
else ifeq ($(BR2_aarch64)$(BR2_arm),y)
  SINDEN_GUNS_ARCHIVE_DIR_PLAYER1=SindenLightgunSoftwareReleaseV$(SINDEN_GUNS_VERSION)/SindenLightgunLinuxSoftwareV$(SINDEN_GUNS_VERSION)/Pi-Arm/Lightgun/Player1
else
  SINDEN_GUNS_ARCHIVE_DIR_PLAYER1=invalid_directory
endif

define SINDEN_GUNS_EXTRACT_CMDS
	mkdir -p $(@D) && cd $(@D) && unzip -x $(DL_DIR)/$(SINDEN_GUNS_DL_SUBDIR)/$(SINDEN_GUNS_SOURCE)
endef

define SINDEN_GUNS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/controllers/sinden-guns/99-sinden.rules $(TARGET_DIR)/etc/udev/rules.d/99-sinden.rules
	$(INSTALL) -m 0755 -D $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/controllers/sinden-guns/virtual-sindenlightgun-add $(TARGET_DIR)/usr/bin/virtual-sindenlightgun-add

	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/controllers/sinden-guns/LightgunMono.exe.config.template $(TARGET_DIR)/usr/share/sinden/LightgunMono.exe.config

	$(INSTALL) -m 0644 -D $(@D)/$(SINDEN_GUNS_ARCHIVE_DIR_PLAYER1)/LightgunMono.exe      $(TARGET_DIR)/usr/share/sinden/LightgunMono.exe
	$(INSTALL) -m 0644 -D $(@D)/$(SINDEN_GUNS_ARCHIVE_DIR_PLAYER1)/AForge.Math.dll       $(TARGET_DIR)/usr/share/sinden/AForge.Math.dll
	$(INSTALL) -m 0644 -D $(@D)/$(SINDEN_GUNS_ARCHIVE_DIR_PLAYER1)/AForge.dll            $(TARGET_DIR)/usr/share/sinden/AForge.dll
	$(INSTALL) -m 0644 -D $(@D)/$(SINDEN_GUNS_ARCHIVE_DIR_PLAYER1)/AForge.Imaging.dll    $(TARGET_DIR)/usr/share/sinden/AForge.Imaging.dll
	$(INSTALL) -m 0644 -D $(@D)/$(SINDEN_GUNS_ARCHIVE_DIR_PLAYER1)/libSdlInterface.so    $(TARGET_DIR)/usr/share/sinden/libSdlInterface.so
	$(INSTALL) -m 0644 -D $(@D)/$(SINDEN_GUNS_ARCHIVE_DIR_PLAYER1)/libCameraInterface.so $(TARGET_DIR)/usr/share/sinden/libCameraInterface.so
	$(INSTALL) -m 0644 -D $(@D)/$(SINDEN_GUNS_ARCHIVE_DIR_PLAYER1)/License.txt           $(TARGET_DIR)/usr/share/sinden/License.txt
endef

$(eval $(generic-package))
