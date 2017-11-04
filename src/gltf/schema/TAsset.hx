package gltf.schema;

/**
 *  Metadata about the glTF asset
 */
typedef TAsset = {
    >TGLTFProperty,

    /**
     *  A copyright message suitable for display to credit the content creator.
     */
    @:optional var copyright:String;

    /**
     *  Tool that generated this glTF model. Useful for debugging.
     */
    @:optional var generator:String;

    /**
     *  The minimum glTF version that this asset targets.
     */
    var version:String;

    /**
     *  The minimum glTF version that this asset targets.
     */
    @:optional var minVersion:String;
}
