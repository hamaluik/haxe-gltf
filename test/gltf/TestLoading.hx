package gltf;

import gltf.schema.TGLTF;
import buddy.*;
using buddy.Should;

class TestLoading extends BuddySuite {
	public function new() {
		describe('Loading GLTFs', {
			var boxSrc:String = sys.io.File.getContent('samples/Box.gltf');
			var raw:TGLTF = GLTF.parse(boxSrc);
			var gltf:GLTF = GLTF.load(raw);

			it("should load an array of cameras");
			
			it("should load an array of meshes");

			it("should load an array of skins");

			it("should load an array of nodes", {
				gltf.nodes.length.should.be(2);
				gltf.nodes[0].children.length.should.not.be(null);
				gltf.nodes[0].children.length.should.be(1);
				gltf.nodes[0].matrix.should.not.be(null);
				gltf.nodes[1].mesh.should.not.be(null);
			});

			it("should load an array of scenes and set the default scene", {
				gltf.scenes.length.should.be(1);
				gltf.scenes[0].nodes.length.should.be(1);
				gltf.scenes[0].nodes[0].should.be(gltf.nodes[0]);
				gltf.defaultScene.should.be(gltf.scenes[0]);
			});
		});
	}
}
