package gltf;

import gltf.Schema.TGLTF;
import gltf.Schema.TNode;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Node {
    //var camera(default, null):Null<TCamera> = null;
    var children(default, null):Vector<Node> = new Vector<Node>(0);
    //var skin(default, null):Null<TGLTFID> = null;
    var matrix(default, null):Null<Vector<Float>> = null;
    //var mesh(default, null):Null<TGLTFID> = null;
    var rotation(default, null):Null<Vector<Float>> = null;
    var scale(default, null):Null<Vector<Float>> = null;
    var translation(default, null):Null<Vector<Float>> = null;
    var weights(default, null):Null<Array<Float>> = null;

    function new() {}

    function load(gltf:GLTF, node:TNode, existingNodes:Vector<Node>):Void {
        // TODO: camera
        if(node.children != null) {
            children = new Vector<Node>(node.children.length);
            for(i in 0...node.children.length) {
                children[i] = existingNodes[node.children[i]];
            }
        }
        // TODO: skin
        if(node.matrix != null) matrix = Vector.fromArrayCopy(node.matrix);
        // TODO: mesh
        if(node.rotation != null) rotation = Vector.fromArrayCopy(node.rotation);
        if(node.scale != null) scale = Vector.fromArrayCopy(node.scale);
        if(node.translation != null) translation = Vector.fromArrayCopy(node.translation);
        if(node.weights != null) weights = node.weights;
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Node> {
        var existingNodes:Vector<Node> = new Vector<Node>(raw.nodes.length);
        for(i in 0...raw.nodes.length) {
            existingNodes[i] = new Node();
        }
        for(i in 0...raw.nodes.length) {
            existingNodes[i].load(gltf, raw.nodes[i], existingNodes);
        }
        return existingNodes;
    }
}