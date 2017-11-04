package gltf.schema;

/**
 *  Targets an animation's sampler at a node's property.
 */
typedef TAnimationChannel = {
    >TGLTFProperty,

    /**
     *  The index of a sampler in this animation used to compute the value for the target, e.g., a node's translation, rotation, or scale (TRS).
     */
    var sampler:TGLTFID;

    /**
     *  The index of the node and TRS property to target.
     */
    var target:TAnimationChannelTarget;
}
