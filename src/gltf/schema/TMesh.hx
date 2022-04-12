package gltf.schema;

/**
 *  A set of primitives to be rendered.  A node can contain one mesh.  A node's transform places the mesh in the scene.
 */
typedef TMesh = {
    >TGLTFChildOfRootProperty,
    >TGLTFProperty,

    /**
     *  An array of primitives, each defining geometry to be rendered with a material.
     */
    var primitives:Array<TMeshPrimitive>;

    /**
     *  Array of weights to be applied to the Morph Targets.
     */
    @:optional var weights:Array<Float>;
}
