#!/bin/bash
function ionic-start {
    ionic start $1 tabs --type=ionic-angular --cordova --no-interactive
}

function ion-sign {
    platform=$ANDROID_HOME/build-tools/$PLATFORM_ENV
    cordova build android --release -- --packageType=apk
    UNSIGNED_APK=platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk
    ${platform}zipalign -v 4 $UNSIGNED_APK app-temp-signed.apk
    ${platform}apksigner sign --verbose \
        --v1-signing-enable=true \
        --v2-signing-enable=true \
        --v3-signing-enable=false \
        --ks-pass pass:${PASS_ENV} \
        --key-pass pass:${PASS_ENV} \
        --out app.apk \
        app-temp-signed.apk


}
