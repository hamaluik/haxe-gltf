package gltf;

import gltf.Schema.TGLTF;
import gltf.Schema.TScene;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Scene {
    var nodes(default, null):Vector<Node> = new Vector<Node>(0);

    function new() {}

    function load(gltf:GLTF, scene:TScene, existingScenes:Vector<Scene>):Void {
        nodes = new Vector<Node>(scene.nodes.length);
        for(i in 0...scene.nodes.length) {
            nodes[i] = gltf.nodes[scene.nodes[i]];
        }
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Scene> {
        var existingScenes:Vector<Scene> = new Vector<Scene>(raw.scenes.length);
        for(i in 0...raw.scenes.length) {
            existingScenes[i] = new Scene();
        }
        for(i in 0...raw.scenes.length) {
            existingScenes[i].load(gltf, raw.scenes[i], existingScenes);
        }
        return existingScenes;
    }
}