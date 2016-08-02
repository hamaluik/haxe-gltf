import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestAsset extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading asset", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("should load the generator", {
				box.asset.generator.should.be("collada2gltf@027f74366341d569dea42e9a68b7104cc3892054");
			});

			it("should load the version", {
				box.asset.version.should.be("1.0");
			});

			it("should load the target rendering API", {
				box.asset.profile.api.should.be("WebGL");
				box.asset.profile.version.should.be("1.0.2");
			});

			it("should load premultiplied alpha", {
				box.asset.premultipliedAlpha.should.be(true);
			});
		});
	}
}