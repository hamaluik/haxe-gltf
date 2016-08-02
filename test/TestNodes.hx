import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestNodes extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading nodes", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}