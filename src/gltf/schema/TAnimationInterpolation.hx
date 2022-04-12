package gltf.schema;

/**
 *  Interpolation algorithm.
 */
@:enum abstract TAnimationInterpolation(String) from String to String {
    /**
     *  The animated values are linearly interpolated between keyframes. When targeting a rotation, spherical linear interpolation (slerp) should be used to interpolate quaternions. The number output of elements must equal the number of input elements.
     */
    var LINEAR = "LINEAR";

    /**
     *  The animated values remain constant to the output of the first keyframe, until the next keyframe. The number of output elements must equal the number of input elements.
     */
    var STEP = "STEP";

    /**
     *  The animation's interpolation is computed using a uniform Catmull-Rom spline. The number of output elements must equal two more than the number of input elements. The first and last output elements represent the start and end tangents of the spline. There must be at least four keyframes when using this interpolation.
     */
    var CATMULLROMSPLINE = "CATMULLROMSPLINE";

    /**
     *  The animation's interpolation is computed using a cubic spline with specified tangents. The number of output elements must equal three times the number of input elements. For each input element, the output stores three elements, an in-tangent, a spline vertex, and an out-tangent. There must be at least two keyframes when using this interpolation.
     */
    var CUBICSPLINE = "CUBICSPLINE";
}
