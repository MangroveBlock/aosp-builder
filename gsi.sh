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

ls -a
tg_sendText "Cloning GSI Builds"
git clone https://github.com/MizuNotCool/treble_build_pe -b twelve
tg_sendText "Prepairing to build GSI"
tg_sendText "Building..."
bash treble_build_pe/build.sh
tg_sendText "Build completed! Uploading rom"
BD=/tmp/builds
export BD=/tmp/builds
curl bashupload.com -T $BD/AOSPExtended_a64-ab-12.1-ItzKaguyaGSI-UNOFFICIAL.img.xz | tee download-link.txt
sleep 10
curl bashupload.com -T $BD/AOSPExtended_a64-ab-vndklite-12.1-ItzKaguyaGSI-UNOFFICIAL.img.xz | tee download-link-vndklite.txt
sleep 10
tg_sendFile "download-link.txt"
tg_sendFile "download-link-vndklite.txt"

BUILD_END=$(date +"%s");
DIFF=$(($BUILD_END - $BUILD_START));


tg_sendText "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
