package net.pyogenics.TanksEditor
{
    import flash.display.Sprite;
    import alternativa.engine3d.core.Camera3D;
    import alternativa.engine3d.core.Object3D;
    import alternativa.engine3d.core.View;
    import flash.display.Stage3D;
    import alternativa.engine3d.core.Resource;
    import flash.events.Event;
    import spark.core.SpriteVisualElement;
    import alternativa.engine3d.primitives.Box;
    import alternativa.engine3d.materials.FillMaterial;

    public class Scene3D extends SpriteVisualElement
    {
        private var scene:Object3D;
        private var camera:Camera3D;
        private var _view:View;

        private var stage3D:Stage3D;

        public function Scene3D()
        {
            trace("Setup Scene3D");
            
            scene = new Object3D();
            camera = new Camera3D(0.1, 1000);
            _view = new View(400, 400);
            camera.view = _view;
            scene.addChild(camera);
        
            addChild(camera.view);
            addChild(camera.diagram);
        
            // Something to look at
            var box:Box = new Box();
            box.setMaterialToAllSurfaces(
                new FillMaterial(0xFF0000)
            );
            scene.addChild(box);
        }

        public function run(stage3D:Stage3D):void
        {
            trace("Run Scene3D");
            this.stage3D = stage3D;

            for each (var resource:Resource in this.scene.getResources(true)){
				resource.upload(this.stage3D.context3D);
			}

            trace("Enter frame");
            stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
        }

        private function enterFrame(event:Event):void
        {
            camera.render(stage3D);
        }
    }
}