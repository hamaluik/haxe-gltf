package gltf.schema;

/**
 *  An orthographic camera containing properties to create an orthographic projection matrix.
 */
typedef TCameraOrthographic = {
    >TGLTFProperty,

    /**
     *  The floating-point horizontal magnification of the view. Must not be zero.
     */
    var xmag:Float;

    /**
     *  The floating-point vertical magnification of the view. Must not be zero.
     */
    var ymag:Float;

    /**
     *  The floating-point distance to the far clipping plane. `zfar` must be greater than `znear`.
     */
    var zfar:Float;

    /**
     *  The floating-point distance to the near clipping plane.
     */
    var znear:Float;
}
