package gltf.schema;

/**
 *  The material's alpha rendering mode enumeration specifying the interpretation of the alpha value of the main factor and texture.
 */
@:enum abstract TAlphaMode(String) {
    /**
     *  The alpha value is ignored and the rendered output is fully opaque.
     */
    var OPAQUE = "OPAQUE";

    /**
     *  The rendered output is either fully opaque or fully transparent depending on the alpha value and the specified alpha cutoff value.
     */
    var MASK = "MASK";

    /**
     *  The alpha value is used to composite the source and destination areas. The rendered output is combined with the background using the normal painting operation (i.e. the Porter and Duff over operator).
     */
    var BLEND = "BLEND";
}
