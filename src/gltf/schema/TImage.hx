package gltf.schema;

/**
 *  Image data used to create a texture. Image can be referenced by URI or `bufferView` index. `mimeType` is required in the latter case.
 */
typedef TImage = {
    >TGLTFChildOfRootProperty,

    /**
     *  The uri of the image.  Relative paths are relative to the .gltf file.  Instead of referencing an external file, the uri can also be a data-uri.  The image format must be jpg or png.
     */
    @:optional var uri:String;

    /**
     *  The image's MIME type.
     */
    var mimeType:TImageMimeType;

    /**
     *  The index of the bufferView that contains the image. Use this instead of the image's uri property.
     */
    @:optional var bufferView:TGLTFID;
}
