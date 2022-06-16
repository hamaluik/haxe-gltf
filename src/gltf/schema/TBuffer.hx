package gltf.schema;

/**
 *  A buffer points to binary geometry, animation, or skins.
 */
typedef TBuffer = {
    >TGLTFChildOfRootProperty,
    >TGLTFProperty,
    >TGLTFUri,

    /**
     *  The length of the buffer in bytes.
     */
    var byteLength:Int;
}
