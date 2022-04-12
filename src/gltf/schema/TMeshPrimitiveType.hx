package gltf.schema;

/**
 *  The type of primitives to render. All valid values correspond to WebGL enums.
 */
@:enum abstract TMeshPrimitiveType(Int) from Int to Int {
    var POINTS = 0;
    var LINES = 1;
    var LINE_LOOP = 2;
    var LINE_STRIP = 3;
    var TRIANGLES = 4;
    var TRIANGLE_STRIP = 5;
    var TRIANGLE_FAN = 6;
}
