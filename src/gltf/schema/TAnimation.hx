package gltf.schema;

/**
 *  A keyframe animation.
 */
typedef TAnimation = {
    >TGLTFChildOfRootProperty,
    >TGLTFProperty,

    /**
     *  An array of channels, each of which targets an animation's sampler at a node's property. Different channels of the same animation can't have equal targets.
     */
    var channels:Array<TAnimationChannel>;

    /**
     *  An array of samplers that combines input and output accessors with an interpolation algorithm to define a keyframe graph (but not its target).
     */
    var samplers:Array<TAnimationSampler>;
}
