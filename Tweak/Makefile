TWEAK_NAME = Plateau
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-module-import-in-extern-c
$(TWEAK_NAME)_CCFLAGS = -Wc++14-extensions -std=c++14
$(TWEAK_NAME)_LIBRARIES = MobileGestalt
$(TWEAK_NAME)_FRAMEWORKS += UIKit Foundation
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS += MediaRemote FrontBoard BulletinBoard
$(TWEAK_NAME)_EXTRA_FRAMEWORKS = Cephei

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk