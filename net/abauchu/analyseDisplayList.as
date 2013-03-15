// Copyright Alexis Bauchu 2013
// Visit http://abauchu.net

package net.abauchu
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.utils.getQualifiedClassName;

	public function analyseDisplayList($container:DisplayObjectContainer, $max_depth:int, $spit_graph:Boolean):Object {
		var sub_result:Object;
		var i:int;
		var child:DisplayObject;
		var sub_depth:int = 0;
		var result:Object = {
			depth: 0,
			count: 1,
			max_width: Math.max(1, $container.numChildren),
			graphviz: ""
		};
		
		function get_unique_name($obj:DisplayObject):String {
			if ($obj is Stage) {
				return "stage";
			}
			
			return $obj.name + " (" + getQualifiedClassName($obj) + ")";
			//  + $obj.x.toString() + "-" + $obj.y.toString();
		}
		
		if ($max_depth == 0) {
			return result;
		}
		else if ($max_depth == -1) {
			$max_depth = 0;
		}
		
		if ($container.numChildren > 0) {
			for (i = 0; i < $container.numChildren; i++) {
				child = $container.getChildAt(i);
				
				if ($spit_graph) {
					result.graphviz +=
						'"' + get_unique_name(child) + '" -> "' + get_unique_name($container) + '";';
				}
				
				if (child is DisplayObjectContainer)
				{
					sub_result = analyseDisplayList(child as DisplayObjectContainer, $max_depth - 1, $spit_graph);
					result.count += sub_result.count;
					sub_depth = Math.max(sub_depth, sub_result.depth);
					result.max_width = Math.max(sub_result.max_width, result.max_width);
					
					if ($spit_graph) {
						result.graphviz += sub_result.graphviz;
					}
				}
				else
				{
					result.count += 1;
				}
			}
			
			result.depth += sub_depth + 1;
		}
		
		return result;
	}
}
