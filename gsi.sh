#!/bin/bash
function tg_sendText() {
curl -s "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
-d "parse_mode=html" \
-d text="${1}" \
-d chat_id=$CHAT_ID \
-d "disable_web_page_preview=true"
}

function tg_sendFile() {
curl -F chat_id=$CHAT_ID -F document=@${1} -F parse_mode=markdown https://api.telegram.org/bot$BOT_TOKEN/sendDocument
}

BUILD_START=$(date +"%s");

tg_sendText "Installing git"
sudo apt install git -y
mkdir /tmp/gsi
tg_sendText "Cloning GSI Builds"
git clone https://github.com/ProjectSuzu/treble_build_miku -b snowland
tg_sendText "Prepairing to build GSI"
tg_sendtext "Building..."
bash treble_build_miku/build.sh
tg_sendText "Build completed! Uploading rom"
BD=/tmp/gsi
export BD=/tmp/gsi
VERSION="0.5.0"
export VERSION="0.5.0"
curl bashupload.com -T $BD/MikuUI-SNOWLAND-$VERSION-a64-ab-ItzKaguyaGSI-UNOFFICIAL.img.xz | tee download-link.txt
sleep 10
curl bashupload.com -T $BD/MikuUI-SNOWLAND-$VERSION-a64-ab-vndklite-ItzKaguyaGSI-UNOFFICIAL.img.xz | tee download-link-vndklite.txt
sleep 10
tg_sendFile "download-link.txt"
tg_sendFile "download-link-vndklite.txt"

BUILD_END=$(date +"%s");
DIFF=$(($BUILD_END - $BUILD_START));


tg_sendText "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
