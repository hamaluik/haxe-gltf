package gltf.schema;

/**
 *  Combines input and output accessors with an interpolation algorithm to define a keyframe graph (but not its target).
 */
typedef TAnimationSampler = {
    >TGLTFProperty,

    /**
     *  The index of an accessor containing keyframe input values, e.g., time. That accessor must have componentType `FLOAT`. The values represent time in seconds with `time[0] >= 0.0`, and strictly increasing values, i.e., `time[n + 1] > time[n]`.
     */
    var input:TGLTFID;

    /**
     *  Interpolation algorithm.
     */
    @:optional var interpolation:TAnimationInterpolation;

    /**
     *  The index of an accessor containing keyframe output values. When targeting TRS target, the `accessor.componentType` of the output values must be `FLOAT`. When targeting morph weights, the `accessor.componentType` of the output values must be `FLOAT` or normalized integer where each output element stores values with a count equal to the number of morph targets.
     */
    var output:TGLTFID;
}
