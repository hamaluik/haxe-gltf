import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestAnimations extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading animations", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}