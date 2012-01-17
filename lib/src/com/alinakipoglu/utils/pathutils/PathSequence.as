package com.alinakipoglu.utils.pathutils {

	import flash.geom.Point;
	import com.alinakipoglu.utils.pathutils.interfaces.IPathElement;
	import com.alinakipoglu.utils.pathutils.interfaces.IPathSequence;
	
	/**
	 * PathSequence provides same IPathSequence methods with 
	 * sequencing and nesting support. Any IPathSequence data or
	 * IPathElement data is supported.
	 * 
	 * @author alinakipoglu
	 */	
	public class PathSequence implements IPathSequence
	{
		/**
		 * Nested paths currently this instance contains. 
		 */		
		public var paths				:Array;
		
		/**
		 * Currently processing path element.
		 */		
		private var currentPathElement	:IPathElement;
		
		/**
		 * Calculated total length of this sequence. 
		 */		
		private var m_length			:Number;
		
		/**
		 * Calculated ratios (TotalLength / Path[i-1].length + Path[i].length);
		 */		
		private var m_lengthRatios		:Array;
		
		/**
		 * Constructor
		 */		
		public function PathSequence():void
		{
			paths				= [];
			m_lengthRatios		= [];
		}
		
		/**
		 * Adds specified path element.
		 * @param _pathElement Path Element.
		 */		
		public function addPathElement(_pathElement:IPathElement):void
		{
			paths[paths.length] = _pathElement;
			
			update();
		}
		
		/**
		 * Removes specified path element.
		 * @param _pathElement
		 */		
		public function removePathElement(_pathElement : IPathElement):void
		{
			var _pathIndex		:uint = paths.indexOf(_pathElement);
			
			if(_pathIndex != -1)
			{
				paths.splice(_pathIndex, 1);
			}
			
			update();
		}
		
		/**
		 * Returns poisition on path element at a given delta between 0 - 1.
		 *  
		 * @param _delta Delta between 0 - 1.
		 * @param _resultPoint Point data to fill result.
		 */
		public function getDeltaPosition(_delta:Number, _resultPoint:Point):void
		{
			var _pathCount	:uint = paths.length;
			
			for(var i:uint = 0; i < _pathCount; i++)
			{
				if(i)
				{
					if(_delta > m_lengthRatios[i - 1] && _delta <= m_lengthRatios[i])
					{
						currentPathElement	= paths[i];
						paths[i].getDeltaPosition((_delta - m_lengthRatios[i - 1]) / (m_lengthRatios[i] - m_lengthRatios[i - 1]), _resultPoint);
					}
				} else {
					if(_delta < m_lengthRatios[0])
					{
						paths[i].getDeltaPosition(_delta / m_lengthRatios[i], _resultPoint); 
						currentPathElement	= paths[i];
					}
				}
			}
		}
		
		/**
		 * Updates length of this path sequence. 
		 */	
		public function updateLength():void
		{
			m_length	= 0;
			
			var _pathCount	:uint = paths.length;
			
			for(var i:uint = 0; i < _pathCount ; i++)
			{
				
				paths[i].updateLength();
				
				m_length += paths[i].length;
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
		 * Updates ratios.
		 */		
		private function update():void
		{
			updateLength();
			
			var _length		:Number = m_length;
			var _pathCount	:uint = paths.length;
			
			for(var i:int = 0; i < _pathCount; i++)
			{
				if(i)
				{
					m_lengthRatios[i] = m_lengthRatios[i - 1] + paths[i].length / _length;
				} else {
					m_lengthRatios[i] = paths[i].length / _length;
				}
			}
		}
	}
}
