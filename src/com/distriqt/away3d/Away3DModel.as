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
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.AssetLibrary;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.Max3DSParser;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.SphereGeometry;
	import away3d.textures.BitmapTexture;
	import away3d.utils.Cast;
	
	
	/**	
	 *
	 */
	public class Away3DModel extends Sprite
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
		private var _loader				: Loader3D;
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 *  Constructor
		 */
		public function Away3DModel( stage3DProxy : Stage3DProxy )
		{
			super();
			this._stage3DProxy = stage3DProxy;
			initAway3D();
		}
		
		
		public function render():void 
		{
			_away3dView.render();
		}
		
		private static const MODEL_URL : String = "/assets/model/lowpolymountains/lowpolymountains.3ds";
//		private static const MODEL_URL : String = "/assets/model/lowpolycat/cat.3ds";
		
		
		private function initAway3D() : void
		{
			// Create the first Away3D view which holds the cube objects.
			_away3dView = new View3D();
			_away3dView.antiAlias = 4;
			_away3dView.camera.lens.far = 15000;
			_away3dView.stage3DProxy = _stage3DProxy;
			_away3dView.shareContext = true;
			
			_cameraController = new HoverController( _away3dView.camera, null, 0, 0, 100 );
			_cameraController.yFactor = 1;
			
			addChild(_away3dView);
			
			addChild(new AwayStats(_away3dView));
			
			Loader3D.enableParser(Max3DSParser);
			
			_loader = new Loader3D();
			_loader.addEventListener( AssetEvent.ASSET_COMPLETE, onAssetComplete);
			_loader.addEventListener( LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
//			_loader.load(new URLRequest('')); 
			_loader.load( new URLRequest( MODEL_URL ));
			
//			AssetLibrary.enableParser( Max3DSParser );
//			
//			
//			AssetLibrary.addEventListener( AssetEvent.ASSET_COMPLETE, onAssetComplete );
//			AssetLibrary.addEventListener( LoaderEvent.RESOURCE_COMPLETE, onResourceComplete );
//			AssetLibrary.addEventListener( LoaderEvent.LOAD_ERROR, onLoadError );
//			
////			AssetLibrary.load( new URLRequest( TEXTURE_URL ) );
//			AssetLibrary.load( new URLRequest( MODEL_URL ) );
		}
		
		
		
		private function onAssetComplete( event:AssetEvent ):void 
		{
		} 
		
		
		private function onResourceComplete( event:LoaderEvent ):void 
		{
			_away3dView.scene.addChild(_loader);

			addEventListener( Event.ENTER_FRAME, enterframeHandler );
		} 
		
		private function onLoadError( event:LoaderEvent ):void 
		{
			
		}
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		private function rand( min:Number, max:Number ):Number {
			return (max - min)*Math.random() + min;
		}
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		private function enterframeHandler( event:Event ):void 
		{
			_loader.rotationY += 0.15;
		}
		
	}
}