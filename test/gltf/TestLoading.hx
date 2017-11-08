package gltf;

import gltf.schema.TGLTF;
import buddy.*;
using buddy.Should;
import haxe.io.Bytes;
import haxe.ds.Vector;

class TestLoading extends BuddySuite {
	public function new() {
		describe('Loading GLTFs', {
			var boxSrc:String = sys.io.File.getContent('samples/Box.gltf');
            var boxBin:Bytes = sys.io.File.getBytes('samples/Box0.bin');
			var raw:TGLTF = GLTF.parse(boxSrc);
            var buffers:Vector<Bytes> = new Vector<Bytes>(1);
            buffers[0] = boxBin;
			var object:GLTF = GLTF.load(raw, buffers);

            it("should load an array of buffers", {
                object.buffers.length.should.be(1);
                object.buffers[0].uri.should.be("Box0.bin");
                object.buffers[0].data.should.be(boxBin);
            });

            it("should load an array of buffer views", {
                object.bufferViews.length.should.be(2);
                object.bufferViews[0].buffer.should.be(object.buffers[0]);
                object.bufferViews[0].byteLength.should.be(72);
            });

            it("should load an array of accessors", {
                object.accessors.length.should.be(3);

                object.accessors[0].componentType.should.be(gltf.schema.TComponentType.UNSIGNED_SHORT);
                object.accessors[0].type.should.be(gltf.schema.TAttributeType.SCALAR);

                object.accessors[1].componentType.should.be(gltf.schema.TComponentType.FLOAT);
                object.accessors[1].type.should.be(gltf.schema.TAttributeType.VEC3);

                object.accessors[2].componentType.should.be(gltf.schema.TComponentType.FLOAT);
                object.accessors[2].type.should.be(gltf.schema.TAttributeType.VEC3);
            });

			it("should load an array of cameras", {
                // TODO: better model test for cameras
                object.cameras.length.should.be(0);
            });
			
			it("should load an array of meshes", {
                object.meshes.length.should.be(1);
                object.meshes[0].primitives.length.should.be(1);
                object.meshes[0].primitives[0].attributes.length.should.be(2);
                object.meshes[0].primitives[0].indices.should.not.be(null);
                
                var foundPosition:Bool = false;
                var foundNormal:Bool = false;
                for(a in object.meshes[0].primitives[0].attributes) {
                    if(a.name == "POSITION") foundPosition = true;
                    else if(a.name == "NORMAL") foundNormal = true;
                }
                foundPosition.should.be(true);
                foundNormal.should.be(true);
                
                trace('indices: ' + object.meshes[0].primitives[0].getIndexValues());
                trace('positions: ' + object.meshes[0].primitives[0].getFloatAttributeValues("POSITION"));
                trace('normals: ' + object.meshes[0].primitives[0].getFloatAttributeValues("NORMAL"));
            });

			it("should load an array of skins");

			it("should load an array of nodes", {
				object.nodes.length.should.be(2);
				object.nodes[0].children.length.should.be(1);
				object.nodes[0].matrix.should.not.be(null);
				object.nodes[1].mesh.should.not.be(null);
			});

			it("should load an array of scenes and set the default scene", {
				object.scenes.length.should.be(1);
				object.scenes[0].nodes.length.should.be(1);
				object.scenes[0].nodes[0].should.be(object.nodes[0]);
				object.defaultScene.should.be(object.scenes[0]);
			});
		});
	}
}
