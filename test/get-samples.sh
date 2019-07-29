#!/bin/sh
rm -rf samples
mkdir samples
curl -L -o samples/Box.gltf https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Box/glTF/Box.gltf
curl -L -o samples/Box0.bin https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF/Box0.bin
curl -L -o samples/BoxTextured.gltf https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/BoxTextured/glTF/BoxTextured.gltf
curl -L -o samples/BoxTextured0.bin https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/BoxTextured/glTF/BoxTextured0.bin
curl -L -o samples/CesiumLogoFlat.png https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/BoxTextured/glTF/CesiumLogoFlat.png
curl -L -o samples/RiggedSimple.gltf https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/RiggedSimple/glTF/RiggedSimple.gltf
curl -L -o samples/RiggedSimple0.bin https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/RiggedSimple/glTF/RiggedSimple0.bin
