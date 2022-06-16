package gltf.schema;

/**
 *  The name of the node's TRS property to modify, or the \"weights\" of the Morph Targets it instantiates.
 */
@:enum abstract TAnimationChannelTargetPath(String) from String to String {
    var TRANSLATION = "translation";
    var ROTATION = "rotation";
    var SCALE = "scale";
    var WEIGHTS = "weights";
}
