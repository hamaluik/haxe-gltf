import buddy.*;
using buddy.Should;

import gltf.Skin;
import haxe.ds.StringMap;
import gltf.GLTF;

class TestSkins extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading skins", {
			var rigged:GLTF = GLTF.parse(sources.get("rigged"));
			var skin:Skin = rigged.skins.get('Armature_Cylinder-skin');

			it("should define a bind shape matrix", {
				skin.bindShapeMatrix.length.should.be(16);
			});

			it("should reference inverse bind matrices", {
				skin.inverseBindMatrices.should.be('IBM_Armature_Cylinder-skin');
			});

			it('should list all the joint names', {
				skin.jointNames.length.should.be(2);
				skin.jointNames[0].should.be('Bone');
				skin.jointNames[1].should.be('Bone_001');
			});
		});
	}
}