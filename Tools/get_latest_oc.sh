#!/bin/bash

# Get latest OC for my Hackintosh

# clean up folder
rm -rf EFI
mkdir EFI

sh get_latest_kexts.sh

get_latest_release() {
  curl --silent "https://github.com/$1/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#'
}

download_oc() {
    latest_version=$(get_latest_release $1)
    wget -c "https://github.com/$1/releases/download/$latest_version/$2-$latest_version-RELEASE.zip"
    unzip $2-$latest_version-RELEASE.zip "X64/EFI/*" -d ./
    unzip $2-$latest_version-RELEASE.zip "Docs/*" -d ./
    unzip $2-$latest_version-RELEASE.zip "Utilities/*" -d ./

    mv X64/EFI ./

    mv Docs/Configuration.pdf EFI/OC/
    mv Docs/SampleCustom.plist EFI/OC/
    mv Docs/Changelog.md EFI/OC/

    echo "OpenCore: $latest_version" >> version_info.txt
    echo "OC_VER=$latest_version" >> $GITHUB_ENV
}

download_oc "acidanthera/OpenCorePkg" OpenCore

# Kexts
mv Kexts EFI/OC/
cp -r ../EFI/OC/Kexts/USBMap.kext EFI/OC/Kexts/

# Original config.plist
cp ../EFI/OC/config.plist EFI/OC/
./Utilities/ocvalidate/ocvalidate EFI/OC/config.plist >> EFI/OC/ocvalidate_result.txt
cp ./Utilities/ocvalidate/ocvalidate EFI/OC/

# ACPI
cp -r ../EFI/OC/ACPI EFI/OC/

# Drivers
cp -r ../EFI/OC/Drivers/HfsPlus.efi EFI/OC/Drivers/HfsPlus.efi
rm -rf EFI/OC/Drivers/AudioDxe.efi EFI/OC/Drivers/CrScreenshotDxe.efi EFI/OC/Drivers/HiiDatabase.efi EFI/OC/Drivers/NvmExpressDxe.efi EFI/OC/Drivers/OpenUsbKbDxe.efi EFI/OC/Drivers/Ps2KeyboardDxe.efi EFI/OC/Drivers/Ps2MouseDxe.efi EFI/OC/Drivers/UsbMouseDxe.efi EFI/OC/Drivers/XhciDxe.efi EFI/OC/Drivers/VBoxHfs.efi

# Tools
rm -rf EFI/OC/Tools

# rm Resources
rm -rf EFI/OC/Resources
cp -r ../EFI/OC/Resources EFI/OC/

cp version_info.txt EFI/OC/
