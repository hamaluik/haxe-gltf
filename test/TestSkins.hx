import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestSkins extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading skins", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}