#!/bin/sh
rm -rf samples
mkdir samples
curl -o samples/Box.gltf https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Box/glTF/Box.gltf
curl -o samples/Box0.bin https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF/Box0.bin