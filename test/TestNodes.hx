import buddy.*;
using buddy.Should;

import gltf.Node;
import haxe.ds.StringMap;
import gltf.GLTF;

class TestNodes extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading nodes", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			var node:Node = box.nodes.get('node_1');

			it("should reference children", {
				node.children.length.should.be(1);
				node.children[0].should.be('Geometry-mesh002Node');
				box.nodes.get(node.children[0]).should.not.be(null);
			});

			it("should be able to reference a transformation matrix", {
				node.matrix.length.should.be(16);
			});
		});
	}
}