#
# Copyright (C) 2009 The Android Open Source Project
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

# libcamera dlopen's libqcamera.so (very old msm7k)
# libcamera2 dlopen's libmmcamera.so (new msm7k & qsd8k)

common_msm_dirs := libcopybit liblights librpc liboverlay libcamera2
msm7k_dirs := $(common_msm_dirs) boot libaudio libgralloc
qsd8k_dirs := $(common_msm_dirs) libaudio-qsd8k libgralloc-qsd8k
msm7x30_dirs := $(common_msm_dirs) libaudio-msm7x30 libgralloc-qsd8k

ifeq ($(TARGET_BOARD_PLATFORM),msm7k)
    ifeq ($(BOARD_USES_QCOM_AUDIO_V2), true)
        include $(call all-named-subdir-makefiles,$(msm7x30_dirs))
    else
        include $(call all-named-subdir-makefiles,$(msm7k_dirs))
    endif
else
    ifeq ($(TARGET_BOARD_PLATFORM),qsd8k)
        include $(call all-named-subdir-makefiles,$(qsd8k_dirs))
    endif
endif

