package gltf.schema;

/**
 *  Reference to a texture.
 */
typedef TTextureInfo = {
    >TGLTFProperty,

    /**
     *  The index of the texture.
     */
    var index:TGLTFID;

    /**
     *  This integer value is used to construct a string in the format TEXCOORD_<set index> which is a reference to a key in mesh.primitives.attributes (e.g. A value of 0 corresponds to TEXCOORD_0).
     */
    @:optional var texCoord:Int;
}
