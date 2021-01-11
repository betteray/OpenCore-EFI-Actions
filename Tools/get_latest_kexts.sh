#!/bin/bash

# Get latest kexts for my hackintosh

# clean up folder
rm -rf Kexts
mkdir Kexts

get_latest_release() {
    curl --silent "https://github.com/$1/latest" | sed 's#.*tag/\(.*\)\".*#\1#'
}

download_kext() {
    latest_version=$(get_latest_release $1)
    wget -c "https://github.com/$1/releases/download/$latest_version/$2-$latest_version-RELEASE.zip"
    unzip $2-$latest_version-RELEASE.zip "$2.kext/*" -d Kexts/
    echo "$2: $latest_version" >> EFI/OC/Others/version_info.txt
}

download_virtualsmc() {
    latest_version=$(get_latest_release $1)
    wget -c "https://github.com/$1/releases/download/$latest_version/$2-$latest_version-RELEASE.zip"
    unzip $2-$latest_version-RELEASE.zip "Kexts/$3.kext/*" -d ./
    echo "$3: $latest_version" >> EFI/OC/Others/version_info.txt
}

download_kext "acidanthera/Lilu" Lilu
download_kext "acidanthera/AppleALC" AppleALC
download_kext "acidanthera/WhateverGreen" WhateverGreen
download_kext "acidanthera/IntelMausi" IntelMausi

download_virtualsmc "acidanthera/VirtualSMC" VirtualSMC VirtualSMC
