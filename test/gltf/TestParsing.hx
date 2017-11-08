package gltf;

import gltf.schema.TGLTF;
import buddy.*;
using buddy.Should;

class TestParsing extends BuddySuite {
	public function new() {
		describe('Parsing GLTF', {
			var boxSrc:String = sys.io.File.getContent('samples/Box.gltf');

			it("should parse gltf files", {
				var raw:TGLTF = GLTF.parse(boxSrc);

				raw.asset.generator.should.be("COLLADA2GLTF");
				raw.asset.version.should.be("2.0");

				raw.scene.should.be(0);
				raw.scenes.length.should.be(1);
				raw.scenes[0].nodes.length.should.be(1);
				raw.scenes[0].nodes[0].should.be(0);

				raw.nodes.length.should.be(2);
				raw.nodes[0].children.length.should.be(1);
				raw.nodes[1].children.should.be(null);
			});

			it("should parse glb files");
		});
	}
}
