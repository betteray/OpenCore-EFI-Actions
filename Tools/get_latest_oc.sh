#!/bin/bash

# Get latest OC for my Hackintosh

# clean up folder
rm -rf EFI
mkdir EFI

sh get_latest_kexts.sh

get_latest_release() {
    curl --silent "https://github.com/$1/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#'
}

copy_docs() {
    unzip $OC_ZIP "Docs/*" -d ./
    mkdir -p EFI/OC/Others
    mv Docs/Configuration.pdf EFI/OC/Others/
    mv Docs/SampleCustom.plist EFI/OC/Others/
    mv Docs/Changelog.md EFI/OC/Others/

    cp ./Utilities/ocvalidate/ocvalidate EFI/OC/Others/
    ./Utilities/ocvalidate/ocvalidate EFI/OC/config.plist >> EFI/OC/Others/ocvalidate_result.txt
}

download_oc() {
    latest_version=$(get_latest_release $1)
    wget -c "https://github.com/acidanthera/OpenCorePkg/releases/download/$OC_VERSION/OpenCore-$OC_VERSION-RELEASE.zip"
    unzip $OC_ZIP "X64/EFI/*" -d ./    
    unzip $OC_ZIP "Utilities/*" -d ./

    mv X64/EFI ./

    echo "OC_VER=$OC_VERSION" >> $GITHUB_ENV
}

OC_VERSION=$(get_latest_release acidanthera/OpenCorePkg)
OC_ZIP=OpenCore-$OC_VERSION-RELEASE.zip

download_oc

# Kexts
mv Kexts EFI/OC/
cp -r ../EFI/OC/Kexts/USBMap.kext EFI/OC/Kexts/

# Original config.plist
cp ../EFI/OC/config.plist EFI/OC/

# ACPI
cp -r ../EFI/OC/ACPI EFI/OC/

# Drivers
cp -r ../EFI/OC/Drivers/HfsPlus.efi EFI/OC/Drivers/HfsPlus.efi
rm -rf EFI/OC/Drivers/AudioDxe.efi EFI/OC/Drivers/CrScreenshotDxe.efi EFI/OC/Drivers/HiiDatabase.efi EFI/OC/Drivers/NvmExpressDxe.efi EFI/OC/Drivers/OpenUsbKbDxe.efi EFI/OC/Drivers/Ps2KeyboardDxe.efi EFI/OC/Drivers/Ps2MouseDxe.efi EFI/OC/Drivers/UsbMouseDxe.efi EFI/OC/Drivers/XhciDxe.efi EFI/OC/Drivers/OpenHfsPlus.efi

# Tools
rm -rf EFI/OC/Tools

# rm Resources
rm -rf EFI/OC/Resources
cp -r ../EFI/OC/Resources EFI/OC/

copy_docs
