package com.alinakipoglu.utils.pathutils.interfaces {

	public interface IPathSequence extends IPathElement
	{
		function addPathElement(_pathElement:IPathElement):void;
		function removePathElement(_pathElement:IPathElement):void;
	}
}
