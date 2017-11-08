package gltf.types;

import gltf.GLTF;
import gltf.types.Accessor;
import gltf.schema.TMeshPrimitive;
import haxe.ds.Vector;

typedef TAttribute = {
    var name:String;
    var accessor:Accessor;
}

@:allow(gltf.types.Mesh)
class MeshPrimitive {
    public var attributes(default, null):Vector<TAttribute> = new Vector<TAttribute>(0);
    public var indices(default, null):Null<Accessor> = null;
    // TODO: material
    // TODO: mode
    // TODO: morph targets

    function new() {}

    function load(gltf:GLTF, primitive:TMeshPrimitive):Void {
        // load the attributes
        var names:Array<String> = Reflect.fields(primitive.attributes);
        attributes = new Vector<TAttribute>(names.length);
        for(i in 0...names.length) {
            var aid:Int = Reflect.field(primitive.attributes, names[i]);
            attributes[i] = {
                name: names[i],
                accessor: gltf.accessors[aid]
            };
        }

        if(primitive.indices != null) indices = gltf.accessors[primitive.indices];
    }

    public function getFloatAttributeValues(attribute:String):Vector<Float> {
        var accessor:Accessor = null;
        for(a in attributes) {
            if(a.name == attribute) {
                accessor = a.accessor;
                break;
            }
        }
        if(accessor == null) {
            throw 'This mesh primitive doesn\'t contain the \'${attribute}\' attribute!';
        }

        return accessor.getFloats();
    }

    public function getIndexValues():Vector<Int> {
        if(indices == null) {
            throw 'This mesh primitive doesn\'t have indices!';
        }
        return indices.getInts();
    }
}
