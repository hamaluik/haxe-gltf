import buddy.*;
using buddy.Should;

import gltf.Mesh.MeshPrimitive;
import gltf.Mesh.PrimitiveType;
import haxe.ds.StringMap;
import gltf.GLTF;

class TestMeshes extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading meshes", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("should load the primitives as an array", {
				box.meshes.get('Geometry-mesh002').primitives.length.should.be(1);
			});

			it('should load primitives', {
				var p:MeshPrimitive = box.meshes.get('Geometry-mesh002').primitives[0];
				p.indices.should.be('accessor_21');
				p.material.should.be('Effect-Red');
				p.mode.should.be(PrimitiveType.TRIANGLES);

				p.attributes.get('NORMAL').should.be('accessor_25');
				p.attributes.get('POSITION').should.be('accessor_23');
			});
		});
	}
}