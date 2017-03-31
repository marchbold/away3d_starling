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
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.SphereGeometry;
	import away3d.textures.BitmapTexture;
	import away3d.utils.Cast;
	
	
	/**	
	 *
	 */
	public class Away3DGlobe extends Sprite
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//		
		
		[Embed(source="/assets/texture/earth_diffuse.jpg")]
		public static var EarthSurfaceDiffuse:Class;
		
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var _stage3DProxy 		: Stage3DProxy;

		private var _away3dView 		: View3D;
		private var _cameraController 	: HoverController;
		private var _earth 				: ObjectContainer3D;
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 *  Constructor
		 */
		public function Away3DGlobe( stage3DProxy : Stage3DProxy )
		{
			super();
			this._stage3DProxy = stage3DProxy;
			initAway3D();
		}
		
		
		public function render():void 
		{
			_away3dView.render();
		}
		
		public function resize( width:int, height:int ):void 
		{
			_away3dView.width = width;
			_away3dView.height = height;
		}
		
		
		private function initAway3D() : void
		{
			// Create the first Away3D view which holds the cube objects.
			_away3dView = new View3D();
			_away3dView.antiAlias = 4;
			_away3dView.camera.lens.far = 15000;
			_away3dView.stage3DProxy = _stage3DProxy;
			_away3dView.shareContext = true;
			
			_cameraController = new HoverController( _away3dView.camera, null, 0, 0, 300 );
			_cameraController.yFactor = 1;
			
			addChild(_away3dView);
			
//			addChild( new AwayStats( _away3dView ) );
			
			
			var earthSurfaceTexture:BitmapTexture = Cast.bitmapTexture( EarthSurfaceDiffuse );
			var earthSurfaceMaterial:TextureMaterial = new TextureMaterial( earthSurfaceTexture );
			var earthSurfaceGeometry:SphereGeometry = new SphereGeometry( 100, 200, 100 );
			var earthSurfaceMesh:Mesh = new Mesh( earthSurfaceGeometry, earthSurfaceMaterial );

			_earth = new ObjectContainer3D();
			_earth.rotationY = 200;
			_earth.addChild( earthSurfaceMesh );
			
			_away3dView.scene.addChild( _earth );
			
			
			addEventListener( Event.ENTER_FRAME, enterframeHandler );
		}
		

		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		private function rand( min:Number, max:Number ):Number
		{
			return (max - min)*Math.random() + min;
		}
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		private function enterframeHandler( event:Event ):void 
		{
			_earth.rotationY += 0.15;
		}
		
	}
}