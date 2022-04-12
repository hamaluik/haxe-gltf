package gltf.schema;

/**
 *  The datatype of components in the attribute.  All valid values correspond to WebGL enums.  The corresponding typed arrays are `Int8Array`, `Uint8Array`, `Int16Array`, `Uint16Array`, `Uint32Array`, and `Float32Array`, respectively.  5125 (UNSIGNED_INT) is only allowed when the accessor contains indices, i.e., the accessor is only referenced by `primitive.indices`.
 */
@:enum abstract TComponentType(Int) from Int to Int {
    var BYTE = 5120;
    var UNSIGNED_BYTE = 5121;
    var SHORT = 5122;
    var UNSIGNED_SHORT = 5123;
    var UNSIGNED_INT = 5125;
    var FLOAT = 5126;
}
