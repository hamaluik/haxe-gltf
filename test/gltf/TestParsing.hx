package gltf;

import buddy.*;
using buddy.Should;

using gltf.GLTF;

class TestParsing extends BuddySuite {
	public function new() {
		describe('Parsing GLTF', {
			var boxSrc:String = haxe.Http.requestUrl('https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Box/glTF/Box.gltf');

			it("should parse gltf files", {
				var gltf:GLTF = GLTF.parse(boxSrc);

				gltf.raw.asset.generator.should.be("COLLADA2GLTF");
				gltf.raw.asset.version.should.be("2.0");

				gltf.raw.scene.should.be(0);
			});

			it("should parse glb files");
		});
	}
}