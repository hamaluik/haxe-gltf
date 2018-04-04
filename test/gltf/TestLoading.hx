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
            var boxRaw:TGLTF = GLTF.parse(boxSrc);
            var boxObject:GLTF = GLTF.load(boxRaw, [boxBin]);

            var boxTexturedSrc:String = sys.io.File.getContent('samples/BoxTextured.gltf');
            var boxTexturedBin:Bytes = sys.io.File.getBytes('samples/BoxTextured0.bin');
            var boxTexturedRaw:TGLTF = GLTF.parse(boxTexturedSrc);
            var boxTexturedObject:GLTF = GLTF.load(boxTexturedRaw, [boxTexturedBin]);

            var riggedSimpleSrc:String = sys.io.File.getContent('samples/RiggedSimple.gltf');
            var riggedSimpleBin:Bytes = sys.io.File.getBytes('samples/RiggedSimple0.bin');
            var riggedSimpleRaw:TGLTF = GLTF.parse(riggedSimpleSrc);
            var riggedSimpleObject:GLTF = GLTF.load(riggedSimpleRaw, [riggedSimpleBin]);

            it("should load an array of buffers", {
                boxObject.buffers.length.should.be(1);
                boxObject.buffers[0].uri.should.be("Box0.bin");
                boxObject.buffers[0].data.should.be(boxBin);
            });

            it("should load an array of buffer views", {
                boxObject.bufferViews.length.should.be(2);
                boxObject.bufferViews[0].buffer.should.be(boxObject.buffers[0]);
                boxObject.bufferViews[0].byteLength.should.be(72);
            });

            it("should load an array of accessors", {
                boxObject.accessors.length.should.be(3);

                boxObject.accessors[0].componentType.should.be(gltf.schema.TComponentType.UNSIGNED_SHORT);
                boxObject.accessors[0].type.should.be(gltf.schema.TAttributeType.SCALAR);

                boxObject.accessors[1].componentType.should.be(gltf.schema.TComponentType.FLOAT);
                boxObject.accessors[1].type.should.be(gltf.schema.TAttributeType.VEC3);

                boxObject.accessors[2].componentType.should.be(gltf.schema.TComponentType.FLOAT);
                boxObject.accessors[2].type.should.be(gltf.schema.TAttributeType.VEC3);
            });

            it("should load an array of cameras", {
                // TODO: better model test for cameras
                boxObject.cameras.length.should.be(0);
            });

            it("should load an array of meshes", {
                boxObject.meshes.length.should.be(1);
                boxObject.meshes[0].primitives.length.should.be(1);
                boxObject.meshes[0].primitives[0].attributes.length.should.be(2);
                boxObject.meshes[0].primitives[0].indices.should.not.be(null);
                
                var foundPosition:Bool = false;
                var foundNormal:Bool = false;
                for(a in boxObject.meshes[0].primitives[0].attributes) {
                    if(a.name == "POSITION") foundPosition = true;
                    else if(a.name == "NORMAL") foundNormal = true;
                }
                foundPosition.should.be(true);
                foundNormal.should.be(true);
                
                //trace('indices: ' + boxObject.meshes[0].primitives[0].getIndexValues());
                //trace('positions: ' + boxObject.meshes[0].primitives[0].getFloatAttributeValues("POSITION"));
                //trace('normals: ' + boxObject.meshes[0].primitives[0].getFloatAttributeValues("NORMAL"));
            });

            it("should load an array of skins", {
                riggedSimpleObject.skins.length.should.be(1);
                riggedSimpleObject.skins[0].skeleton.should.not.be(null);
                riggedSimpleObject.skins[0].joints.length.should.be(2);
                riggedSimpleObject.skins[0].inverseBindMatrices.length.should.be(2);
            });

            it("should load an array of nodes", {
                boxObject.nodes.length.should.be(2);
                boxObject.nodes[0].children.length.should.be(1);
                boxObject.nodes[0].matrix.should.not.be(null);
                boxObject.nodes[1].mesh.should.not.be(null);
            });

            it("should load an array of scenes and set the default scene", {
                boxObject.scenes.length.should.be(1);
                boxObject.scenes[0].nodes.length.should.be(1);
                boxObject.scenes[0].nodes[0].should.be(boxObject.nodes[0]);
                boxObject.defaultScene.should.be(boxObject.scenes[0]);
            });

            it("should load an array of images", {
                boxTexturedObject.images.length.should.be(1);
                boxTexturedObject.images[0].uri.should.be("CesiumLogoFlat.png");
            });

            it("should load an array of samplers", {
                boxTexturedObject.samplers.length.should.be(1);
                boxTexturedObject.samplers[0].magFilter.should.be(gltf.schema.TMagFilter.LINEAR);
            });

            it("should load an array of textures", {
                boxTexturedObject.textures.length.should.be(1);
                boxTexturedObject.textures[0].image.should.be(boxTexturedObject.images[0]);
                boxTexturedObject.textures[0].sampler.should.be(boxTexturedObject.samplers[0]);
            });

            it('should load all nodes', {
                riggedSimpleObject.nodes.length.should.be(5);
            });

            it('should load the skins appropriately', {
                riggedSimpleObject.nodes[1].skin.should.be(riggedSimpleObject.skins[0]);
            });

            it("should load animations");
        });
    }
}
