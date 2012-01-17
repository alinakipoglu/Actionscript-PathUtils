package com.alinakipoglu.utils.pathutils {

	import flash.geom.Point;
	import com.alinakipoglu.utils.pathutils.interfaces.IPathElement;
	
	/**
	 * QuadraticSplinePathElement
	 * 
	 * Quadratic splines controlled by 3 points,
	 * starting and ending and one control point. 
	 * 
	 * @author alinakipoglu
	 */	
	public class QuadraticSplinePathElement implements IPathElement
	{
		/**
		 * Starting point. 
		 */		
		public var startPointPosition		:Point;
		
		/**
		 * Control point. 
		 */		
		public var controlPointPosition		:Point;
		
		/**
		 * Ending point.
		 */		
		public var endPointPosition			:Point;
		
		/**
		 * Calculated length of this spline. 
		 */		
		private var m_length				:Number;
		
		/**
		 * Constructor.
		 */		
		public function QuadraticSplinePathElement()
		{
			
		}
		
		/**
		 * Initializes this spline 
		 * @param _startPointPosition Starting point.
		 * @param _controlPointPosition Control point.
		 * @param _endPointPosition Ending point.
		 */		
		public function init(_startPointPosition:Point, _controlPointPosition:Point, _endPointPosition:Point):void
		{
			startPointPosition = _startPointPosition;
			controlPointPosition = _controlPointPosition;
			endPointPosition = _endPointPosition;
		}
		
		/**
		 * Returns poisition on spline at a given delta between 0 - 1.
		 *  
		 * @param _delta Delta between 0 - 1.
		 * @param _resultPoint Point data to fill result.
		 */
		public function getDeltaPosition(_delta:Number, _resultPoint:Point):void
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
			
			_resultPoint.x	= startPointPosition.x + _filteredDelta * (2 * (1 - _filteredDelta) * (controlPointPosition.x - startPointPosition.x) + _filteredDelta * (endPointPosition.x - startPointPosition.x));
			_resultPoint.y	= startPointPosition.y + _filteredDelta * (2 * (1 - _filteredDelta) * (controlPointPosition.y - startPointPosition.y) + _filteredDelta * (endPointPosition.y - startPointPosition.y));
		}
		
		/**
		 * Updates length of this spline. 
		 */		
		public function updateLength():void
		{
			m_length	= 0;
			
			var _tPositionCurrent	:Point			= new Point();
			var _tPositionOld		:Point			= new Point();
			
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
		 * @return Calculated length.
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