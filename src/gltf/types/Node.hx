package gltf.types;

import gltf.schema.TGLTF;
import gltf.schema.TNode;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Node {
    public var id(default, null):Int = -1;
    public var name(default, null):Null<String> = null;
    public var camera(default, null):Null<Camera> = null;
    public var children(default, null):Vector<Node> = new Vector<Node>(0);
    public var skin(default, null):Null<Skin> = null;
    public var matrix(default, null):Null<Vector<Float>> = null;
    public var mesh(default, null):Null<Mesh> = null;
    public var rotation(default, null):Null<Vector<Float>> = null;
    public var scale(default, null):Null<Vector<Float>> = null;
    public var translation(default, null):Null<Vector<Float>> = null;
    public var weights(default, null):Null<Vector<Float>> = null;

    function new() {}

    function load(gltf:GLTF, node:TNode, existingNodes:Vector<Node>):Void {
        name = node.name;
        if(node.camera != null) camera = gltf.cameras[node.camera];
        if(node.children != null) {
            children = new Vector<Node>(node.children.length);
            for(i in 0...node.children.length) {
                children[i] = existingNodes[node.children[i]];
            }
        }
        if(node.skin != null) skin = gltf.skins[node.skin];
        if(node.matrix != null) matrix = Vector.fromArrayCopy(node.matrix);
        if(node.mesh != null) mesh = gltf.meshes[node.mesh];
        if(node.rotation != null) rotation = Vector.fromArrayCopy(node.rotation);
        if(node.scale != null) scale = Vector.fromArrayCopy(node.scale);
        if(node.translation != null) translation = Vector.fromArrayCopy(node.translation);
        if(node.weights != null) weights = Vector.fromArrayCopy(node.weights);
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Node> {
        var existingNodes:Vector<Node> = new Vector<Node>(raw.nodes.length);
        for(i in 0...raw.nodes.length) {
            existingNodes[i] = new Node();
            existingNodes[i].id = i;
        }
        for(i in 0...raw.nodes.length) {
            existingNodes[i].load(gltf, raw.nodes[i], existingNodes);
        }
        return existingNodes;
    }
}
