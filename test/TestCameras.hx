import buddy.*;
using buddy.Should;

import gltf.Camera.CameraType;
import gltf.Camera.PerspectiveCamera;
import haxe.ds.StringMap;
import gltf.GLTF;

class TestCameras extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading cameras", {
			var duck:GLTF = GLTF.parse(sources.get("duck"));
			it("it should load the camera name", {
				duck.cameras.get("cameraShape1").name.should.be("cameraShape1");
			});
			it("should reference the camera type", {
				duck.cameras.get("cameraShape1").type.should.be(CameraType.Perspective);
			});
			it("should load the camera data", {
				var c:PerspectiveCamera = duck.cameras.get("cameraShape1").perspective;
				c.aspectRatio.should.beCloseTo(1.5);
				c.yfov.should.beCloseTo(0.660593);
				c.znear.should.beCloseTo(0.01);
				c.zfar.should.beCloseTo(100);
			});
		});
	}
}