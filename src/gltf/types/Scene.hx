package gltf.types;

import gltf.schema.TGLTF;
import gltf.schema.TScene;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Scene {
    public var name(default, null):Null<String> = null;
    public var nodes(default, null):Vector<Node> = new Vector<Node>(0);

    function new() {}

    function load(gltf:GLTF, scene:TScene):Void {
        name = scene.name;
        nodes = new Vector<Node>(scene.nodes.length);
        for(i in 0...scene.nodes.length) {
            nodes[i] = gltf.nodes[scene.nodes[i]];
        }
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Scene> {
        var scenes:Vector<Scene> = new Vector<Scene>(raw.scenes.length);
        for(i in 0...raw.scenes.length) {
            scenes[i] = new Scene();
        }
        for(i in 0...raw.scenes.length) {
            scenes[i].load(gltf, raw.scenes[i]);
        }
        return scenes;
    }
}
