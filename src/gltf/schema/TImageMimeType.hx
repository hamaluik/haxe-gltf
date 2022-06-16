package gltf.schema;

/**
 *  The image's MIME type.
 */
@:enum abstract TImageMimeType(String) from String to String {
    var JPEG = "image/jpeg";
    var PNG = "image/png";
}
