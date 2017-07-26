#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OUTPUT="${DIR}/www"
rm -rf $OUTPUT && mkdir -p $OUTPUT
cd ../guiteo-ui
echo "Build in $OUTPUT"
ng build --environment prod --prod --no-sourcemap --output-path $OUTPUT --base-href '.'
cd $OUTPUT
cordova build --release

echo "Signing ./platforms/android/build/outputs/apk/android-release-unsigned.apk"
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /Users/ppoissinger/keystores/android-apps.keystore ${DIR}/platforms/android/build/outputs/apk/android-release-unsigned.apk  androidmobileapps
mv ${DIR}/platforms/android/build/outputs/apk/android-release-unsigned.apk ${DIR}/output/chordr.apk
