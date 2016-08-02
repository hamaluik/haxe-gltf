import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestShaders extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading shaders", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}