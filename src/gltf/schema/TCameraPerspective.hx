package gltf.schema;

/**
 *  A perspective camera containing properties to create a perspective projection matrix.
 */
typedef TCameraPerspective = {
    >TGLTFProperty,

    /**
     *  The floating-point aspect ratio of the field of view. When this is undefined, the aspect ratio of the canvas is used.
     */
    @:optional var aspectRatio:Float;

    /**
     *  The floating-point vertical field of view in radians.
     */
    var yfov:Float;

    /**
     *  The floating-point distance to the far clipping plane. When defined, `zfar` must be greater than `znear`. If `zfar` is undefined, runtime must use infinite projection matrix.
     */
    @:optional var zfar:Float;

    /**
     *  The floating-point distance to the near clipping plane.
     */
    var znear:Float;
}
