package gltf.schema;

/**
 *  The index of the node and TRS property that an animation channel targets.
 */
typedef TAnimationChannelTarget = {
    >TGLTFProperty,

    /**
     *  The index of the node to target.
     */
    @:optional var node:TGLTFID;

    /**
     *  The name of the node's TRS property to modify, or the "weights" of the Morph Targets it instantiates.
     */
    var path:TAnimationChannelTargetPath;
}
