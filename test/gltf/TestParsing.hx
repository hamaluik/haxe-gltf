package gltf;

import buddy.*;
using buddy.Should;

import gltf.Schema;

class TestParsing extends BuddySuite {
	public function new() {
		describe('Parsing GLTF', {
			var boxSrc:String = sys.io.File.getContent('samples/Box.gltf');

			it("should parse gltf files", {
				var raw:TGLTF = GLTF.parse(boxSrc);

				raw.asset.generator.should.be("COLLADA2GLTF");
				raw.asset.version.should.be("2.0");

				raw.scene.should.be(0);
			});

			it("should parse glb files");
		});
	}
}