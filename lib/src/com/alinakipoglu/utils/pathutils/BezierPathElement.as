package com.alinakipoglu.utils.pathutils {
	
	import flash.geom.Point;
	import com.alinakipoglu.utils.pathutils.interfaces.IPathElement;
	
	/**
	 * BezierPathElement.
	 * 
	 * Bezier Splines controlled by 4 points, starting and ending point and
	 * two control points.
	 * 
	 * @author alinakipoglu
	 */
	public class BezierPathElement implements IPathElement
	{
		/**
		 * Starting anchor point.
		 */		
		public var anchor1			:Point;
		
		/**
		 * Ending anchor point.
		 */		
		public var anchor2			:Point;
		
		/**
		 * Control point of starting anchor point. 
		 */		
		public var control1			:Point;
		
		/**
		 * Control point of ending anchor point.
		 */		
		public var control2			:Point;
		
		/**
		 * Calculated length of this spline. 
		 */		
		private var m_length		:Number;
		
		/**
		 * Constructor
		 */		
		public function BezierPathElement()
		{
			
		}
		
		/**
		 * Initializes this spline.
		 *  
		 * @param _anchor1 Starting anchor point.
		 * @param _control1 Control point of starting anchor point. 
		 * @param _control2 Control point of ending anchor point. 
		 * @param _anchor2 Ending anchor point.
		 */		
		public function init(_anchor1:Point, _control1:Point, _control2:Point, _anchor2:Point):void
		{
			anchor1		= _anchor1;
			control1	= _control1;
			anchor2		= _anchor2;
			control2	= _control2;
		}
		
		/**
		 * Returns poisition on spline at a given delta between 0 - 1.
		 *  
		 * @param _delta Delta between 0 - 1.
		 * @param _resultPoint Point data to fill result.
		 */		
		public function getDeltaPosition(_delta : Number, _resultPoint : Point):void
		{
			var _filteredDelta	:Number	= _delta;
			
			if(_delta < 0)
			{
				_filteredDelta	= 0;
			}
			
			if(_delta > 1)
			{
				_filteredDelta	= 1;
			}
			
			_resultPoint.x = Math.pow(_filteredDelta, 3) * (anchor2.x + 3 * (control1.x - control2.x) - anchor1.x) + 3 * Math.pow(_filteredDelta, 2) * (anchor1.x - 2 * control1.x + control2.x) + 3 * _filteredDelta * (control1.x - anchor1.x) + anchor1.x;
			_resultPoint.y = Math.pow(_filteredDelta, 3) * (anchor2.y + 3 * (control1.y - control2.y) - anchor1.y) + 3 * Math.pow(_filteredDelta, 2) * (anchor1.y - 2 * control1.y + control2.y) + 3 * _filteredDelta * (control1.y - anchor1.y) + anchor1.y;
		}
		
		/**
		 * Updates length of this spline. 
		 */		
		public function updateLength():void
		{
			m_length	= 0;
			
			var _tPositionCurrent	:Point	= new Point();
			var _tPositionOld		:Point	= new Point();
			
			getDeltaPosition(0, _tPositionOld);
			
			for(var i:int = 0; i <= 20; i++)
			{
				if(i)
				{
					var t	:Number	= i / 20;
					
					getDeltaPosition(t, _tPositionCurrent);
					
					m_length			+= distanceBetweenVertices(_tPositionCurrent, _tPositionOld);
					
					_tPositionOld.x		= _tPositionCurrent.x;
					_tPositionOld.y		= _tPositionCurrent.y;
				}
			}
		}
		
		/**
		 * @return Calculated length of this spline.
		 */		
		public function get length():Number
		{
			return m_length;
		}
		
		/**
		 * Calculates distance between two points.
		 *  
		 * @param _point1 Starting point
		 * @param _point2 Ending point
		 * @return Distance between given two points.
		 */		
		private function distanceBetweenVertices(_point1:Point, _point2:Point):Number
		{
			var dx		:Number	= _point1.x - _point2.x;
			var dy		:Number	= _point1.y - _point2.y;
			
			return Math.sqrt(dx * dx + dy * dy);
		}
	}
}
