import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestScenes extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading scenes", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}