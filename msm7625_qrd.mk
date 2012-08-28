PRODUCT_PACKAGES := \
    IM \
    VoiceDialer \
    SdkSetup


$(call inherit-product, build/target/product/generic.mk)

#Enabling Ring Tones
include frameworks/base/data/sounds/OriginalAudio.mk

#ifneq (, $(filter msm7625_qrd, $(TARGET_PRODUCT)))
#PRODUCT_COPY_FILES +=\
#        vendor/qcom/qrd-proprietary/frameworks/base/service/com.GbcLed.server.xml:system/etc/permissions/com.GbcLed.server.xml
#endif

PRODUCT_COPY_FILES +=\
		device/qcom/msm7625_qrd/sw_ver.txt:system/etc/sw_ver.txt \
                packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml 		
# Overrides
PRODUCT_BRAND := qcom
PRODUCT_NAME := msm7625_qrd
PRODUCT_DEVICE := msm7625_qrd
PRODUCT_MODEL := sandiego_QRD7225-AD-TO-CA_SSSS

QC_PROP := true
