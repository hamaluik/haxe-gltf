import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestTextures extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading textures", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}