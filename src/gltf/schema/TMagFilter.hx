package gltf.schema;

/**
 *  Magnification filter.  Valid values correspond to WebGL enums: `9728` (NEAREST) and `9729` (LINEAR).
 */
@:enum abstract TMagFilter(Int) from Int to Int {
    var NEAREST = 9728;
    var LINEAR = 9729;
}
