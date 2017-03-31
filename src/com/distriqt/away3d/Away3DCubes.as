/**
 *        __       __               __ 
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / / 
 * \__,_/_/____/_/ /_/  /_/\__, /_/ 
 *                           / / 
 *                           \/ 
 * http://distriqt.com
 *
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.away3d
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.WireframePlane;
	import away3d.textures.BitmapTexture;
	
	
	/**	
	 *
	 */
	public class Away3DCubes extends Sprite
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//		
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var stage3DProxy : Stage3DProxy;
		
		
		private var _away3dView 	: View3D;
		
		private var _cameraController : HoverController;
		
		private var cubeMaterial : TextureMaterial;
		
		private var cube1 : Mesh;
		private var cube2 : Mesh;
		private var cube3 : Mesh;
		private var cube4 : Mesh;
		private var cube5 : Mesh;
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 *  Constructor
		 */
		public function Away3DCubes( stage3DProxy : Stage3DProxy )
		{
			super();
			this.stage3DProxy = stage3DProxy;
			initAway3D();
		}
		
		
		public function render():void 
		{
			_away3dView.render();
		}
		
		
		private function initAway3D() : void
		{
			// Create the first Away3D view which holds the cube objects.
			_away3dView = new View3D();
			_away3dView.antiAlias = 4;
			_away3dView.camera.lens.far = 15000;
			_away3dView.stage3DProxy = stage3DProxy;
			_away3dView.shareContext = true;
			
			_cameraController = new HoverController( _away3dView.camera, null, 0, 0, 3000 );
			_cameraController.yFactor = 1;
			
			addChild(_away3dView);
			
			addChild(new AwayStats(_away3dView));
			
			// Create Material
			var cubeBmd:BitmapData = new BitmapData(128, 128, false, 0x0);
			cubeBmd.perlinNoise(7, 7, 5, 12345, true, true, 7, true);
			cubeMaterial = new TextureMaterial(new BitmapTexture(cubeBmd));
			cubeMaterial.gloss = 20;
			cubeMaterial.ambientColor = 0x808080;
			cubeMaterial.ambient = 1;
			
			// Create some Cubes
			var cG:CubeGeometry = new CubeGeometry(300, 300, 300);
			cube1 = new Mesh(cG, cubeMaterial);
			cube2 = new Mesh(cG, cubeMaterial);
			cube3 = new Mesh(cG, cubeMaterial);
			cube4 = new Mesh(cG, cubeMaterial);
			cube5 = new Mesh(cG, cubeMaterial);
			
			// Arrange them in a circle with one on the center
			cube1.x = -750; 
			cube2.z = -750;
			cube3.x = 750;
			cube4.z = 750;
			cube1.y = cube2.y = cube3.y = cube4.y = cube5.y = 150;
			
			// Add the cubes to view 1
			_away3dView.scene.addChild(cube1);
			_away3dView.scene.addChild(cube2);
			_away3dView.scene.addChild(cube3);
			_away3dView.scene.addChild(cube4);
			_away3dView.scene.addChild(cube5);
			_away3dView.scene.addChild(new WireframePlane(2500, 2500, 20, 20, 0xbbbb00, 1.5, WireframePlane.ORIENTATION_XZ));
		}
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		
	}
}