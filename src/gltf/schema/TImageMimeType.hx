package gltf.schema;

/**
 *  The image's MIME type.
 */
@:enum abstract TImageMimeType(String) {
    var JPEG = "image/jpeg";
    var PNG = "image/png";
}
