import buddy.*;
using buddy.Should;

import gltf.Accessor;
import gltf.type.AccessorType;
import gltf.type.DataType;
import haxe.ds.StringMap;
import gltf.GLTF;

class TestAccessors extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading accessors", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			var accessor:Accessor = box.accessors.get("accessor_21");

			it("should reference a buffer view", {
				var bufferViewID:String = accessor.bufferView;
				bufferViewID.should.be("bufferView_29");
				box.bufferViews.get(bufferViewID).should.not.be(null);
			});

			it("should specify a byte offset", {
				accessor.byteOffset.should.be(0);
				box.accessors.get("accessor_25").byteOffset.should.be(288);
			});

			it("should specify a byte stride", {
				accessor.byteStride.should.be(0);
			});

			it("should reference a data type", {
				accessor.componentType.should.be(DataType.UNSIGNED_SHORT);
			});

			it("should specify a count", {
				accessor.count.should.be(36);
			});

			it("should reference an accessor type", {
				accessor.type.should.be(AccessorType.SCALAR);
			});
		});
	}
}