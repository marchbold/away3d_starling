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
package
{
	import com.distriqt.away3d.Away3DGlobe;
	import com.distriqt.starling.StarlingCheckerboardSprite;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.events.Stage3DEvent;
	
	import starling.core.Starling;
	
	
	[SWF(width="800", height="600", frameRate="60")]
	/**	
	 *
	 */
	public class Away3DStarlingTest extends Sprite
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//		
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var stage3DProxy : Stage3DProxy;
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 *  Constructor
		 */
		public function Away3DStarlingTest()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener( Event.RESIZE, stageResizeHandler );
			
			initProxies();
			
		}
		
		
		
		private function initProxies():void
		{
			// Create a new Stage3D proxy to contain the separate views
			stage3DProxy = Stage3DManager.getInstance(stage).getFreeStage3DProxy();
			stage3DProxy.addEventListener( Stage3DEvent.CONTEXT3D_CREATED, onContextCreated );
//			stage3DProxy.antiAlias = 8;
//			stage3DProxy.color = 0x0;
		}
		
		
		private function onContextCreated(event : Stage3DEvent) : void 
		{
			initAway3D();
			initStarling();
			
			stage3DProxy.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		
		
		//
		//	AWAY 3D
		//
		
		private var _away3dView : Away3DGlobe;
		
		/**
		 * Initialise the Away3D views
		 */
		private function initAway3D():void 
		{
			_away3dView = new Away3DGlobe( stage3DProxy );
			addChild( _away3dView );
//			_away3dView.resize( stage.stageWidth, stage.stageHeight );
		}
		
		
		
		//
		//	STARLING
		//
		
		private var _starling : Starling;
		
		/**
		 * Initialise the Starling sprites
		 */
		private function initStarling() : void
		{
			// Create the Starling scene 
			_starling = new Starling( 
				StarlingCheckerboardSprite, 
				stage, 
				stage3DProxy.viewPort, 
				stage3DProxy.stage3D 
			);
//			_starling.stage.stageWidth = stage.stageWidth;
//			_starling.stage.stageHeight = stage.stageHeight;
		}
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//

		
		
		private function stageResizeHandler( event:Event ):void 
		{
			trace( stage.stageWidth + "," + stage.stageHeight );
//			if (_away3dView) 
//			{
//				_away3dView.resize( stage.stageWidth, stage.stageHeight );
//			}
//			if (_starling) 
//			{
//				_starling.stage.stageWidth = stage.stageWidth;
//				_starling.stage.stageHeight = stage.stageHeight;
//			}
//			
//			if (stage3DProxy)
//			{
//				stage3DProxy.width = 
//				stage3DProxy.viewPort.width = stage.stageWidth;
//			
//				stage3DProxy.height = 
//				stage3DProxy.viewPort.height = stage.stageHeight;
//			}
		}
		
		
		
		private function onEnterFrame( event:Event ):void
		{
			// Update the scenes
			var starlingCheckerboardSprite:StarlingCheckerboardSprite = StarlingCheckerboardSprite.getInstance();
			if (starlingCheckerboardSprite)
				starlingCheckerboardSprite.update();
			
			
			// Render
			_starling.nextFrame();
			_away3dView.render();
				
		}
		
	}
}