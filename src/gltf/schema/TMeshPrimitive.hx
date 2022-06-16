package gltf.schema;

/**
 *  Geometry to be rendered with the given material.
 */
typedef TMeshPrimitive = {
    >TGLTFProperty,

    /**
     *  A dictionary object, where each key corresponds to mesh attribute semantic and each value is the index of the accessor containing attribute's data.
     */
    var attributes:Dynamic;

    /**
     *  The index of the accessor that contains mesh indices.  When this is not defined, the primitives should be rendered without indices using `drawArrays()`.  When defined, the accessor must contain indices: the `bufferView` referenced by the accessor should have a `target` equal to 34963 (ELEMENT_ARRAY_BUFFER); `componentType` must be 5121 (UNSIGNED_BYTE), 5123 (UNSIGNED_SHORT) or 5125 (UNSIGNED_INT), the latter may require enabling additional hardware support; `type` must be `\"SCALAR\"`. For triangle primitives, the front face has a counter-clockwise (CCW) winding order.
     */
    @:optional var indices:TGLTFID;

    /**
     *  The index of the material to apply to this primitive when rendering.
     */
    @:optional var material:TGLTFID;

    /**
     *  The type of primitives to render. All valid values correspond to WebGL enums.
     */
    @:optional var mode:TMeshPrimitiveType;

    /**
     *  An array of Morph Targets, each  Morph Target is a dictionary mapping attributes (only `POSITION`, `NORMAL`, and `TANGENT` supported) to their deviations in the Morph Target.
     *  
     *  Each item is a dictionary object specifying attributes displacements in a Morph Target, where each key corresponds to one of the three supported attribute semantic (`POSITION`, `NORMAL`, or `TANGENT`) and each value is the index of the accessor containing the attribute displacements' data.
     */
    @:optional var targets:Array<Dynamic>;
}
