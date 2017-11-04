package gltf.schema;

typedef TGLTFChildOfRootProperty = {
    /**
     *  The user-defined name of this object.  This is not necessarily unique, e.g., an accessor and a buffer could have the same name, or two accessors could even have the same name.
     */
    @:optional var name:String;
}
