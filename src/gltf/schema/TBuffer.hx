package gltf.schema;

/**
 *  A buffer points to binary geometry, animation, or skins.
 */
typedef TBuffer = {
    >TGLTFChildOfRootProperty,

    /**
     *  The uri of the buffer.  Relative paths are relative to the .gltf file.  Instead of referencing an external file, the uri can also be a data-uri.
     */
    @:optional var uri:String;

    /**
     *  The length of the buffer in bytes.
     */
    var byteLength:Int;
}
