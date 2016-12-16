import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestScenes extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading scenes", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("should list all the root nodes", {
				box.scenes.get('defaultScene').nodes.length.should.be(1);
				box.scenes.get('defaultScene').nodes[0].should.be('node_1');
			});
		});
	}
}