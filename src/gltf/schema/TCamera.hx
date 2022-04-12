package gltf.schema;

/**
 *  A camera's projection.  A node can reference a camera to apply a transform to place the camera in the scene.
 */
typedef TCamera = {
    >TGLTFChildOfRootProperty,
    >TGLTFProperty,

    /**
     *  An orthographic camera containing properties to create an orthographic projection matrix.
     */
    @:optional var orthographic:TCameraOrthographic;

    /**
     *  A perspective camera containing properties to create a perspective projection matrix.
     */
    @:optional var perspective:TCameraPerspective;

    /**
     *  Specifies if the camera uses a perspective or orthographic projection.  Based on this, either the camera's `perspective` or `orthographic` property will be defined.
     */
    var type:TCameraType;
}
