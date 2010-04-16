BUILD_OLD_LIBCAMERA:=true
ifeq ($(BUILD_OLD_LIBCAMERA),true)

# When zero we link against libqcamera; when 1, we dlopen libqcamera.
DLOPEN_LIBQCAMERA:=1

ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH:= $(call my-dir)

ifeq ($(BOARD_LIBQCAMERA),)
    # default qcom name
    BOARD_LIBQCAMERA := libqcamera
endif

include $(CLEAR_VARS)

LOCAL_CFLAGS:=-fno-short-enums
LOCAL_CFLAGS+=-DDLOPEN_LIBQCAMERA=$(DLOPEN_LIBQCAMERA)
LOCAL_CFLAGS+=-DLIBQCAMERA=\"$(BOARD_LIBQCAMERA)\"

LOCAL_SRC_FILES:= QualcommCameraHardware.cpp

LOCAL_SHARED_LIBRARIES:= libutils libbinder libui liblog
ifneq ($(DLOPEN_LIBQCAMERA),1)
LOCAL_SHARED_LIBRARIES+= $(BOARD_LIBQCAMERA)
else
LOCAL_SHARED_LIBRARIES+= libdl
endif

LOCAL_MODULE:= libcamera

include $(BUILD_SHARED_LIBRARY)

endif # not BUILD_TINY_ANDROID
endif # BUILD_OLD_LIBCAMERA
