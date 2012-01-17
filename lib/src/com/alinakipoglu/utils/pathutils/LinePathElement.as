package com.alinakipoglu.utils.pathutils {

	import flash.geom.Point;
	import com.alinakipoglu.utils.pathutils.interfaces.IPathElement;
	
	/**
	 * LinePathElement.
	 * 
	 * @author alinakipoglu
	 */	
	public class LinePathElement implements IPathElement
	{
		/**
		 * Staring Point 
		 */		
		public var startPoint				:Point;
		
		/**
		 * Ending Point 
		 */		
		public var endPoint					:Point;
		
		/**
		 * Calculated length of this line 
		 */		
		private var m_length				:Number;
		
		/**
		 * Constructor
		 */		
		public function LinePathElement()
		{
		}
		
		/**
		 * Initializes this line.
		 *  
		 * @param _startPointPosition Staring Point.
		 * @param _endPointPosition Ending Point.
		 */		
		public function init(_startPointPosition:Point, _endPointPosition:Point):void
		{
			startPoint = _startPointPosition;
			endPoint = _endPointPosition;
		}
		
		/**
		 * Returns poisition on line at a given delta between 0 - 1.
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
			
			_resultPoint.x	= startPoint.x + ((endPoint.x - startPoint.x) * _delta);
			_resultPoint.y	= startPoint.y + ((endPoint.y - startPoint.y) * _delta);
		}
		
		/**
		 * Updates length of this line. 
		 */	
		public function updateLength() : void
		{
			var dx		:Number	= startPoint.x - endPoint.x;
			var dy		:Number	= startPoint.y - endPoint.y;
			
			m_length			= Math.sqrt(dx * dx + dy * dy);
		}
		
		/**
		 * @return Calculated length.
		 */	
		public function get length():Number
		{
			return m_length;
		}
	}
}
