#!/usr/bin/env sh

if [ ! -d _build ]
then
    echo "NOT"
    mkdir _build
fi
cd _build
cmake ..
make -j2
install_name_tool -change "@executable_path/Chromium Embedded Framework" "@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework" engage
install_name_tool -change "@executable_path/Chromium Embedded Framework" "@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework" "engage Helper"

cd ..

rm -rf Engage.app
mkdir -p Engage.app/Contents/{Frameworks,MacOS,Resources}
cp -r ../../Frameworks/Chromium\ Embedded\ Framework.framework Engage.app/Contents/Frameworks
cp -r ../../Frameworks/libplugin_carbon_interpose.dylib Engage.app/Contents/Frameworks

cp mac/PkgInfo mac/Info.plist Engage.app/Contents
cp -r mac/engage.icns mac/English.lproj Engage.app/Contents/Resources

cp _build/engage Engage.app/Contents/MacOS

mkdir -p Engage.app/Contents/Frameworks/engage\ Helper.app/Contents/MacOS
cp mac/helper/* Engage.app/Contents/Frameworks/engage\ Helper.app/Contents/
cp _build/engage\ Helper Engage.app/Contents/Frameworks/engage\ Helper.app/Contents/MacOS

mac/make_more_helpers.sh Engage.app/Contents/Frameworks engage
