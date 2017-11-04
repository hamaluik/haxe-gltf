package gltf.schema;

/**
 *  s-t wrapping mode.  All valid values correspond to WebGL enums.
 */
@:enum abstract TWrapMode(Int) {
    var CLAMP_TO_EDGE = 33071;
    var MIRROR_REPEAT = 33648;
    var REPEAT = 10497;
}
