package gltf.schema;

/**
 *  Specifies if the camera uses a perspective or orthographic projection.  Based on this, either the camera's `perspective` or `orthographic` property will be defined.
 */
@:enum abstract TCameraType(String) {
    var PERSPECTIVE = "perspective";
    var ORTHOGRAPHIC = "orthographic";
}
