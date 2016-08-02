import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;
import gltf.Material;

class TestMaterials extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading materials", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("should load material names", {
				box.materials.get("Effect-Red").name.should.be("Red");
			});
			it("should load values", {
				var diffuse:Array<Float> = box.materials.get("Effect-Red").values.get("diffuse");
				var expected:Array<Float> = [0.8, 0, 0, 1];
				for(i in 0...4) {
					expected[i].should.beCloseTo(diffuse[i]);
				}
			});
			it("shouldn't populate un-listed values", {
				box.materials.get("Effect-Red").values.get("redness").should.be(null);
			});
		});
	}
}