package com.alinakipoglu.utils.pathutils.interfaces {

	import flash.geom.Point;
	
	public interface IPathElement
	{
		function get length():Number;
		function getDeltaPosition(_delta:Number, _resultPoint:Point):void;
		function updateLength():void;
	}
}
