#!/bin/bash

set -e

IOSSDK_VER="7.0"

# xcodebuild -showsdks
PROJECT_NAME="SVGKit-iOS"
TARGET_NAME=${PROJECT_NAME}
xcodebuild -project ${PROJECT_NAME}.xcodeproj -target ${TARGET_NAME} -configuration Release -sdk iphoneos${IOSSDK_VER} build
xcodebuild -project ${PROJECT_NAME}.xcodeproj -target ${TARGET_NAME} -configuration Release -sdk iphonesimulator${IOSSDK_VER} build

cd Build

LIBNAME="libSVGKit-iOS"
# for the fat lib file
mkdir -p Release-iphone/lib
xcrun -sdk iphoneos lipo -create Release-iphoneos/${LIBNAME}.a Release-iphonesimulator/${LIBNAME}.a -output Release-iphone/lib/${LIBNAME}.a
xcrun -sdk iphoneos lipo -info Release-iphone/lib/${LIBNAME}.a
# for header files
mkdir -p Release-iphone/include
cp Release-iphoneos/include/${TARGET_NAME}/*.h Release-iphone/include
